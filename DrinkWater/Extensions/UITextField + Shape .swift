//
//  UITextField + Shape .swift
//  DrinkWater
//
//  Created by admin on 9.04.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit

extension UITextField {
    func getCurvy(_ sender: UITextField) {
        sender.layer.cornerRadius = sender.frame.size.height / 2
    }
}

