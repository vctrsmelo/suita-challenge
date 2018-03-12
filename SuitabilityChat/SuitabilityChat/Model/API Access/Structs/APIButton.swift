//
//  APIButton.swift
//  SuitabilityChat
//
//  Created by Victor Melo on 05/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

/// Represents the "button" key value of the JSON returned from the API.
struct APIButton: Codable {
    let value: String
    let label: APILabel
}
