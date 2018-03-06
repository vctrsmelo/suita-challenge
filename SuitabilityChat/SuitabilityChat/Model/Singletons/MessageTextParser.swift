//
//  MessageTextParser.swift
//  SuitabilityChat
//
//  Created by Victor S Melo on 06/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import Foundation

struct MessageTextParser {
    
    static func parse(_ text: String) -> [(waitingTime: TimeInterval, text: String)] {
    
        let timeSensibleSentences = text.components(separatedBy: "^")
        
        if timeSensibleSentences.isEmpty {
            return []
        }
        
        var parsedText: [(waitingTime: TimeInterval, text: String)] = [(waitingTime: 0.0, text: timeSensibleSentences.first!)]
        
        timeSensibleSentences.forEach { sentence in
            
            if sentence == timeSensibleSentences.first { return }
            let splittedSentence = sentence.split(separator: " ")
            
            guard let timeAsSubstring = splittedSentence.first, let time = TimeInterval(timeAsSubstring) else {
                fatalError("Error while parsing into MessageTextParser")
            }
            
            let text = String(splittedSentence[1])
            
            parsedText.append((waitingTime: time, text: text))
        }
        
        return parsedText
    }
    
}
