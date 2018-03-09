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
    
    var textInputs: [(api: APIInput, textField: UITextField)]!
    var sendButton: UIButton!
    
    var textFieldsStackView: UIStackView!
    
    //keep the height defined by the frame on init
    private var _textFieldHeight: CGFloat!
    
    private var _zeroHeightConstraint: NSLayoutConstraint!
    private var _fullHeightConstraint: NSLayoutConstraint?
    
    // overrides isHidden to, instead of default hide, remove the height.
    // it's important for chat constraint in ChatViewController, that adjust it's size according to UserInputView top.
    override var isHidden: Bool {
        get {
            return super.isHidden
        }
        set {
            _zeroHeightConstraint.isActive = newValue
            _fullHeightConstraint?.isActive = !newValue
            
            self.setNeedsDisplay()
            self.setNeedsLayout()
            
            super.isHidden = newValue
        }
    }
    
    weak var delegate: UserInputViewDelegate?
    
    // MARK: - View Life Cycle
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init() {
        // frame is unused. The size is defined through constraints.
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        _zeroHeightConstraint = self.heightAnchor.constraint(equalToConstant: 0)
        _zeroHeightConstraint?.priority = .required
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func sendButtonTapped(_ sender: UIButton) {

        let token = " "
        
        // Define text as one string of all textField texts, concatenated by the token constant defined above.
        // It ignores nil texts.
        let text = textInputs.map { return $0.textField.text ?? "" }.joined(separator: token)
        
        delegate?.didSend(value: text)
        self.isHidden = true
    }
    
    // MARK: - View Setups
    
    private func setupView() {
        self.backgroundColor = UIColor.green
        
        _zeroHeightConstraint = self.heightAnchor.constraint(equalToConstant: 0)
        _zeroHeightConstraint?.priority = .required
        
        setupSendButton()
        setupTextFieldsStackView()
        setupTextFields()

    }
    
    private func setupSendButton() {
        sendButton = UIButton(type: .custom)
        sendButton.setTitle("Send", for: .normal)
        addSubview(sendButton)
        
        sendButton.addTarget(self, action: #selector(self.sendButtonTapped(_:)), for: .touchUpInside)
        
        // constraints
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
    
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[sendButton(\(_textFieldHeight ?? 50.0)@750)]|", options: .alignAllCenterX, metrics: nil, views: ["sendButton": sendButton]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[sendButton(==50.0)]|", options: .alignAllCenterX, metrics: nil, views: ["sendButton": sendButton]))
    }
    
    private func setupTextFields() {
        
        // variables for constraints
        
        var views: [String: UIView] = [:]
        var verticalVisualFormat: String = "V:|"
        
        //configure each UIButton
        for i in 0 ..< textInputs.count {
            let textField = textInputs[i].textField
            
            textFieldsStackView.addArrangedSubview(textField)
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.backgroundColor = UIColor.brown
            textField.placeholder = "Enter text here"
            views["textField\(i)"] = textField
            verticalVisualFormat.append("[textField\(i)(==\(_textFieldHeight ?? 50.0))]")
        }
        
        // add constraints to all buttons
        
        textFieldsStackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "\(verticalVisualFormat)|", options: .alignAllCenterX, metrics: nil, views: views))
        
    }
    
    private func setupTextFieldsStackView() {
        textFieldsStackView = UIStackView()
        textFieldsStackView.axis = .vertical
        textFieldsStackView.alignment = .fill
        addSubview(textFieldsStackView)
        
        textFieldsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[textFieldsStackView][sendButton]", options: .alignAllBottom, metrics: nil, views: ["textFieldsStackView": textFieldsStackView, "sendButton": sendButton]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[textFieldsStackView]|", options: .alignAllBottom, metrics: nil, views: ["textFieldsStackView": textFieldsStackView]))
    }
    
    // MARK: -
    
    /*
     Present the TextUserInputView for the inputs parameter, using the textFieldHeight configuration.
     */
    func present(textFieldHeight: CGFloat, inputs: [APIInput]) {
        _textFieldHeight = textFieldHeight
        textInputs = inputs.map { return (api: $0, textField: UITextField()) }
        self.isHidden = false
        self.heightAnchor.constraint(equalToConstant: textFieldHeight*CGFloat(inputs.count)).isActive = true
        setupView()
    }

}
