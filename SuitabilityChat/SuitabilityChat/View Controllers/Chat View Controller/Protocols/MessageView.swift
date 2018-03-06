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
    
    func setupView(text: String, font: UIFont, messageLabelWidth: CGFloat)
    
}

extension MessageView {
    
}
