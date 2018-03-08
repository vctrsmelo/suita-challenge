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
    var chatScrollView: UIScrollView!
    var userInputView: UserInputView!
    
    /// It keeps the list of messages to be sent by the bot. It will keep sending the messages until it is empty.
    private var botMessagesList: [[Sentence]] = [] {
        didSet {
            if !botMessagesList.isEmpty {
                let firstMessage = botMessagesList.first!
                let msg = BotMessageView(sentences: firstMessage, font: UIFont.systemFont(ofSize: 16), delegate: self)
                self.chatStackView.addArrangedSubview(msg)
            }
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setupStackView()
        setupUserInputView()
        
        ChatManager.shared.startChat {
            self.botMessagesList.append(contentsOf: $0.messagesAsSentences)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        chatScrollView.contentSize = CGSize(width: chatStackView.frame.width, height: chatStackView.frame.height)
        
    }
    
    // MARK: - View Setups
    
    private func setupScrollView() {
        chatScrollView = UIScrollView(frame: self.view.frame)
        chatScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chatScrollView)
        
        //constraints
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: .alignAllCenterX, metrics: nil, views: ["scrollView": chatScrollView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|", options: .alignAllCenterX, metrics: nil, views: ["scrollView": chatScrollView]))
        
    }
    
    private func setupStackView() {
        
        chatStackView = UIStackView(frame: self.view.frame)
        chatStackView.translatesAutoresizingMaskIntoConstraints = false
        chatStackView.axis = .vertical
        chatStackView.spacing = 20
        chatScrollView.addSubview(chatStackView)
        
        // constraints
        
        chatScrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[stackView]|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["stackView": chatStackView]))
        chatScrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[stackView]|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["stackView": chatStackView]))
        
    }
    
    private func setupUserInputView() {
        userInputView = UserInputView()
        userInputView.delegate = self
        self.view.addSubview(userInputView)
        
        userInputView.translatesAutoresizingMaskIntoConstraints = false
        
        // constraints
        
        userInputView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        userInputView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        userInputView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}

extension ChatViewController: MessageViewDelegate {
    func didFinishTyping() {
        // removing the first message, already sent, will start sending the next one, if exists, in botMessagesList
        botMessagesList.removeFirst()
    }
}

extension ChatViewController: UserInputViewDelegate {
    
    func didSend(value: String) {
        ChatManager.shared.getResponse(userAnswer: value) {
            self.botMessagesList.append(contentsOf: $0.messagesAsSentences)
        }
    }
}
