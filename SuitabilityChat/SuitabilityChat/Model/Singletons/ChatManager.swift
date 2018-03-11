//
//  ChatManager.swift
//  SuitabilityChat
//
//  Created by Victor Melo on 05/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import Alamofire

/** A singleton class that keeps the chat information, including user's response and a state machine. It's accessed by API to get current state information.
*/
class ChatManager {
    
    // MARK: - Properties
    
    /// The singleton instance
    static let shared = ChatManager()
    
    /// The chat current state
    private(set) var currentId: String?
    let finalId = "final"

    /// The user's answer for each chat state.
    private(set) var answers: [String: String] = [:]

    /// Keep the container for user response that comes from API. Need to be parsed
    private(set) var userResponses: [String] = []
    
    private init() { }
    
    // MARK: - Methods
    
    /// Start chat with bot, making the first API request to get the bot first message.
    func startChat(completion: @escaping (_ response: APIResponse) -> Void) {
        APICommunicator.request { response in
            self.currentId = response.id
            self.userResponses = response.responses
            completion(response)
        }
    }
    
    /// Add the answer parameter to the answerId key. If answerId is nil, it will add the answer to currentId.
    func addAnswer(userAnswer: String, answerId: String? = nil) {
        guard let answerId = answerId else {
            guard let currentId = currentId else {
                fatalError("[ChatManager] addAnswer(userAnswer:,answerId:) couldn't find chat ID")
                return
            }
            
            answers[currentId] = userAnswer
            return
        }
        
        answers[answerId] = userAnswer
    }
    
    /**
     Get the bot response, considering the currentId and it's answer received from the user.
     - Precondition: use startChat before using getResponse.
     - Parameters:
        - completion: the response received from API according to userAnswer and current state.
    */
    func getResponse(completion: @escaping (_ response: APIResponse) -> Void) {
        
        guard currentId != nil else {
            fatalError("Need to start chat before use getResponse")
        }
        
        APICommunicator.request { response in
            self.currentId = response.id
            self.userResponses = response.responses
            completion(response)
        }
    }
    
    func getFinalResponse(completion: @escaping (_ response: APIProfileResultResponse) -> Void) {
        
        APICommunicator.requestFinalResult { (response) in
            completion(response)
        }
        
    }
}

extension ChatManager {

    /// APICommunicator shall not be used out of ChatManager
    fileprivate struct APICommunicator {
        
        static private let urlMessage = "https://dev-api.oiwarren.com/api/v2/conversation/message"
        static private let urlFinish = "https://dev-api.oiwarren.com/api/v2/suitability/finish"
        
        static func request(completion: @escaping (_ response: APIResponse) -> Void) {
            
            let url = urlMessage
            
            Alamofire.request(url, method: .post, parameters: APIRequest().parameters, encoding: JSONEncoding.default).responseJSON { response in
                guard let data = response.data else { return }

                do {
                    let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(apiResponse)
                } catch {
                    print("Couldn't complete API request: \(error.localizedDescription)")
                }
            }
//            if let path = Bundle.main.path(forResource: "responseTest", ofType: "json") {
//                do {
//                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                    let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
//                    completion(apiResponse)
//                } catch {
//                    print("Couldn't fetch json: \(error.localizedDescription)")
//                }
//            }

        }
        
        static func requestFinalResult(completion: @escaping (_ response: APIProfileResultResponse) -> Void) {
            
            let url = urlFinish
            
            Alamofire.request(url, method: .post, parameters: APIRequest().parameters, encoding: JSONEncoding.default).responseJSON { response in
                guard let data = response.data else { return }
                
                do {
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    let user = jsonResult!["user"] as? [String: Any]
                    let profile = user!["investmentProfile"]! as? [String: Any]
                    
                    guard let riskTolerance = profile!["computedRiskTolerance"] as? Int, let profileType = profile!["computedProfileType"] as? String else {
                        print("Couldn't fetch profile data from API")
                        return
                    }
                    
                    completion(APIProfileResultResponse(computedRiskTolerance: riskTolerance, computedProfileType: profileType))
                
                } catch {
                    print("Couldn't complete API final request: \(error.localizedDescription)")
                }
                
            }
            
        }
        
    }

}
