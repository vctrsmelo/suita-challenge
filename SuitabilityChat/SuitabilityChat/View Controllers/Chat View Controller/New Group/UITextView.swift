//
//  UITextView.swift
//  SuitabilityChat
//
//  Created by Victor S Melo on 06/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import UIKit

extension UITextView {

    private var charCount: Int {
        get {
            return self.charCount
        }
        set {
            self.charCount = newValue
        }
    }
    
    private var timer: Timer? {
        get {
            return self.timer
        }
        set {
            self.timer = newValue
        }
    }
    
    private var messageText: [String.Element] {
        get {
            return self.messageText
        }
        set {
            self.messageText = newValue
        }
    }
    
    private var timePerCharacter: TimeInterval {
        get {
            return self.timePerCharacter
        }
        set {
            self.timePerCharacter = newValue
        }
    }
    
    func typeWrite(_ message: String, timePerCharacter: TimeInterval, completionHandler: () -> Void) {
        
        self.messageText = Array(message)
        self.charCount = 0
        self.timePerCharacter = timePerCharacter
        
        timer = Timer.scheduledTimer(timeInterval: timePerCharacter, target: self, selector: #selector(UITextView.typeLetter), userInfo: nil, repeats: true)
        
        typeLetter()
    }
    
    @objc private func typeLetter() {
        if charCount < messageText.count {
            self.text = "\(self.text!)\(messageText[charCount])"
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: timePerCharacter, target: self, selector: #selector(UITextView.typeLetter), userInfo: nil, repeats: false)
        } else {
            timer?.invalidate()
        }
        self.charCount += charCount

    }
    
}
