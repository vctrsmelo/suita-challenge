//
//  APIRequest.swift
//  SuitabilityChat
//
//  Created by Victor Melo on 05/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//
//swiftlint:disable identifier_name

/// Interface used to send data to API through POST method.
struct APIRequest: Codable {
    
    static let context = "suitability"

    static var id: String? {
        return ChatManager.shared.currentId
    }
    
    static var answers: [String: String] {
        return ChatManager.shared.answers
    }
    
    static var parameters: [String: Any] {
        return [
            "context": context,
            "id": id as Any,
            "answers": answers
        ]
    }
}
