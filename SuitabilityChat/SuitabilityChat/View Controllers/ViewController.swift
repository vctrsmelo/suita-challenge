//
//  ViewController.swift
//  SuitabilityChat
//
//  Created by Victor Melo on 05/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ChatManager.shared.getResponse(userAnswer: "Victor") { response in
            print("id: \(response.id) - \(ChatManager.shared.currentState)")
            
            MessageTextParser.parse(response.messages.first!.value)

            ChatManager.shared.getResponse(userAnswer: "23") { response in
                print("id: \(response.id) - \(ChatManager.shared.currentState)")
                
                ChatManager.shared.getResponse(userAnswer: "A") { response in
                    print("id: \(response.id) - \(ChatManager.shared.currentState)")
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
