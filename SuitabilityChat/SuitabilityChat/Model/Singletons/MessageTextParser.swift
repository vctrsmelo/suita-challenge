//
//  MessageTextParser.swift
//  SuitabilityChat
//
//  Created by Victor S Melo on 06/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import Foundation

/// A struct with one static method to parse the text received from API to an array of tuples that will be sent to the interface.
struct MessageTextParser {
    
    private static let eraseToken  = "erase"
    
    /**
     Parse the parameter text, that is the message received from API request, to an array of tuples, where each tuple contains a first element that is the waiting time before start writing the second element, that is the sentence.
     - Parameters:
        - text: received from API request
     */
    static func parse(_ text: String) -> [MessageAction] {

        
        // split text using the tokens
        
        let splitTokens: [Character] = ["^","<",">"]
        let strings = splitByTokens(string: text, tokens: splitTokens)
        
        //create MessageActions
        
        let messageActions = strings.map{ return getMessageAction(from: $0) }
        
        //return MessageActions
        
        return messageActions
        
//        let timeSensibleSentences = text.components(separatedBy: "^")
//        var messageActionsString: [String] = []
//
//        for sentenceStr in timeSensibleSentences {
//            messageActionsString.append(contentsOf: sentenceStr.components(separatedBy: "<"))
//        }
//
//        if messageActionsString.isEmpty {
//            return []
//        }
//
//        var parsedText: [(waitingTime: TimeInterval, text: String)] = [(waitingTime: 0.0, text: messageActionsString.first!)]
//
//        messageActionsString.forEach { sentence in
//
//            if action == messageActionsString.first { return }
//
//            let splittedSentence = sentence.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: false)
//
//            guard let timeAsSubstring = splittedSentence.first, let time = TimeInterval(timeAsSubstring) else {
//                fatalError("Error while parsing into MessageTextParser")
//            }
//
//            let text = (splittedSentence.count > 1) ? String(splittedSentence[1]) : ""
//
//            parsedText.append((waitingTime: time, text: text))
//        }
//
//        return parsedText
    }
    
    /// Split the string by the tokens parameter.
    static private func splitByTokens(string: String, tokens: [Character]) -> [String] {
        
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
