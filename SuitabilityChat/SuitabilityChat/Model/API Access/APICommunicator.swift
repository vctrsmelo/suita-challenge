//
//  APICommunicator.swift
//  SuitabilityChat
//
//  Created by Victor Melo on 05/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import Alamofire

struct APICommunicator {
    
    static private let url = "https://dev-api.oiwarren.com/api/v2/conversation/message"
    
    static func request(completion: (_ response: APIResponse) -> Void) {
        
        Alamofire.request(url, method: .post, parameters: APIRequest().parameters, encoding: JSONEncoding.default).responseJSON { response in
            if let json = response.result.value {
                print("JSON \(json)")
            }
        }
    }

}
