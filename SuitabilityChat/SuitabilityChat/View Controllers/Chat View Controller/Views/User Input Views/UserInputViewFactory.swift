//
//  UserInputViewFactory.swift
//  SuitabilityChat
//
//  Created by Victor S Melo on 08/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import Foundation

struct UserInputViewFactory {
    
    static func getUserInputView(inputType: UserInputType) -> UserInputView {
        switch inputType {
        case .text(let inputs):
            return TextUserInputView()
        case .buttons(let buttons):
            return ButtonsUserInputView()
        }
    }
}
