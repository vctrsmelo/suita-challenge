//
//  Sentence.swift
//  SuitabilityChat
//
//  Created by Victor Melo on 06/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import Foundation

typealias Sentence = (waitingTime: TimeInterval, text: String)

extension Array where Element == Sentence {
    func getText() -> String {
        
        let textArray = self.map({ (_, text) -> String in
            return text
        })
        
        return textArray.joined(separator: " ")
    }
}
