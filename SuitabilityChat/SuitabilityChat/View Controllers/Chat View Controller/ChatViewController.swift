//
//  ChatViewController.swift
//  SuitabilityChat
//
//  Created by Victor S Melo on 06/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    enum InputType {
        case text([APIInput])
        case buttons([APIButton])
    }
    
    // MARK: - Properties
    
    var chatStackView: UIStackView!
    var chatScrollView: UIScrollView!

    var userInputViewContainer: UIView!
    var textUserInputView: TextUserInputView!
    var buttonsUserInputView: ButtonsUserInputView!
    
    var bottomConstraint: NSLayoutConstraint?
    
    /// It keeps the list of messages to be sent by the bot, and the expected answer for when all messages are sent. It will keep sending the messages until it is empty.
    private var botMessagesInteraction: (messages:[[Sentence]], expectedAnswer: InputType?) = ([], nil) {
        didSet {
            if !botMessagesInteraction.messages.isEmpty {
                let firstMessage = botMessagesInteraction.messages.first!
                let msg = BotMessageView(sentences: firstMessage, font: UIFont.systemFont(ofSize: 16), delegate: self)
                self.chatStackView.addArrangedSubview(msg)
            } else {
                guard let expectedAnswer = botMessagesInteraction.expectedAnswer else { return }
                
                switch expectedAnswer {
                case .text(let inputs):
                    let customView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 44))
                    customView.backgroundColor = UIColor.red
                    textUserInputView.present(textFieldHeight: 50.0, inputs: inputs)
                    userInputViewContainer.heightAnchor.constraint(equalTo: textUserInputView.heightAnchor, multiplier: 1).isActive = true
                    adjustBottomConstraint(constant: 0)
                case .buttons(let buttons):
                    buttonsUserInputView.present(buttonHeight: 50.0, buttons: buttons)
                    userInputViewContainer.heightAnchor.constraint(equalTo: buttonsUserInputView.heightAnchor, multiplier: 1).isActive = true
                    adjustBottomConstraint(constant: 0)
                }
            }
        }
    }
    
    // MARK: - Init & Deinit
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupView()
        
        ChatManager.shared.startChat {
            if $0.inputs.count > 0 {
                self.botMessagesInteraction = (messages: $0.messagesAsSentences, expectedAnswer: .text($0.inputs))
                
            } else if $0.buttons.count > 0 {
                self.botMessagesInteraction = (messages: $0.messagesAsSentences, expectedAnswer: .buttons($0.buttons))
                
            } else {
                self.botMessagesInteraction = (messages: $0.messagesAsSentences, expectedAnswer: nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
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
        
        bottomConstraint = NSLayoutConstraint(item: userInputViewContainer, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint!)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[userInputViewContainer]|", options: .alignAllCenterX, metrics: nil, views: ["userInputViewContainer": userInputViewContainer]))

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
        textUserInputView = TextUserInputView()
        textUserInputView.delegate = self
        
        userInputViewContainer.addSubview(textUserInputView)
        
        textUserInputView.translatesAutoresizingMaskIntoConstraints = false
        
        // constraints
        
        userInputViewContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[textUserInputView]|", options: .alignAllCenterX, metrics: nil, views: ["textUserInputView": textUserInputView]))
        userInputViewContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[textUserInputView]|", options: .alignAllCenterX, metrics: nil, views: ["textUserInputView": textUserInputView]))
        
        
    }
    
    private func setupButtonsUserInputView() {
        buttonsUserInputView = ButtonsUserInputView()
        buttonsUserInputView.delegate = self
        
        userInputViewContainer.addSubview(buttonsUserInputView)
        
        buttonsUserInputView.translatesAutoresizingMaskIntoConstraints = false
        
        // constraints
        
        userInputViewContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[buttonsUserInputView]|", options: .alignAllCenterX, metrics: nil, views: ["buttonsUserInputView": buttonsUserInputView]))
        userInputViewContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[buttonsUserInputView]|", options: .alignAllCenterX, metrics: nil, views: ["buttonsUserInputView": buttonsUserInputView]))

    }
    
    // MARK: - Keyboard handling

    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        guard let keyboardInfo = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        chatScrollView.contentInset = contentInsets
        chatScrollView.scrollIndicatorInsets = contentInsets
        
        adjustBottomConstraint(constant: -keyboardSize.height)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        chatScrollView.contentInset = .zero
        chatScrollView.scrollIndicatorInsets = .zero
        adjustBottomConstraint(constant: userInputViewContainer.frame.height)
    }
    
    private func adjustBottomConstraint(constant: CGFloat) {
        
        bottomConstraint?.constant = constant
        
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            
            self.view.layoutIfNeeded()
            
        }) { _ in
            
        }
    }
}

extension ChatViewController: MessageViewDelegate {
    func didFinishTyping() {
        
        // removing the first message, that was already sent, will start sending the next one, if exists, in botMessagesList.
        botMessagesInteraction.messages.removeFirst()
    }
}

extension ChatViewController: UserInputViewDelegate {
    
    func userDidAnswer(value: String) {
        view.endEditing(true)
        
        ChatManager.shared.getResponse(userAnswer: value) { apiResponse in
            if apiResponse.inputs.count > 0 {
                self.botMessagesInteraction = (messages: apiResponse.messagesAsSentences,
                                               expectedAnswer: .text(apiResponse.inputs))
            } else if apiResponse.buttons.count > 0 {
                self.botMessagesInteraction = (messages: apiResponse.messagesAsSentences,
                                               expectedAnswer: .buttons(apiResponse.buttons))
            } else {
                self.botMessagesInteraction = (messages: apiResponse.messagesAsSentences,
                                               expectedAnswer: nil)
            }
            
        }
    }
}
