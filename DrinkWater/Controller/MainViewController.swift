//
//  MainViewController.swift
//  DrinkWater
//
//  Created by admin on 8.04.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressCompleteLabel: UILabel!
    
    private lazy var waterHours = [WaterHours]()
    private let content = UNMutableNotificationContent()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        waterHours.append(WaterHours(hour: "09:00", done: false))
        waterHours.append(WaterHours(hour: "12:00", done: false))
        waterHours.append(WaterHours(hour: "15:00", done: false))
        waterHours.append(WaterHours(hour: "18:00", done: false))
        waterHours.append(WaterHours(hour: "21:00", done: false))
    }
    
    @IBAction func logOutButtonTapped(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            guard let welcomeVC = UIStoryboard.myStoryboardName.instantiateViewController(identifier: "WelcomeScreen") as? WelcomeViewController else { return }
            UIApplication.shared.windows.first?.rootViewController = welcomeVC
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
//    private func localNotifications() {
//        content.title = "Weekly Staff Meeting"
//        content.body = "Every Tuesday at 2pm"
//        content.sound = UNNotificationSound.default
//
//        // Configure the recurring date.
//        var dateComponents = DateComponents()
//        dateComponents.calendar = Calendar.current
//
//        dateComponents.weekday = 1  // Tuesday
//        dateComponents.hour = 14    // 14:00 hours
//
//        // Create the trigger as a repeating event.
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 300, repeats: false)
//
//        let date = Date(timeIntervalSinceNow: 3600)
//        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
//
//        // Create the request
//        let uuidString = UUID().uuidString
//        let request = UNNotificationRequest(identifier: uuidString,
//                    content: content, trigger: trigger)
//
//        // Schedule the request with the system.
//        let notificationCenter = UNUserNotificationCenter.current()
//        notificationCenter.add(request) { (error) in
//           if error != nil {
//              // Handle any errors.
//           }
//        }
//    }
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
