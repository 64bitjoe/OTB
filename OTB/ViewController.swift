////  ViewController.swift
//  OTB
//  Created on: 11/24/19
//  Using Swift 5.0
//  Copyright ©  2019 All rights reserved.
//
import Foundation
import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var hrLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var platterView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var inspirationLabel: UILabel!
    @IBOutlet weak var secondPlatterView: UIView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var secondDayLabel: UILabel!
    @IBOutlet weak var secondHrLabel: UILabel!
    @IBOutlet weak var secondMinLabel: UILabel!
    
    

    override func viewDidLoad() {
        firstLaunch()
        updateTimer()
        updateSecondTimer()
        
        if #available(iOS 13.0, *) {
            let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .heavy, scale: .large)
            let img = UIImage(systemName: "sunset", withConfiguration: config)
            imageView.image = img
            
            let secondConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .heavy, scale: .large)
            let secondImg = UIImage(systemName: "airplane", withConfiguration: secondConfig)
            secondImageView.image = secondImg
            
        } else {
            return 
        }
        secondPlatterView.layer.cornerRadius = 10
        secondPlatterView.clipsToBounds = true
        platterView.layer.cornerRadius = 10
        platterView.clipsToBounds = true
        dayLabel.font = .boldSystemFont(ofSize: 47)
        secondDayLabel.font = .boldSystemFont(ofSize: 47)
        
    super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        updateTimer()
        updateSecondTimer()
        inspirationLabel.text = randomText()
        backgroundImageView.image = randomImage()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         navigationController?.setNavigationBarHidden(false, animated: animated)
    }
// MARK: First Launch
    func firstLaunch(){
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchednever")
        if launchedBefore {
            print("Not First Launch")
        } else {
            let strDate = "01-01-2020"
            let result = strDate.split(separator: "-")
            let defaults = UserDefaults.standard
            UserDefaults.standard.set(String(result[0]), forKey: "day_0")
            UserDefaults.standard.set(String(result[1]), forKey: "month_0")
            UserDefaults.standard.set(String(result[2]), forKey: "year_0")
            UserDefaults.standard.set(String(result[0]), forKey: "day_1")
            UserDefaults.standard.set(String(result[1]), forKey: "month_1")
            UserDefaults.standard.set(String(result[2]), forKey: "year_1")
            defaults.synchronize()
            UserDefaults.standard.set(true, forKey: "launchednever")
            
            //display UI alert Giving option to set First Coundown timer
            
        }
    }
// MARK: Update Timer
    func updateTimer() {
        let date = NSDate()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .month, .year, .day], from: date as Date)
        let currentDate = calendar.date(from: components)
        let userCalendar = Calendar.current
        let defaults = UserDefaults.standard
        let year = defaults.string(forKey: "year_0")
        let yearint = Int(year!)
        let month = defaults.string(forKey: "month_0")
        let monthint = Int(month!)
        let day = defaults.string(forKey: "day_0")
        let dayint = Int(day!)
        
        // Date of event
        let competitionDate = NSDateComponents()
        competitionDate.year = yearint!
        competitionDate.month = monthint!
        competitionDate.day = dayint!
        competitionDate.hour = 00
        competitionDate.minute = 00
        let competitionDay = userCalendar.date(from: competitionDate as DateComponents)!
        let CompetitionDayDifference = calendar.dateComponents([.day, .hour, .minute], from: currentDate!, to: competitionDay)
        let daysLeft = CompetitionDayDifference.day
        let hoursLeft = CompetitionDayDifference.hour
        let minutesLeft = CompetitionDayDifference.minute
        dayLabel.text = "\(daysLeft ?? 0 ) Days"
        hrLabel.text = "\(hoursLeft ?? 0) Hours"
        minLabel.text = "\(minutesLeft ?? 0) Minutes"
    }
    func updateSecondTimer() {
        let date = NSDate()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .month, .year, .day], from: date as Date)
        let currentDate = calendar.date(from: components)
        let userCalendar = Calendar.current
        let defaults = UserDefaults.standard
        let year = defaults.string(forKey: "year_1")
        let yearint = Int(year!)
        let month = defaults.string(forKey: "month_1")
        let monthint = Int(month!)
        let day = defaults.string(forKey: "day_1")
        let dayint = Int(day!)
        
        // Date of event
        let competitionDate = NSDateComponents()
        competitionDate.year = yearint!
        competitionDate.month = monthint!
        competitionDate.day = dayint!
        competitionDate.hour = 10
        competitionDate.minute = 45
        let competitionDay = userCalendar.date(from: competitionDate as DateComponents)!
        let CompetitionDayDifference = calendar.dateComponents([.day, .hour, .minute], from: currentDate!, to: competitionDay)
        let daysLeft = CompetitionDayDifference.day
        let hoursLeft = CompetitionDayDifference.hour
        let minutesLeft = CompetitionDayDifference.minute
        secondDayLabel.text = "\(daysLeft ?? 0 ) Days"
        secondHrLabel.text = "\(hoursLeft ?? 0) Hours"
        secondMinLabel.text = "\(minutesLeft ?? 0) Minutes"
    }
    
    // MARK: Button Actions
    
    
    @IBAction func editButton(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "DatePicker")
        self.navigationController!.pushViewController(controller!, animated: true)
        
    }
    @IBAction func updateButton(_ sender: Any) {
        updateTimer()
    }
    
    @IBAction func shareButtonClicked(sender: AnyObject)
      {
          //Set the default sharing message.
        
        let data = randomShare()
        let message = data.replacingOccurrences(of: "__DAYS__", with: "\(dayLabel.text ?? "UNKNOWN")")
        
        // Add array and radomize the message
          //Set the link to share.
          if let link = NSURL(string: "https://www.joeis.us")
        
          {
            let objectsToShare = [message,link] as [Any]
              let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            self.present(activityVC, animated: true, completion: nil)
          }
      }
    @IBAction func secondShareButtonClicked(sender: AnyObject)
      {
          //Set the default sharing message.
        
        let data = randomShare()
        let message = data.replacingOccurrences(of: "__DAYS__", with: "\(secondDayLabel.text ?? "UNKNOWN")")
        
        // Add array and radomize the message
          //Set the link to share.
          if let link = NSURL(string: "https://www.joeis.us")
        
          {
            let objectsToShare = [message,link] as [Any]
              let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            self.present(activityVC, animated: true, completion: nil)
          }
      }
}

