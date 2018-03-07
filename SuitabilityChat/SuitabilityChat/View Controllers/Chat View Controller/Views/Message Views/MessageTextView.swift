//
//  MessageTextView.swift
//  SuitabilityChat
//
//  Created by Victor S Melo on 06/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import UIKit

class MessageTextView: UITextView {
    
    // MARK: - Properties for typewriting effect
    
    private var charCount: Int = 0
    private var timer: Timer?
    private var currentSentence: [String.Element] = []
    private var nextSentences: [Sentence] = []
    private let timePerCharacter: TimeInterval = 0.02
    
    weak var messageViewDelegate: MessageViewDelegate?
    
    var bubbleHeight: CGFloat = 0.0
    
    /// Write each sentence, waiting for the corresponding waitingTime between each sentence.
    func typeWrite(_ sentences: [Sentence]) {

        //if there are no sentences left, return
        guard let firstSentence = sentences.first else {
            messageViewDelegate?.didFinishTyping()
            return
        }

        Timer.scheduledTimer(withTimeInterval: firstSentence.waitingTime/1000, repeats: false) { _ in
            self.typeWriteSentence(firstSentence.text, completionHandler: {

                let nextSentences = Array(sentences.dropFirst())
                self.text = "\(self.text!) "
                self.typeWrite(nextSentences)
                
            })
        }
        
    }
    
    /// Writes each sentence in a message bubble, typing character by character.
    private func typeWriteSentence(_ message: String, completionHandler: @escaping () -> Void) {
        
        self.currentSentence = Array(message)
        self.charCount = 0
        
        Timer.scheduledTimer(withTimeInterval: timePerCharacter, repeats: true) { timer in
            
            if self.charCount < self.currentSentence.count {
                self.text = "\(self.text!)\(self.currentSentence[self.charCount])"
            } else {
                timer.invalidate()
                completionHandler()
            }
            self.charCount += 1
            
        }
    }
    

}
