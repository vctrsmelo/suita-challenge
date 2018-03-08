//
//  UserInputViewDelegate.swift
//  SuitabilityChat
//
//  Created by Victor S Melo on 08/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import Foundation


protocol UserInputViewDelegate: class {
    
    /// Called when user touches send button
    func didSend(value: String)
    
}
