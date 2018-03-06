//
//  ChatManager.swift
//  SuitabilityChat
//
//  Created by Victor Melo on 05/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

/* A singleton class that keeps the chat information, including user's response and a state machine. It's accessed by API to get current state information.
*/
class ChatManager {
    
    // MARK: - Properties
    
    /// The singleton instance
    static let shared = ChatManager()
    
    /// The chat current state
    private(set) var currentState: APIState = .name
    
    /// The user's answer for each chat state.
    private(set) var answers: [APIState.RawValue: String] = [:]
    
    private init() { }
    
    // MARK: - Methods
    
    /*
     Get the bot response according to the user answer parameter.
     - Parameters:
        - userAnswer: the user answer for the current state.
        - completion: the response received from API according to userAnswer and current state.
    */
    func getResponse(userAnswer: String, completion: @escaping (_ response: APIResponse) -> Void) {
        
        answers[currentState.rawValue] = userAnswer
        
        APICommunicator.request { response in
            self.currentState = response.id
            completion(response)
        }
    }
}
