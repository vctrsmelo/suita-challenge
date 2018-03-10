//
//  ButtonsUserInputView.swift
//  SuitabilityChat
//
//  Created by Victor S Melo on 08/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import UIKit

final class ButtonsUserInputView: UIView, UserInputView {
    
    // MARK: - Properties
    
    var buttons: [(api: APIButton, view: UIButton)]!
    
    var buttonsStackView: UIStackView!
    
    weak var delegate: UserInputViewDelegate?
    
    //keep the height defined by the frame on init
    private var _buttonHeight: CGFloat!
    
    // overrides isHidden to, instead of default hide, remove the height.
    // it's important for chat constraint in ChatViewController, that adjust it's size according to UserInputView top.
    override var isHidden: Bool {
        get {
            return super.isHidden
        }
        set {
            
            self.setNeedsDisplay()
            self.setNeedsLayout()
            
            super.isHidden = newValue
        }
    }
    
    // MARK: - View Life Cycle
    
    ///should call init(height:,buttons:)
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func buttonTouched(_ sender: UIButton) {
        
        guard let value = buttons.first(where: {$0.api.label.title == sender.titleLabel?.text })?.api.value else {
            print("couldn't find button API to get value")
            return
        }
        
        self.isHidden = true
        delegate?.userDidAnswer(value: value)
    }
    
    // MARK: - Views Setup
    
    private func setupView() {
        self.backgroundColor = UIColor.purple
        
        setupStackView()
        setupButtons()
    }
    
    private func setupStackView() {
        buttonsStackView = UIStackView(frame: self.frame)
        buttonsStackView.axis = .vertical
        addSubview(buttonsStackView)
        
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        //constraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[stackView]|", options: .alignAllCenterX, metrics: nil, views: ["stackView": buttonsStackView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[stackView]|", options: .alignAllCenterX, metrics: nil, views: ["stackView": buttonsStackView]))
    }
    
    private func setupButtons() {
        // variables for constraints
        var views: [String: UIView] = [:]
        var visualFormat: String = "V:|"
        
        if buttons.count > 1 {
            visualFormat.append("[button0(==button1)]")
        } else {
            visualFormat.append("[button0]")
        }
        
        //configure each UIButton
        for i in 0 ..< buttons.count {
            let button = buttons[i].view
            button.setTitle(buttons[i].api.label.title, for: .normal)
            
            button.addTarget(self, action: #selector(self.buttonTouched(_:)), for: .touchUpInside)
            
            buttonsStackView.addArrangedSubview(button)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            views["button\(i)"] = button
            
            if i > 0 {
                visualFormat.append("[button\(i)(==button0)]")
            }
        }
        
        // add constraints to all buttons
        
        buttonsStackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "\(visualFormat)|", options: .alignAllCenterX, metrics: nil, views: views))
    }
    
    // MARK: -
    
    /*
     Present the ButtonsUserInputView for the buttons parameter, using the buttonHeight configuration.
    */
    func present(buttonHeight: CGFloat, buttons: [APIButton]) {
        self.buttons = buttons.map { return (api: $0, view: UIButton()) }
        self.isHidden = false

        let viewHeight = buttonHeight*CGFloat(buttons.count)
        self.heightAnchor.constraint(equalToConstant: viewHeight).isActive = true
        superview?.heightAnchor.constraint(equalToConstant: viewHeight).isActive = true

        setupView()
    }
    
}
