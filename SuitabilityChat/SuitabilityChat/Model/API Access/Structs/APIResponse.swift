//
//  APIResponse.swift
//  SuitabilityChat
//
//  Created by Victor Melo on 05/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//
//swiftlint:disable identifier_name

/// APIResponse is the interface used to receive data from API
struct APIResponse: Codable {
    
    let id: String
    let messages: [APIMessage]
    let buttons: [APIButton]
    let inputs: [APIInput]
    let responses: [String]

    var messagesAsSentences: [[Sentence]] {
        let sentences = messages.map({ (message) -> [Sentence] in
            return MessageTextParser.parse(message.value)
        })
        return sentences
    }
}
