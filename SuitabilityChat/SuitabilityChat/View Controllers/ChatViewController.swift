//
//  ChatViewController.swift
//  SuitabilityChat
//
//  Created by Victor S Melo on 06/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    // MARK: - Properties
    var chatStackView: UIStackView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStackView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addStackViewConstraints()
    }
    
    // MARK: - View Setups
    private func setupStackView() {
        
        chatStackView = UIStackView(frame: self.view.frame)
        chatStackView.axis = .vertical
        
        self.view.addSubview(chatStackView)
    }
    
    private func addStackViewConstraints() {
        
        chatStackView.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: chatStackView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: chatStackView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: chatStackView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: chatStackView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        self.view.addConstraints([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
    }
    
}
