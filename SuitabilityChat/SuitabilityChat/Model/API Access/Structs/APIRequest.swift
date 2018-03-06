//
//  APIPost.swift
//  SuitabilityChat
//
//  Created by Victor Melo on 05/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//
//swiftlint:disable identifier_name

import Foundation

/// APIPost is the interface used to send data to API
struct APIRequest: Codable {
    
    let context = "suitability"

    var id: String? {
        return ChatManager.shared.currentId
    }
    
    var answers: [String: String] {
        return ChatManager.shared.answers
    }
    
    var parameters: [String: Any] {
        return [
            "context": context,
            "id": id,
            "answers": answers
        ]
    }
    
}
