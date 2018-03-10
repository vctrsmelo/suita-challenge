//
//  Sentence.swift
//  SuitabilityChat
//
//  Created by Victor Melo on 06/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import Foundation

typealias Sentence = (waitingTime: TimeInterval, text: String)

extension Array where Element == MessageAction {
    func getText() -> String {
        
        var sentences: [Sentence] = []
        
        self.forEach { (messageAction) in
            switch messageAction {
            case .write(let sentence):
                sentences.append(sentence)
                
            default:
                break
            }
        }
        
        let textArray = sentences.map({ (_, text) -> String in
            return text
        })
        
        return textArray.joined(separator: " ")
    }
}
