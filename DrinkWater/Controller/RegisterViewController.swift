//
//  RegisterViewController.swift
//  DrinkWater
//
//  Created by admin on 8.04.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loadingLabel: UILabel!
    @IBOutlet private weak var loadingNewPageActivityIndicator: UIActivityIndicatorView!
    
    enum ScreenState: String {
        case loading
        case empty
    }
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
    }
    
    private func changeRootViewController() {
        guard let mainController = UIStoryboard.myStoryboardName.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else { return }
            UIApplication.shared.windows.first?.rootViewController = mainController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
                guard let self = self else { return }
                if password.count < 6 || email.isEmpty {
                    guard let popOverVC = UIStoryboard.myStoryboardName.instantiateViewController(identifier: "Popup") as? PopupViewController else { return }
                    if let err = error {
                        popOverVC.errorMessage = err.localizedDescription
                    }
                    popOverVC.modalTransitionStyle = .crossDissolve
                    self.present(popOverVC, animated: true)
                } else {
                    self.loadingLabel.text = "You are going to main page please wait..⏳"
                    self.screenState = .loading
                    
                    }
                }
            }
        }
        
        
        
        
        //        if usernameTextField.text != "" && usernameTextField.text!.count >= 3
        //        && passwordTextField.text != "" && passwordTextField.text!.count >= 2 {
        //            loadingLabel.text = "You are going to main page please wait..⏳"
        //            screenState = .loading
        //            if let vc = UIStoryboard.myStoryboardName.instantiateViewController(identifier: "MainViewController") as? MainViewController {
        //                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        //                    self.show(vc, sender: nil)
        //                }
        //            }
        //        } else if usernameTextField.text == "" || usernameTextField.text!.count < 3 {
        //            loadingLabel.text = "Please enter a correct username!"
        //            screenState = .loaded
        //        } else if passwordTextField.text == "" || passwordTextField.text!.count < 2 {
        //            loadingLabel.text = "Please enter a correct password!"
        //            screenState = .loaded
        //        }
    }
    

