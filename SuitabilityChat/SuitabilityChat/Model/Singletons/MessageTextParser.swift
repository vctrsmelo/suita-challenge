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
    
    private static let eraseToken  = "<erase>"
    
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
    
        // parse the string character by character
        // if the character is ^, adds next non integer character to splitIndexes
        // if the character is "<" or ">", adds it to splitIndexes
        // split the string by the indexes into splitIndexes
        // return the splitted string array

        var splitIndexes: [String.Index] = [string.startIndex]
        
        var i = 0
        while i < string.count {
            
            var index = string.index(string.startIndex, offsetBy: i)
            
            //if found time token
            if string[index] == "^" {
                index = string.index(after: index)
                //get next non int character or end of string

                while index < string.index(before: string.endIndex) && String(string[index]).isInt {
                    
                    //increment index
                    index = string.index(after: index)
                }
                
                //found blank space. Add it to splitIndexes
                splitIndexes.append(index)
                i += 1
                continue
            }
            
            if string[index] == "<" || string[index] == ">"{
                splitIndexes.append(index)
                
            }
            
            i += 1
        }

        var splittedString: [String] = []
        
        //there is no split index. Should return all string as one element.
        if splitIndexes.count == 1 {
            return ["\(string) ^0"]
        }
        
        //get the splitted strings
        while !(splitIndexes.count == 0) {
            
            var firstIndex = splitIndexes.first!
            
            //it is last sentence (but not last character only)
            if splitIndexes.count == 1 {
                
                if firstIndex != string.index(before: string.endIndex) {
                    splittedString.append(String(string[firstIndex...]))
                }
                
                break
            }
            
            splitIndexes = Array(splitIndexes.dropFirst())
        
            var endingIndex = String(string[splitIndexes.first!]).isInt ? splitIndexes.first! : string.index(before: splitIndexes.first!)
            
            // avoid adding one character strings.
            if firstIndex == string.index(before: endingIndex) {
                continue
            }
            
            // logic to not add "<" and ">" into splittedString
            if string[firstIndex] == ">" && firstIndex != string.index(before: string.endIndex) {
                firstIndex = string.index(after: firstIndex)

            }

            if endingIndex != string.index(before: string.endIndex) && string[string.index(after: endingIndex)] == ">" {
                endingIndex = string.index(after: endingIndex)
                
            }
            
            splittedString.append(String(string[firstIndex ... endingIndex]))

        }
        
        return splittedString
        
    }
    
    static private func getMessageAction(from messageString: String) -> MessageAction {
        
        // detect if it is sentence or erase action
        if messageString == eraseToken {
            return .eraseAll
        }
        
        let splittedSentence = messageString.split(separator: "^", maxSplits: 1, omittingEmptySubsequences: false)
        
        guard splittedSentence.count > 1, let waitingTime = TimeInterval(splittedSentence[1].trimmingCharacters(in: [" "])) else {
            
            //Does not exist waitTime
            let text = splittedSentence.joined(separator: " ")
            return MessageAction.write((waitingTime: 0, text: text))
        }
        
        let text = "\(splittedSentence[0])"
        return MessageAction.write((waitingTime: waitingTime, text: text))
        
    }
}

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}

