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
    
    /** Setup the text view, to adjust its height according to the content.
     - Parameters:
        - messageActions: the actions to occur in message, including writing sentences and erasing already typed texts.
        - font: text font
        - typingWriting: if true, will show message with typing writing effect.
    */
    func setupMessageTextView(messageActions: [MessageAction], font: UIFont, typingWriting: Bool) {
    
        messageTextView = MessageTextView()
        messageTextView.font = font
        messageTextView.text = messageActions.getText()
        messageTextView.textAlignment = textAlignment
        messageTextView.isEditable = false
        
        messageTextView.frame = CGRect(x: 0, y: 0, width: messageBubbleWidth, height: messageTextView.contentSize.height)
        messageTextView.bubbleHeight = messageTextView.contentSize.height
        messageTextView.text = ""
        
        if typingWriting {
            messageTextView.typeWrite(messageActions: messageActions)
        } else {
            messageTextView.text = messageActions.getText()
        }
        
        stackView.addArrangedSubview(messageTextView)
    }

}
