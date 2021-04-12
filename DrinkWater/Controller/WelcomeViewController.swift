//
//  ViewController.swift
//  DrinkWater
//
//  Created by admin on 8.04.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var logInButton: UIButton!
    @IBOutlet private weak var appTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        curvyButtons()
        titleWithAnimation(appTitle)
    }
    
    private func titleWithAnimation(_ title: UILabel) {
        title.text = ""
        var charIndex = 0.0
        let titleText = "Drink Water🧊"
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.15 * charIndex, repeats: false) { [weak self] timer in
                guard let self = self else { return }
                self.appTitle.text?.append(letter)
            }
            charIndex += 1
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        guard let registerVC = UIStoryboard.myStoryboardName.instantiateViewController(identifier: "RegisterVC") as? RegisterViewController else { return }
        registerVC.modalTransitionStyle = .flipHorizontal
        self.present(registerVC, animated: true)
    }
    
    @IBAction func logInButtonTapped(_ sender: Any) {
        guard let logInVC = UIStoryboard.myStoryboardName.instantiateViewController(identifier: "logInVC") as? LogInViewController else { return }
        logInVC.modalTransitionStyle = .flipHorizontal
        self.present(logInVC, animated: true)
    }
    
    private func curvyButtons() {
        logInButton.getCurvyButton()
        registerButton.getCurvyButton()
    }
}

