//
//  ChatManager.swift
//  SuitabilityChat
//
//  Created by Victor Melo on 05/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

/// A singleton class that keeps the chat information, including user's response and a state machine.
class ChatManager {
    
    // MARK: - Properties
    
    /// The singleton instance
    let shared = ChatManager()
    
    /// The chat current state
    private(set) var currentState: APIState = .name
    
    /// The user's answer for each chat state.
    private(set) var answers: [APIState: String] = [:]
    
    private init() { }
    
    // MARK: - Methods
    
    /*
     Get the bot response according to the user answer parameter.
     - Parameters:
        - userAnswer: the user answer for the current state.
        - completion: the response received from API according to userAnswer and current state.
    */
    func getResponse(userAnswer: String, completion: (_ response: APIResponse) -> Void) {
        // TODO: - Implement
    }
    
}
