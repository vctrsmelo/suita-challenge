//
//  UserInputView.swift
//  SuitabilityChat
//
//  Created by Victor S Melo on 07/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import UIKit

protocol UserInputViewDelegate: class {
    
    /// Called when user touches send button
    func didSend(value: String)
    
}

class UserInputView: UIView {
    
    // MARK: - Properties
    
    var textField: UITextField!
    var sendButton: UIButton!
    
    weak var delegate: UserInputViewDelegate?
    
    // MARK: -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func sendButtonTapped(_ sender: UIButton) {
        guard let text = textField.text else { return }
        delegate?.didSend(value: text)
    }
    
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
        
        sendButton.addTarget(self, action: #selector(self.sendButtonTapped(_:)), for: .touchUpInside)
        
        // constraints
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[sendButton]|", options: .alignAllCenterX, metrics: nil, views: ["sendButton": sendButton]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[sendButton(==50.0)]|", options: .alignAllCenterX, metrics: nil, views: ["sendButton": sendButton]))
    }
    
    private func setupTextField() {
        textField = UITextField()
        
        addSubview(textField)
        
        //constraints
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[textField]|", options: .alignAllCenterX, metrics: nil, views: ["textField": textField]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[textField][sendButton]", options: .alignAllLastBaseline, metrics: nil, views: ["textField": textField, "sendButton": sendButton]))
    }
    
}
