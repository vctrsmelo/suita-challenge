//
//  FinishViewController.swift
//  SuitabilityChat
//
//  Created by Victor Melo on 11/03/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {
    
    // MARK: - Properties
    
    var riskToleranceLabel: UILabel!
    var profileTypeLabel: UILabel!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        
        ChatManager.shared.getFinalResponse { (result) in
            self.riskToleranceLabel.text?.append("\(result.computedRiskTolerance)")
            self.profileTypeLabel.text?.append(result.computedProfileType)
        }

        setupView()
        
    }
    
    // MARK: - Views Setup

    private func setupView() {
        
        view.backgroundColor = UIColor.white
        
        riskToleranceLabel = UILabel()
        riskToleranceLabel.text = "Risk Tolerance: "
        
        riskToleranceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(riskToleranceLabel)
        
        riskToleranceLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200).isActive = true
        riskToleranceLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        profileTypeLabel = UILabel()
        profileTypeLabel.text = "Profile Type: "
        profileTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(profileTypeLabel)
        
        profileTypeLabel.topAnchor.constraint(equalTo: riskToleranceLabel.bottomAnchor, constant: 10).isActive = true
        profileTypeLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
}
