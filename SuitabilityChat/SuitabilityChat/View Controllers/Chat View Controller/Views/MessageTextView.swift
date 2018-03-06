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
    private var messageText: [String.Element] = []
    private var timePerCharacter: TimeInterval = 0
    
    var bubbleHeight: CGFloat = 0.0
    
    func typeWrite(_ message: String, timePerCharacter: TimeInterval, completionHandler: @escaping () -> Void) {
        
        self.messageText = Array(message)
        self.charCount = 0
        self.timePerCharacter = timePerCharacter
        
        Timer.scheduledTimer(withTimeInterval: timePerCharacter, repeats: true) { timer in
            
            if self.charCount < self.messageText.count {
                self.text = "\(self.text!)\(self.messageText[self.charCount])"
//                timer.invalidate()
//                timer = Timer.scheduledTimer(timeInterval: timePerCharacter, target: self, selector: #selector(UserMessageView.typeLetter), userInfo: nil, repeats: false)
            } else {
                timer.invalidate()
                completionHandler()
            }
            self.charCount += 1
            
        }
//        timer = Timer.scheduledTimer(timeInterval: timePerCharacter, target: self, selector: #selector(MessageTextView.typeLetter), userInfo: nil, repeats: true)
        
    }
    
//    @objc private func typeLetter() {
//        if charCount < messageText.count {
//            self.text = "\(self.text!)\(messageText[charCount])"
//            timer?.invalidate()
//            timer = Timer.scheduledTimer(timeInterval: timePerCharacter, target: self, selector: #selector(UserMessageView.typeLetter), userInfo: nil, repeats: false)
//        } else {
//            timer?.invalidate()
//        }
//        self.charCount += 1
//    }

}
