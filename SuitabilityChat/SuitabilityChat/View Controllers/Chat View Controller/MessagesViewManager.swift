//
//  MessagesDisplayManager.swift
//  SuitabilityChat
//
//  Created by Victor Melo on 10/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import UIKit

enum InputType {
    case text(apiInputs: [APIInput])
    case buttons([APIButton])
}

protocol MessagesDisplayManagerDelegate: class {
    func addMessageToView(_ messageView: UIView)
    func needToGetAnswer(_ inputType: InputType)
}

/// Manage the state of messages being displayed to the user. It's responsabilities include send messages and ask when user need to input value.
class MessagesDisplayManager {
    
    // MARK: - Properties
    var messagesList: [[MessageAction]] = []
    var expectedAnswer: InputType?
    
    weak var delegate: MessagesDisplayManagerDelegate?
    
    // MARK: - Init
    
    init(delegate: MessagesDisplayManagerDelegate?) {
        self.delegate = delegate
    }
    
    /// Send the messages to be displayed in the screen. The expectedAnswer parameter define the kind of answer the user will give when all messages are sent.
    func sendMessages(_ messageActions: [[MessageAction]], expectedAnswer: InputType?) {
        self.messagesList.append(contentsOf: messageActions)
        self.expectedAnswer = expectedAnswer
        
        sendNextMessage()
    }
    
    /// Send the next message from the messages list.
    private func sendNextMessage() {
        
        if !messagesList.isEmpty {
        
            let nextMessage = messagesList.first!
            let msg = BotMessageView(actions: nextMessage, font: UIFont.systemFont(ofSize: 16), delegate: self)
            delegate?.addMessageToView(msg)
            
            messagesList = Array(messagesList.dropFirst())
            
        } else {
            guard let expectedAnswer = expectedAnswer else { return }
            delegate?.needToGetAnswer(expectedAnswer)
        }
    }
}

extension MessagesDisplayManager: MessageViewDelegate {
    
    func didFinishTyping() {
        sendNextMessage()
    }
    
}
