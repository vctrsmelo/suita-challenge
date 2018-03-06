//
//  APIState.swift
//  SuitabilityChat
//
//  Created by Victor Melo on 05/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import Foundation

/// Represents each chat state. The rawValue is the API ID.
enum APIState: String, Codable {
    case name = "question_name"
    case age = "question_age"
    case interest = "question_interest"
    case preference = "question_preference"
    case income = "question_income"
    case read = "question_read"
    case investmentExperience = "question_investment_experience"
    case market = "question_market"
    case lottery = "question_lottery"
    case advice = "question_advice"
    case spend = "question_spend"
    case email = "question_email"
    case final = "final"
}
