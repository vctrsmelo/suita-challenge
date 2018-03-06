//
//  MessageView.swift
//  SuitabilityChat
//
//  Created by Victor S Melo on 06/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import UIKit

protocol MessageView {
    var icon: UIImage! { get }
    var messageLabel: UILabel! { get }
    
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
    func setupMessageTextView(sentences: [Sentence], font: UIFont) {
        
        //Get the text from the sentences array
        
        let textArray = sentences.map({ (_, text) -> String in
            return text
        })
        
        let text = textArray.joined(separator: " ")
        
        messageTextView = MessageTextView()
        messageTextView.font = font
        messageTextView.text = text
        messageTextView.backgroundColor = UIColor.blue
        messageTextView.textAlignment = textAlignment
        messageTextView.isEditable = false
        
        messageTextView.frame = CGRect(x: 0, y: 0, width: messageBubbleWidth, height: messageTextView.contentSize.height)
        messageTextView.bubbleHeight = messageTextView.contentSize.height
        messageTextView.text = ""
        messageTextView.typeWrite(sentences, completionHandler: {
            print("terminou de digitar")
        })
        
        stackView.addArrangedSubview(messageTextView)
    }

}
