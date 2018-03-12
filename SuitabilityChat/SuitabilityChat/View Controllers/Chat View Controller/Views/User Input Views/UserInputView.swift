//
//  UserInputViewDelegate.swift
//  SuitabilityChat
//
//  Created by Victor S Melo on 08/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import UIKit

protocol UserInputViewDelegate: class {
    
    /**
    Called when user touches send button.
     - Parameters:
        - value: it is the saved value to be sent to API
        - answer: the message that will be shown into chat.
    */
    func userDidAnswer(value: String, answer: String)
    
}

protocol UserInputView: class {
    
    weak var delegate: UserInputViewDelegate? { get set }
    
}
