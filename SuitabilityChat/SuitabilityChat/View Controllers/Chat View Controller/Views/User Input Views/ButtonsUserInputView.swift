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
    var apiButtons: [APIButton] = []
    var buttons: [UIButton] = []
    
    var stackView: UIStackView!
    
    weak var delegate: UserInputViewDelegate?
    
    //keep the height defined by the frame on init
    private var _buttonHeight: CGFloat!
    
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
    
    ///should call init(height:,buttons:)
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(buttonHeight: CGFloat, buttons: [APIButton]) {
        _buttonHeight = buttonHeight
        apiButtons = buttons
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views Setup
    
    private func setupView() {
        self.backgroundColor = UIColor.purple
        
        _zeroHeightConstraint = self.heightAnchor.constraint(equalToConstant: 0)
        _zeroHeightConstraint?.priority = .required
        
        setupStackView()
        setupButtons()
    }
    
    private func setupStackView() {
        stackView = UIStackView(frame: self.frame)
        stackView.axis = .vertical
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        //constraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[stackView]|", options: .alignAllCenterX, metrics: nil, views: ["stackView": stackView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[stackView]|", options: .alignAllCenterX, metrics: nil, views: ["stackView": stackView]))
    }
    
    private func setupButtons() {
        
        var views: [String: UIView] = [:]
        var visualFormat: String = "V:|"
        
        for i in 0 ..< apiButtons.count {
            let button = UIButton()
            button.setTitle(apiButtons[i].label.title, for: .normal)
            
            stackView.addArrangedSubview(button)
            buttons.append(button)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            views["button\(i)"] = button
            visualFormat.append("[button\(i)(==\(_buttonHeight ?? 50.0))]")
        }
        
        visualFormat.append("|")
        stackView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: visualFormat, options: .alignAllCenterX, metrics: nil, views: views))
    }
    
    // MARK: -
    
    func present() {
        self.isHidden = false
    }
    
}
