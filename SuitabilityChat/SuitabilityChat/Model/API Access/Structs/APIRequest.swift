//
//  APIPost.swift
//  SuitabilityChat
//
//  Created by Victor Melo on 05/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//
//swiftlint:disable identifier_name

/// APIPost is the interface used to send data to API
struct APIRequest: Codable {
    
    let context = "suitability"

    var id: APIState {
        return ChatManager.shared.currentState
    }
    
    var answers: [APIState.RawValue: String] {
        return ChatManager.shared.answers
    }
    
    var parameters: [String: Any] {
        return [
            "context": context,
            "id": id.rawValue,
            "answers": answers
        ]
    }
    
}
