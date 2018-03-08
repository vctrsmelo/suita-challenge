//
//  UserInputView.swift
//  SuitabilityChat
//
//  Created by Victor S Melo on 07/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import UIKit

class UserInputView: UIView {
    
    // MARK: - Properties
    
    var textField: UITextField!
    var sendButton: UIButton!
    
    // MARK: -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    // MARK: - View Setups
    
    private func setupView() {
        self.backgroundColor = UIColor.green
        
        setupSendButton()
        setupTextField()
        
    }
    
    private func setupSendButton() {
        sendButton = UIButton(type: .custom)
        
        sendButton.setTitle("Send", for: .normal)
        
        addSubview(sendButton)
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        sendButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    private func setupTextField() {
        textField = UITextField()
        
        addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}
