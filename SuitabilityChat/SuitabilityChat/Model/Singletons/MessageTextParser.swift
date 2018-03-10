//
//  MessageTextParser.swift
//  SuitabilityChat
//
//  Created by Victor S Melo on 06/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import Foundation

/// A struct with static methods relating to parse API texts.

struct MessageTextParser {
    
    private static let eraseToken  = "erase"
    
    /**
     Parse the parameter text, that is the message received from API request, to an array of tuples, where each tuple contains a first element that is the waiting time before start writing the second element, that is the sentence.
     - Parameters:
        - text: received from API request
     */
    static func parse(_ text: String) -> [MessageAction] {
        
        // split text using the tokens
        let splitTokens: [Character] = ["^", "<", ">"]
        let strings = splitByTokens(string: text, tokens: splitTokens)
        
        //create MessageActions
        let messageActions = strings.map { return getMessageAction(from: $0) }
        
        //return MessageActions
        return messageActions
    }
    
    /// Split the string by the tokens parameter.
    static func splitByTokens(string: String, tokens: [Character]) -> [String] {
        
        let splittedSubstring = string.split(whereSeparator: { character -> Bool in
            return tokens.contains(character)
        })
        
        return splittedSubstring.map { return String($0) }
    }
    
    static private func getMessageAction(from messageString: String) -> MessageAction {
        
        // detect if it is sentence or remove
        if messageString == eraseToken {
            return .eraseAll
        }
        
        let splittedSentence = messageString.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: false)
        
        guard let waitingTime = TimeInterval(splittedSentence[0]) else {
            
            //Does not exist waitTime
            let text = splittedSentence.joined(separator: " ")
            return MessageAction.write((waitingTime: 0, text: text))
        }
        
        let text = "\(splittedSentence[1])"
        return MessageAction.write((waitingTime: waitingTime, text: text))
        
    }
}
