//
//  MainViewController.swift
//  DrinkWater
//
//  Created by admin on 8.04.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressCompleteLabel: UILabel!
    
    private lazy var waterHours = [WaterHours]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        waterHours.append(WaterHours(hour: "09:00", done: false))
        waterHours.append(WaterHours(hour: "12:00", done: false))
        waterHours.append(WaterHours(hour: "15:00", done: false))
        waterHours.append(WaterHours(hour: "18:00", done: false))
        waterHours.append(WaterHours(hour: "21:00", done: false))
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - TableView Delegate And Datasource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return waterHours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WaterCell", for: indexPath) as? HoursReminderTableViewCell else { return UITableViewCell() }
        cell.configureCell(on: waterHours[indexPath.row].hour)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let currentDate = Date().getFormattedDate()
        return currentDate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        waterHours[indexPath.row].done = !waterHours[indexPath.row].done
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            cell.accessoryType = waterHours[indexPath.row].done ? .checkmark : .none
        }
        
        if waterHours[indexPath.row].done {
            progressView.progress += 0.2
        } else {
            progressView.progress -= 0.2
        }
        
        switch progressView.progress {
        case 1.0:
            progressCompleteLabel.isHidden = false
            progressCompleteLabel.text = "You Had a Healty Day! 💪🏼"
        default:
            progressCompleteLabel.isHidden = true
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
