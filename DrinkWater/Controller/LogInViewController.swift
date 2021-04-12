//
//  LogInViewController.swift
//  DrinkWater
//
//  Created by admin on 8.04.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit
import Firebase

enum ScreenState: String {
    case loading
    case empty
}

class LogInViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loadingLabel: UILabel!
    @IBOutlet private weak var loadingNewPageActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var emailView: UIView!
    @IBOutlet private weak var passwordView: UIView!

    var screenState: ScreenState? {
        didSet {
            if screenState == .empty {
                loadingLabel.isHidden = true
                loadingNewPageActivityIndicator.isHidden = true
            } else if screenState == .loading {
                loadingLabel.isHidden = false
                loadingNewPageActivityIndicator.isHidden = false
                loadingNewPageActivityIndicator.startAnimating()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.loadingNewPageActivityIndicator.stopAnimating()
                    self.loadingNewPageActivityIndicator.hidesWhenStopped = true
                    self.changeRootViewController()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenState = .empty
        viewWithCurve()
    }
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let self = self else { return }
                if let err = error {
                    guard let popOverVC = UIStoryboard.myStoryboardName.instantiateViewController(identifier: "Popup") as? PopupViewController else { return }
                    popOverVC.errorMessage = err.localizedDescription
                    popOverVC.modalTransitionStyle = .crossDissolve
                    self.present(popOverVC, animated: true)
                } else {
                    self.loadingLabel.text = "You are going to main page please wait..⏳"
                    self.screenState = .loading
                    
                }
            }
        }
    }
    
    private func changeRootViewController() {
        guard let mainController = UIStoryboard.myStoryboardName.instantiateViewController(withIdentifier: "MainNavigationController") as? UINavigationController else { return }
        UIApplication.shared.windows.first?.rootViewController = mainController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    private func viewWithCurve() {
        emailView.viewWithCurveAndShadow()
        passwordView.viewWithCurveAndShadow()
    }
}
