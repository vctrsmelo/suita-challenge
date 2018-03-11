//
//  UserMessageView.swift
//  SuitabilityChat
//
//  Created by Victor S Melo on 06/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import UIKit

class UserMessageView: UIView, MessageView {
    
    // MARK: - Properties
    
    var iconImageViewContainer: UIView!
    var iconLabel: UILabel!
    var messageTextView: MessageTextView!
    
    var textAlignment: NSTextAlignment {
        return .right
    }
    
    /// horizontal stack view, used to add text bubble side by side with the icon image.
    var stackView: UIStackView!
    
    // MARK: - View Life Cycle
    
    /**
     - Parameters:
        - text: the core text to display. Should be the user answer.
        - responseFormatting: It's a formatted context where text will be inserted. It comes from API.
        - font: the font used to display the text.
    */
    init(text: String, responseFormatting: String?, font: UIFont, delegate: MessageViewDelegate? = nil) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
    
        let message = MessageAction.write((waitingTime: 0.0, text: text))
        
        setupView(message: message, font: font)
        self.messageTextView.messageViewDelegate = delegate
        
        //adjust view frame according to the stackview size. It's needed because the height depends on the text length.
        self.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: stackView.frame.height)
        self.heightAnchor.constraint(equalToConstant: stackView.frame.height+20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views
    
    func setupView(message: MessageAction, font: UIFont) {
        setupStackView()
        setupMessageTextView(messageActions: [message], font: font, typingWriting: false)
        setupIcon()

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
        
        let userName: String? = ChatManager.shared.answers["question_name"]
        
        iconLabel = UILabel()
        iconLabel.text = (userName != nil && !userName!.isEmpty) ? String(describing: userName!.first!) : "U"
        iconLabel.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.2509803922, blue: 0.4196078431, alpha: 1)
        iconLabel.textAlignment = .center
        iconLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        iconLabel.textColor = UIColor.white
        iconLabel.layer.masksToBounds = true
        iconLabel.layer.cornerRadius = 12
        
        iconImageViewContainer.addSubview(iconLabel)
        stackView.addArrangedSubview(iconImageViewContainer)
        
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        
        iconLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
        iconLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        iconLabel.centerXAnchor.constraint(equalTo: iconImageViewContainer.centerXAnchor).isActive = true
        iconLabel.topAnchor.constraint(equalTo: iconImageViewContainer.topAnchor, constant: 5).isActive = true
    }
    
    /// Adjust the position of stackView. It is called after the subviews have been added into the stack view.
    private func adjustStackView() {
        let stackViewX = self.frame.width - stackViewWidth
        
        // update stack view according to the text length
        
        var frame = CGRect(x: stackViewX, y: 0, width: stackViewWidth, height: messageTextView.bubbleHeight)
        frame.size.height = messageTextView.bubbleHeight
    
        stackView.frame = frame

        // stack view should be aligned right (message sent by the user)
        
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        
    }
    
}
