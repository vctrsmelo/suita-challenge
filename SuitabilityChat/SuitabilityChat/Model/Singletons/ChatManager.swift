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
    
//    private(set) var currentUserInputType: UserInputType?
    
    /// The user's answer for each chat state.
    private(set) var answers: [String: String] = [:]
    
    private init() { }
    
    // MARK: - Methods
    
    /// Start chat with bot, making the first API request to get the bot first message.
    func startChat(completion: @escaping (_ response: APIResponse) -> Void) {
        APICommunicator.request { response in
            self.currentId = response.id
            completion(response)
        }
    }
    
    /**
     Get the bot response according to the user answer parameter.
     - Precondition: use startChat before using getResponse.
     - Parameters:
        - userAnswer: the user answer for the current state.
        - completion: the response received from API according to userAnswer and current state.
    */
    func getResponse(userAnswer: String, completion: @escaping (_ response: APIResponse) -> Void) {
        
        guard let currentId = currentId else {
            fatalError("Need to start chat before use getResponse")
        }
        
        self.answers[currentId] = userAnswer
        
        APICommunicator.request { response in
            self.currentId = response.id
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
            
//            let url = (ChatManager.shared.currentId == "final") ? urlFinish : urlMessage
//            
//            Alamofire.request(url, method: .post, parameters: APIRequest().parameters, encoding: JSONEncoding.default).responseJSON { response in
//                guard let data = response.data else { return }
//
//                do {
//                    let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
//                    completion(apiResponse)
//                } catch {
//                    print("Couldn't complete API request: \(error.localizedDescription)")
//                }
//            }
            if let path = Bundle.main.path(forResource: "responseTest", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(apiResponse)
                } catch {
                    print("Couldn't fetch json: \(error.localizedDescription)")
                }
            }

        }
    }

}
