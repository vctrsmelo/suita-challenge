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
        
        //Test
        
        let msg = UserMessageView(text: "Oi Victor Oi Victor Oi Victor Oi Victor Oi Victor Oi Victor Oi Victor Oi Victor Oi Victor Oi Victor ", font: UIFont.systemFont(ofSize: 16))
        
        chatStackView.addArrangedSubview(msg)
//        chatStackView.addArrangedSubview(UserMessageView(text: "Oi Victor 2", font: UIFont.systemFont(ofSize: 16)))
//        chatStackView.addArrangedSubview(UserMessageView(text: "Oi Victor 2 Oi Victor 2 Oi Victor 2 Oi Victor 2Oi Victor 2 Oi Victor 2 Oi Victor 2 Oi Victor 2Oi Victor 2 Oi Victor 2 Oi Victor 2 Oi Victor 2Oi Victor 2 Oi Victor 2 Oi Victor 2 Oi Victor 2", font: UIFont.systemFont(ofSize: 16)))
//        chatStackView.addArrangedSubview(BotMessageView(text: "Mensagem do bot", font: UIFont.systemFont(ofSize: 16)))
//        chatStackView.addArrangedSubview(UserMessageView(text: "Oi Victor 2 Oi Victor 2 Oi Victor 2 Oi Victor 2Oi Victor 2 Oi Victor 2 Oi Victor 2 Oi Victor 2Oi Victor 2 Oi Victor 2 Oi Victor 2 Oi Victor 2Oi Victor 2 Oi Victor 2 Oi Victor 2 Oi Victor 2", font: UIFont.systemFont(ofSize: 16)))
//        chatStackView.addArrangedSubview(BotMessageView(text: "Mensagem do bot", font: UIFont.systemFont(ofSize: 16)))
//        chatStackView.addArrangedSubview(UserMessageView(text: "Oi Victor 2 Oi Victor 2 Oi Victor 2 Oi Victor 2Oi Victor 2 Oi Victor 2 Oi Victor 2 Oi Victor 2Oi Victor 2 Oi Victor 2 Oi Victor 2 Oi Victor 2Oi Victor 2 Oi Victor 2 Oi Victor 2 Oi Victor 2", font: UIFont.systemFont(ofSize: 16)))
//        chatStackView.addArrangedSubview(BotMessageView(text: "Mensagem do bot", font: UIFont.systemFont(ofSize: 16)))
//        chatStackView.addArrangedSubview(UserMessageView(text: "Oi Victor 2 Oi Victor 2 Oi Victor 2 Oi Victor 2Oi Victor 2 Oi Victor 2 Oi Victor 2 Oi Victor 2Oi Victor 2 Oi Victor 2 Oi Victor 2 Oi Victor 2Oi Victor 2 Oi Victor 2 Oi Victor 2 Oi Victor 2", font: UIFont.systemFont(ofSize: 16)))
//        chatStackView.addArrangedSubview(BotMessageView(text: "Mensagem do boensagem do boensagem do boensagem do boensagem do boensagem do boensagem do boensagem do bot", font: UIFont.systemFont(ofSize: 16)))

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addStackViewConstraints()
    }
    
    // MARK: - View Setups
    
    private func setupScrollView() {
        chatScrollView = UIScrollView(frame: self.view.frame)
        chatScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chatScrollView)
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: .alignAllCenterX, metrics: nil, views: ["scrollView": chatScrollView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|", options: .alignAllCenterX, metrics: nil, views: ["scrollView": chatScrollView]))

    }
    
    private func setupStackView() {
        
        chatStackView = UIStackView(frame: self.view.frame)
        chatStackView.axis = .vertical
        
        self.view.addSubview(chatStackView)
    }
    
    private func addStackViewConstraints() {
        
        chatStackView.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: chatStackView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: chatStackView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: chatStackView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0)

        self.view.addConstraints([topConstraint, leadingConstraint, trailingConstraint])
    }
    
}
