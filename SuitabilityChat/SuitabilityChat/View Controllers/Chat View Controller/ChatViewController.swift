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
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setupStackView()
        
        //Test
        
//        let sentences: [Sentence] = [
//            (waitingTime:1, text:"Oi Victor!"),
//            (waitingTime:2, text:"Esta é a segunda sentença!"),
//            (waitingTime:3, text:"Esta é a terceira sentença!"),
//            ]
//
//        let msg = UserMessageView(sentences: sentences, font: UIFont.systemFont(ofSize: 16))
        
        ChatManager.shared.startChat { (response) in

            let sentences = response.messages.map({ (message) -> [Sentence] in
                return MessageTextParser.parse(message.value)
            })
            
            let msg = BotMessageView(sentences: sentences.first!, font: UIFont.systemFont(ofSize: 16), delegate: self)
            self.chatStackView.addArrangedSubview(msg)
            
        }
        
//        chatStackView.addArrangedSubview(msg)
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
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: .alignAllCenterX, metrics: nil, views: ["scrollView": chatScrollView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|", options: .alignAllCenterX, metrics: nil, views: ["scrollView": chatScrollView]))
        
    }
    
    private func setupStackView() {
        
        chatStackView = UIStackView(frame: self.view.frame)
        chatStackView.translatesAutoresizingMaskIntoConstraints = false
        chatStackView.axis = .vertical
        
        chatStackView.spacing = 20
        
        chatScrollView.addSubview(chatStackView)
        
        chatScrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[stackView]|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["stackView": chatStackView]))
        chatScrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[stackView]|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["stackView": chatStackView]))
        
    }
}

extension ChatViewController: MessageViewDelegate {
    func didFinishTyping() {
        ChatManager.shared.getResponse(userAnswer: "Victor") { response in
            let sentences = response.messages.map({ (message) -> [Sentence] in
                return MessageTextParser.parse(message.value)
            })
            
            let msg = BotMessageView(sentences: sentences.first!, font: UIFont.systemFont(ofSize: 16), delegate: self)
            self.chatStackView.addArrangedSubview(msg)
        }
    }
}
