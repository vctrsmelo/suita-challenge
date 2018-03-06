//
//  BotMessageView.swift
//  SuitabilityChat
//
//  Created by Victor S Melo on 06/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import UIKit

class BotMessageView: UIView, MessageView {
    
    // MARK: - Views Properties
    
    var iconImageViewContainer: UIView!
    var iconImageView: UIImageView!
    var messageTextView: MessageTextView!
    var stackView: UIStackView!
    
    // MARK: - Properties
    
    var textAlignment: NSTextAlignment {
        return .left
    }
    
    // MARK: -
    
    init(text: String, font: UIFont) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
        
        setupView(text: text, font: font)
        
        //adjust view frame according to the stackview size. It's needed because the height depends on the text length.
        // The frame height must be greater or equal to the icon height
        
        let frameHeight = (stackView.frame.height > iconImageView.frame.height) ? stackView.frame.height : iconImageView.frame.height
        self.heightAnchor.constraint(equalToConstant: frameHeight).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    func setupView(text: String, font: UIFont) {
        self.backgroundColor = UIColor.orange
        
        setupStackView()
        setupIcon()
        setupMessageTextView(text: text, font: font)
        
        adjustStackView()
    }
    
    private func setupStackView() {
        stackView = UIStackView()
        stackView.axis = .horizontal
        
        addSubview(stackView)
    }
    
    private func setupIcon() {
        
        iconImageViewContainer = UIView()
        iconImageViewContainer.widthAnchor.constraint(equalToConstant: iconContainerWidth).isActive = true
        
        iconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        iconImageView.backgroundColor = UIColor.red
        
        iconImageViewContainer.addSubview(iconImageView)
        stackView.addArrangedSubview(iconImageViewContainer)
    }
    
    /// Adjust the position of stackView. It is called after the subviews have been added into the stack view.
    private func adjustStackView() {

        // update stack view according to the text length
        
        var frame = CGRect(x: 0, y: 0, width: stackViewWidth, height: messageTextView.contentSize.height)
        frame.size.height = messageTextView.contentSize.height
        stackView.frame = frame
        
        // stack view should be aligned right (message sent by the user)
        
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        
    }
}
