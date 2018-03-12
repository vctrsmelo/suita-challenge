//
//  MessageTextView.swift
//  SuitabilityChat
//
//  Created by Victor S Melo on 06/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import UIKit

class MessageTextView: UITextView {
    
    // MARK: - Properties
    
    private var typedCharCount: Int = 0
    private var currentSentence: [String.Element] = []
    private var nextSentences: [Sentence] = []
    private let timePerCharacter: TimeInterval = 0.02
    
    weak var messageViewDelegate: MessageViewDelegate?
    
    /// Keep the height of the bubble message, defined according to it's text content.
    var bubbleHeight: CGFloat = 0.0
    
    // MARK: -
    
    /// Write the message, adjusting the bot behavior to the messageActions.
    func typeWrite(messageActions: [MessageAction]) {

        //if there are no sentences left, return
        guard let firstAction = messageActions.first else {
            
            messageViewDelegate?.didFinishTyping()
            return
        }
        
        switch firstAction {
        case .eraseAll:
            eraseAllTypedMessage {
                let nextActions = Array(messageActions.dropFirst())
                self.typeWrite(messageActions: nextActions)
            }
        case .write(let sentence):
            //wait time between each sentence writing
            typeWrite(sentence: sentence, completionHandler: {
                
                let nextActions = Array(messageActions.dropFirst())
                self.typeWrite(messageActions: nextActions)
            })
        }
    }
    
    /// Write the sentences defined into parameter. When all sentences were writed, will call the completionHandler.
    private func typeWrite(sentence: Sentence, completionHandler: @escaping () -> Void) {
        
        self.typeWriteSentence(sentence.text, completionHandler: {
            self.text = "\(self.text!) "
        
            Timer.scheduledTimer(withTimeInterval: sentence.waitingTime/1000, repeats: false) { _ in
                completionHandler()
            }
        })
        
    }
    
    /// Writes the message parameter. It's one sentence that will be typed character by character. The completionHandler is called when all characters were typed.
    private func typeWriteSentence(_ message: String, completionHandler: @escaping () -> Void) {
        
        self.currentSentence = Array(message)
        self.typedCharCount = 0
        
        Timer.scheduledTimer(withTimeInterval: timePerCharacter, repeats: true) { timer in
            
            if self.typedCharCount < self.currentSentence.count {
                self.text = "\(self.text!)\(self.currentSentence[self.typedCharCount])"
            } else {
                timer.invalidate()
                completionHandler()
            }
            self.typedCharCount += 1
        }
    }
    
    /// Erase all characters already typed.
    private func eraseAllTypedMessage( completionHandler: @escaping () -> Void) {
        Timer.scheduledTimer(withTimeInterval: timePerCharacter, repeats: true) { timer in
            
            if self.text.count == 0 {
                timer.invalidate()
                completionHandler()
            }

            self.text = "\(self.text.dropLast())"
        }
    }
}
