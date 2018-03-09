//
//  TextUserInputView.swift
//  SuitabilityChat
//
//  Created by Victor S Melo on 08/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import UIKit

final class TextUserInputView: UIView, UserInputView {
    
    // MARK: - Properties
    
    var textField: UITextField!
    //var textInputs: [(api: APIInput, textField: UITextField)]!
    var sendButton: UIButton!
    
    //keep the height defined by the frame on init
    private var _height: CGFloat
    
    private var _zeroHeightConstraint: NSLayoutConstraint!
    
    // overrides isHidden to, instead of default hide, remove the height.
    // it's important for chat constraint in ChatViewController, that adjust it's size according to UserInputView top.
    override var isHidden: Bool {
        get {
            return super.isHidden
        }
        set {
            _zeroHeightConstraint.isActive = newValue
            
            self.setNeedsDisplay()
            self.setNeedsLayout()
            
            super.isHidden = newValue
        }
    }
    
    weak var delegate: UserInputViewDelegate?
    
    // MARK: -
    
    override init(frame: CGRect) {
        _height = frame.height
        super.init(frame: frame)
        
        setupView()
    }
    
    init(height: CGFloat) {
        _height = height
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func sendButtonTapped(_ sender: UIButton) {
        guard let text = textField.text else { return }
        delegate?.didSend(value: text)
        self.isHidden = true
    }
    
    // MARK: - View Setups
    
    private func setupView() {
        self.backgroundColor = UIColor.green
        
        _zeroHeightConstraint = self.heightAnchor.constraint(equalToConstant: 0)
        _zeroHeightConstraint?.priority = .required
        
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
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[sendButton(\(_height)@750)]|", options: .alignAllCenterX, metrics: nil, views: ["sendButton": sendButton]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[sendButton(==50.0)]|", options: .alignAllCenterX, metrics: nil, views: ["sendButton": sendButton]))
    }
    
    private func setupTextField() {
        textField = UITextField()
        
        addSubview(textField)
        
        //constraints
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[textField(\(_height)@750)]|", options: .alignAllCenterX, metrics: nil, views: ["textField": textField]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[textField][sendButton]", options: .alignAllBottom, metrics: nil, views: ["textField": textField, "sendButton": sendButton]))
    }
    
    // MARK: -
    
    func present(with keyboardType: UIKeyboardType) {
        self.textField.keyboardType = keyboardType
        self.isHidden = false
    }
}
