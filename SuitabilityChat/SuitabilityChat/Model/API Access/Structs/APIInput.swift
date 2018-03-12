//
//  APIInput.swift
//  SuitabilityChat
//
//  Created by Victor Melo on 05/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

/// Represents the "input" key value of the JSON returned from the API.
struct APIInput: Codable {
    let type: String
    let mask: String
}
