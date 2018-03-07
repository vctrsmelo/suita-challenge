//
//  MessageTextParser.swift
//  SuitabilityChat
//
//  Created by Victor S Melo on 06/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import Foundation

typealias BubbleMessage = [Sentence]

/// A struct with one static method to parse the text received from API to an array of tuples that will be sent to the interface.
struct MessageTextParser {
    
    /**
     Parse the parameter text, that is the message received from API request, to an array of tuples, where each tuple contains a first element that is the waiting time before start writing the second element, that is the sentence.
     - Parameters:
        - text: received from API request
     */
    static func parse(_ text: String) -> [Sentence] {
    
        let timeSensibleSentences = text.components(separatedBy: "^")
        
        if timeSensibleSentences.isEmpty {
            return []
        }
        
        var parsedText: [(waitingTime: TimeInterval, text: String)] = [(waitingTime: 0.0, text: timeSensibleSentences.first!)]
        
        timeSensibleSentences.forEach { sentence in
            
            if sentence == timeSensibleSentences.first { return }
            let splittedSentence = sentence.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: false)
            
            guard let timeAsSubstring = splittedSentence.first, let time = TimeInterval(timeAsSubstring) else {
                fatalError("Error while parsing into MessageTextParser")
            }
            
            let text = (splittedSentence.count > 1) ? String(splittedSentence[1]) : ""
            
            parsedText.append((waitingTime: time, text: text))
        }
        
        return parsedText
    }
    
}
