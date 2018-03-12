//
//  MessageAction.swift
//  SuitabilityChat
//
//  Created by Victor Melo on 10/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import Foundation

/// Represents an action made into a message. It can be write a sentence or erase all sentences already typed.
enum MessageAction {
    case eraseAll
    case write(Sentence)
}
