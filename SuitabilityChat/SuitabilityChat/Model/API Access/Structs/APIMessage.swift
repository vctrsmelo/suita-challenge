//
//  APIMessage.swift
//  SuitabilityChat
//
//  Created by Victor Melo on 05/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

/// Represents a "message" key value of the JSON returned from the API.
struct APIMessage: Codable {
    let type: String
    let value: String
}
