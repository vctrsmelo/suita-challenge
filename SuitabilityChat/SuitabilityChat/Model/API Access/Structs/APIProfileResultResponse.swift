//
//  APIProfileResultResponse.swift
//  SuitabilityChat
//
//  Created by Victor Melo on 11/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import Foundation

///API response including just the needed data to show to the user.
struct APIProfileResultResponse: Codable {
    
    var computedRiskTolerance: Int
    var computedProfileType: String
    
}
