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
        popupView.viewWithCurveAndShadow()
        updateErrorMessage()
    }

    private func updateErrorMessage() {
        self.messageLabel.text = errorMessage
    }
}
