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
    var iconImageView: UIImageView!
    var messageTextView: UITextView!
    
    var textAlignment: NSTextAlignment {
        return .right
    }
    
    // MARK: - Properties for typewriting effect
    
    private var charCount: Int = 0
    private var timer: Timer?
    private var messageText: [String.Element] = []
    private var timePerCharacter: TimeInterval = 0
    
    // MARK: -
    
    /// horizontal stack view, used to add text bubble side by side with the icon image.
    var stackView: UIStackView!
    
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
        setupMessageTextView(text: text, font: font)
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
        
        iconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        iconImageView.backgroundColor = UIColor.red
        
        iconImageViewContainer.addSubview(iconImageView)
        stackView.addArrangedSubview(iconImageViewContainer)
    }
    
    /// Adjust the position of stackView. It is called after the subviews have been added into the stack view.
    private func adjustStackView() {
        let stackViewX = self.frame.width - stackViewWidth
        
        // update stack view according to the text length
        
        var frame = CGRect(x: stackViewX, y: 0, width: stackViewWidth, height: messageTextView.contentSize.height)
        frame.size.height = messageTextView.contentSize.height
        stackView.frame = frame

        // stack view should be aligned right (message sent by the user)
        
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        
    }

}

extension UserMessageView {
    
    func typeWrite(_ message: String, timePerCharacter: TimeInterval, completionHandler: () -> Void) {
        
        self.messageText = Array(message)
        self.charCount = 0
        self.timePerCharacter = timePerCharacter
        
        timer = Timer.scheduledTimer(timeInterval: timePerCharacter, target: self, selector: #selector(UserMessageView.typeLetter), userInfo: nil, repeats: true)
        
    }
    
    @objc private func typeLetter() {
        if charCount < messageText.count {
            messageTextView.text = "\(messageTextView.text!)\(messageText[charCount])"
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: timePerCharacter, target: self, selector: #selector(UserMessageView.typeLetter), userInfo: nil, repeats: false)
        } else {
            timer?.invalidate()
        }
        self.charCount += 1
    }
    
}
