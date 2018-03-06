//
//  APICommunicator.swift
//  SuitabilityChat
//
//  Created by Victor Melo on 05/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import Alamofire

// APICommunicator shall be accessible only inside ChatManager.
extension ChatManager {
    
    internal struct APICommunicator {
        
        static private let url = "https://dev-api.oiwarren.com/api/v2/conversation/message"
        
        static func request(completion: @escaping (_ response: APIResponse) -> Void) {
            Alamofire.request(url, method: .post, parameters: APIRequest().parameters, encoding: JSONEncoding.default).responseJSON { response in
                guard let data = response.data else { return }
                
                do {
                    let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(apiResponse)
                } catch {
                    print("Couldn't complete API request: \(error.localizedDescription)")
                }
            }
        }
    }
}
