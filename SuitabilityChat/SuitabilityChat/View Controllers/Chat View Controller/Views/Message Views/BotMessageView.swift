//
//  BotMessageView.swift
//  SuitabilityChat
//
//  Created by Victor S Melo on 06/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import UIKit

class BotMessageView: UIView, MessageView {
    
    // MARK: - Properties
    
    var iconImageViewContainer: UIView!
    var iconImageView: UIImageView!
    var messageTextView: MessageTextView!
    var stackView: UIStackView!
    
    // MARK: - Properties
    
    var textAlignment: NSTextAlignment {
        return .left
    }
    
    // MARK: -
    
    init(actions: [MessageAction], font: UIFont, delegate: MessageViewDelegate? = nil) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
        
        setupView(actions: actions, font: font)
        self.messageTextView.messageViewDelegate = delegate
        
        //adjust view frame according to the stackview size. It's needed because the height depends on the text length.
        self.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: stackView.frame.height)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        //the 20 below is the distance between message and next item. Useful to create space between message and input views.
        self.heightAnchor.constraint(equalToConstant: stackView.frame.height+20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    func setupView(actions: [MessageAction], font: UIFont) {
        setupStackView()
        setupIcon()
        setupMessageTextView(messageActions: actions, font: font)
        
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
        
        var frame = CGRect(x: 0, y: 0, width: stackViewWidth, height: messageTextView.bubbleHeight)
        frame.size.height = messageTextView.bubbleHeight
        stackView.frame = frame
        
        // stack view should be aligned right (message sent by the user)
        
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        
    }
}
