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
    
    let id: APIState
    let messages: [APIMessage]
    let buttons: [APIButton]
    let inputs: [APIInput]
    let responses: [String]
}
