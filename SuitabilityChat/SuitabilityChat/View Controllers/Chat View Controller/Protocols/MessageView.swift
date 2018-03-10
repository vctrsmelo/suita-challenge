//
//  MessageView.swift
//  SuitabilityChat
//
//  Created by Victor S Melo on 06/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import UIKit

protocol MessageViewDelegate: class {
    func didFinishTyping()
}

protocol MessageView: class {
    
    var iconImageViewContainer: UIView! { get set }
    var iconImageView: UIImageView! { get set }
    var messageTextView: MessageTextView! { get set }
    var stackView: UIStackView! { get set }
    var textAlignment: NSTextAlignment { get }
}

extension MessageView {
    
    var messageBubbleWidth: CGFloat {
        return 200.0
    }
    
    var iconContainerWidth: CGFloat {
        return 60.0
    }
    
    var stackViewWidth: CGFloat {
        return messageBubbleWidth+iconContainerWidth
    }
    
    /// Setup the text view, to adjust its height according to the content.
    func setupMessageTextView(messageActions: [MessageAction], font: UIFont) {
    
        messageTextView = MessageTextView()
        messageTextView.font = font
        messageTextView.text = messageActions.getText()
        messageTextView.backgroundColor = UIColor.blue
        messageTextView.textAlignment = textAlignment
        messageTextView.isEditable = false
        
        messageTextView.frame = CGRect(x: 0, y: 0, width: messageBubbleWidth, height: messageTextView.contentSize.height)
        messageTextView.bubbleHeight = messageTextView.contentSize.height
        messageTextView.text = ""
        
//        let messageActions = messageActions.map { return MessageAction.write((waitingTime: $0.waitingTime, text: $0.text)) }
        messageTextView.typeWrite(messageActions: messageActions)
        
        stackView.addArrangedSubview(messageTextView)
    }

}
