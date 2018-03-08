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
    var buttonA: UIButton!
    var buttonP: UIButton!
    var stackView: UIStackView!
    
    weak var delegate: UserInputViewDelegate?
    
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
    
    // MARK: - Views Setup
    
    private func setupView() {
        self.backgroundColor = UIColor.purple
        
        _zeroHeightConstraint = self.heightAnchor.constraint(equalToConstant: 0)
        _zeroHeightConstraint?.priority = .required
        
        setupStackView()
        setupButtonA()
        setupButtonP()
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[buttonA(==buttonP)]|", options: .alignAllCenterY, metrics: nil, views: ["buttonA": buttonA, "buttonP": buttonP]))
        
    }
    
    private func setupStackView() {
        stackView = UIStackView(frame: self.frame)
        stackView.axis = .vertical
        addSubview(stackView)
        
        //constraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[stackView]|", options: .alignAllCenterX, metrics: nil, views: ["stackView": stackView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[stackView]|", options: .alignAllCenterX, metrics: nil, views: ["stackView": stackView]))
    }
    
    private func setupButtonA() {
        buttonA = UIButton()
        buttonA.setTitle("Option A", for: .normal)
        stackView.addArrangedSubview(buttonA)
    }
    
    private func setupButtonP() {
        buttonP = UIButton()
        buttonP.setTitle("Option P", for: .normal)
        stackView.addArrangedSubview(buttonP)
    }
    
    // MARK: -
    
    func present() {
        self.isHidden = false
    }
    
}
