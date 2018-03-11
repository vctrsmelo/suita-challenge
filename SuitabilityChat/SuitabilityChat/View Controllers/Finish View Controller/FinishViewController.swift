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
    
    var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        
        ChatManager.shared.getFinalResponse { (result) in
            self.riskToleranceLabel.text?.append("\(result.computedRiskTolerance)")
            self.profileTypeLabel.text?.append(result.computedProfileType)
            self.activityIndicatorView.stopAnimating()

            self.riskToleranceLabel.isHidden = false
            self.profileTypeLabel.isHidden = false
        }

        setupView()
        
    }
    
    // MARK: - Views Setup

    private func setupView() {
        
        setupActivityIndicator()
        setupLabels()
        
        riskToleranceLabel.isHidden = true
        profileTypeLabel.isHidden = true
        
    }
    
    private func setupActivityIndicator() {
        activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.center = self.view.center
        activityIndicatorView.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        activityIndicatorView.startAnimating()
        view.addSubview(activityIndicatorView)
    }
    
    private func setupLabels() {
        
        view.backgroundColor = UIColor.white
        
        riskToleranceLabel = UILabel()
        riskToleranceLabel.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        riskToleranceLabel.textColor = #colorLiteral(red: 0.9921568627, green: 0.2509803922, blue: 0.4196078431, alpha: 1)
        riskToleranceLabel.textAlignment = .center
        riskToleranceLabel.text = "Risk Tolerance: "
        
        riskToleranceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(riskToleranceLabel)
        
        riskToleranceLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200).isActive = true
        riskToleranceLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        profileTypeLabel = UILabel()
        profileTypeLabel.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        profileTypeLabel.textColor = #colorLiteral(red: 0.9921568627, green: 0.2509803922, blue: 0.4196078431, alpha: 1)
        profileTypeLabel.textAlignment = .center
        profileTypeLabel.text = "Profile Type: "
        profileTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(profileTypeLabel)
        
        profileTypeLabel.topAnchor.constraint(equalTo: riskToleranceLabel.bottomAnchor, constant: 10).isActive = true
        profileTypeLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
}
