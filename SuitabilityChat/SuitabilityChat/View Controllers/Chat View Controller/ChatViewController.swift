//
//  ChatViewController.swift
//  SuitabilityChat
//
//  Created by Victor S Melo on 06/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    enum InputViewType {
        case text(keyboardType: UIKeyboardType)
        case buttons
    }
    
    // MARK: - Properties
    var chatStackView: UIStackView!
    var chatScrollView: UIScrollView!

    var userInputViewContainer: UIView!
    var textUserInputView: TextUserInputView!
    var buttonsUserInputView: ButtonsUserInputView!
    
    /// It keeps the list of messages to be sent by the bot. It will keep sending the messages until it is empty.
    private var botMessagesList: [[Sentence]] = [] {
        didSet {
            if !botMessagesList.isEmpty {
                let firstMessage = botMessagesList.first!
                let msg = BotMessageView(sentences: firstMessage, font: UIFont.systemFont(ofSize: 16), delegate: self)
                self.chatStackView.addArrangedSubview(msg)
            } else {
    
                //buttonsUserInputView.present()
                //textUserInputView.present(with: keyboardType)
            }
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
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
    
    private func setupView() {
        setupUserInputViews()
        setupScrollView()
        setupStackView()

        showInputView(type: .text(keyboardType: .default))
    }
    
    private func setupUserInputViews() {
        setupUserInputViewContainer()
        setupTextUserInputView()
        setupButtonsUserInputView()

    }
    
    private func setupUserInputViewContainer() {
        userInputViewContainer = UIView()
        
        view.addSubview(userInputViewContainer)
        
        userInputViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[userInputViewContainer]|", options: .alignAllCenterX, metrics: nil, views: ["userInputViewContainer": userInputViewContainer]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[userInputViewContainer]|", options: .alignAllCenterX, metrics: nil, views: ["userInputViewContainer": userInputViewContainer]))
        
    }
    
    private func setupScrollView() {
        chatScrollView = UIScrollView(frame: self.view.frame)
        chatScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chatScrollView)
        
        //constraints
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: .alignAllCenterX, metrics: nil, views: ["scrollView": chatScrollView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView][userInputViewContainer]", options: .alignAllCenterX, metrics: nil, views: ["scrollView": chatScrollView, "userInputViewContainer": userInputViewContainer]))
        //view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[scrollView]-0@250-|", options: .alignAllCenterX, metrics: nil, views: ["scrollView": chatScrollView]))
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
    
    private func setupTextUserInputView() {
        let api1 = APIInput(type: "string", mask: "name")
//        let api2 = APIInput(type: "string", mask: "address")
        textUserInputView = TextUserInputView(textFieldHeight: 150.0, inputs: [api1])
        textUserInputView.delegate = self
        
        userInputViewContainer.addSubview(textUserInputView)
        
        textUserInputView.translatesAutoresizingMaskIntoConstraints = false
        
        // constraints
        
        userInputViewContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[textUserInputView]|", options: .alignAllCenterX, metrics: nil, views: ["textUserInputView": textUserInputView]))
        userInputViewContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[textUserInputView]|", options: .alignAllCenterX, metrics: nil, views: ["textUserInputView": textUserInputView]))
        
    }
    
    private func setupButtonsUserInputView() {
//        let api1 = APIButton(value: "button1", label: APILabel(title: "Label title 1"))
//        let api2 = APIButton(value: "button2", label: APILabel(title: "Label title 2"))
//        let api3 = APIButton(value: "button2", label: APILabel(title: "Label title 3"))
        buttonsUserInputView = ButtonsUserInputView(buttonHeight: 40.0, buttons: [])
        buttonsUserInputView.delegate = self
        
        userInputViewContainer.addSubview(buttonsUserInputView)
        
        buttonsUserInputView.translatesAutoresizingMaskIntoConstraints = false
        
        // constraints
        
        userInputViewContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[buttonsUserInputView]|", options: .alignAllCenterX, metrics: nil, views: ["buttonsUserInputView": buttonsUserInputView]))
        userInputViewContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[buttonsUserInputView]|", options: .alignAllCenterX, metrics: nil, views: ["buttonsUserInputView": buttonsUserInputView]))
    }
    
    // MARK: -
    
    private func showInputView(type: InputViewType) {
        switch type {
        case .text(let keyboardType):
            textUserInputView.present(with: keyboardType)
            buttonsUserInputView.isHidden = true
        case .buttons:
            buttonsUserInputView.present()
            textUserInputView.isHidden = true
        }
    }
    
}

extension ChatViewController: MessageViewDelegate {
    func didFinishTyping() {
        
        // removing the first message, that was already sent, will start sending the next one, if exists, in botMessagesList.
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
