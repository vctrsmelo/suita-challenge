//
//  UserInputViewDelegate.swift
//  SuitabilityChat
//
//  Created by Victor S Melo on 08/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import UIKit

protocol UserInputViewDelegate: class {
    
    /// Called when user touches send button
    func userDidAnswer(value: String)
    
}

protocol UserInputView: class {
    
    weak var delegate: UserInputViewDelegate? { get set }
    
}
