//
//  PopupViewController.swift
//  DrinkWater
//
//  Created by admin on 10.04.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var popupView: UIView!

    lazy var errorMessage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        viewWithCurveAndShadow(popupView)
        updateErrorMessage()
    }
    
    private func viewWithCurveAndShadow(_ view: UIView) {
        // Corner radius
        view.layer.cornerRadius = view.frame.size.height / 5

        // Border
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.black.cgColor

        // Shadow
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 4.0
    }
    
    private func updateErrorMessage() {
        self.messageLabel.text = errorMessage
    }
}
