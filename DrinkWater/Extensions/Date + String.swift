//
//  Date + String.swift
//  DrinkWater
//
//  Created by admin on 11.04.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import Foundation

extension Date {
    func getFormattedDate(format: String = "d MMMM EEEE") -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        dateformat.locale = Locale(identifier: "tr_TR")
        return dateformat.string(from: self)
    }
}
