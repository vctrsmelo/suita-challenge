//
//  MessageView.swift
//  SuitabilityChat
//
//  Created by Victor S Melo on 06/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import UIKit

protocol MessageView: class {
    
    var iconImageViewContainer: UIView! { get set }
    var iconImageView: UIImageView! { get set }
    var messageTextView: UITextView! { get set }
    var stackView: UIStackView! { get set }
    
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
    
    func setupMessageTextView(text: String, font: UIFont, textAlignment: NSTextAlignment) {
        
        messageTextView = UITextView()
        messageTextView.font = font
        messageTextView.text = text
        messageTextView.backgroundColor = UIColor.blue
        messageTextView.textAlignment = textAlignment
        messageTextView.isEditable = false
        
        messageTextView.frame = CGRect(x: 0, y: 0, width: messageBubbleWidth, height: messageTextView.contentSize.height)
        
        stackView.addArrangedSubview(messageTextView)
    }
    
}
