//
//  HoursReminderTableViewCell.swift
//  DrinkWater
//
//  Created by admin on 8.04.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit

class HoursReminderTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet private weak var waterImage: UIImageView!
    @IBOutlet private weak var hoursLabel: UILabel!
    
    private lazy var waterImagesTitles: [String] = [
        "water1", "water2", "water3", "water4", "water5", "water6"
            ]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func getRandomImage(on array: [String]) -> String {
        guard let selectedElement = array.randomElement() else { return "water1" }
        return selectedElement
    }
    
    public func configureCell(on model: String) {
        hoursLabel.text = model
        waterImage.image = UIImage(named: getRandomImage(on: waterImagesTitles))
    }

}
