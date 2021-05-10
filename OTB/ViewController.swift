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
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var platterView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var inspirationLabel: UILabel!
    @IBOutlet weak var secondPlatterView: UIView!
    @IBOutlet weak var secondDayLabel: UILabel!
    @IBOutlet weak var secondHrLabel: UILabel!
    @IBOutlet weak var secondMinLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var seccondEmojiLabel: UILabel!
    
    let competitionDate = NSDateComponents()
    let date = NSDate()
    let calendar = Calendar.current
    let userCalendar = Calendar.current
    let defaults = UserDefaults.standard
    var timer = Timer()
    
    override func viewDidLoad() {
        firstLaunch()
        updateTimer()
        updateSecondTimer()
        
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
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         navigationController?.setNavigationBarHidden(false, animated: animated)
        timer.invalidate()
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
            defaults.set(String(result[0]), forKey: "day_0")
            defaults.set(String(result[1]), forKey: "month_0")
            defaults.set(String(result[2]), forKey: "year_0")
            defaults.set(String(result[0]), forKey: "day_1")
            defaults.set(String(result[1]), forKey: "month_1")
            defaults.set(String(result[2]), forKey: "year_1")
            defaults.set(String("09"), forKey: "hour_0")
            defaults.set(String("41"), forKey: "minute_0")
            defaults.set(String("09"), forKey: "hour_1")
            defaults.set(String("41"), forKey: "minute_1")
            defaults.synchronize()
            UserDefaults.standard.set(true, forKey: "launchednever")
            
            // TO DO: Display UI alert Giving option to set First Coundown timer
            
        }
    }
// MARK: Update Timer
    @objc func updateTimer() {
        let components = calendar.dateComponents([.hour, .minute, .month, .year, .day], from: date as Date)
        let currentDate = calendar.date(from: components)
        let year = defaults.string(forKey: "year_0")
        let yearInt = Int(year!)
        let month = defaults.string(forKey: "month_0")
        let monthInt = Int(month!)
        let day = defaults.string(forKey: "day_0")
        let dayInt = Int(day!)
        let hour = defaults.string(forKey: "hour_0")
        let hourInt = Int(hour!)
        let minute = defaults.string(forKey: "minute_0")
        let minuteInt = Int(minute!)
        
        // Date of event
        let competitionDate = NSDateComponents()
        competitionDate.year = yearInt!
        competitionDate.month = monthInt!
        competitionDate.day = dayInt!
        competitionDate.hour = hourInt!
        competitionDate.minute = minuteInt!
        let competitionDay = userCalendar.date(from: competitionDate as DateComponents)!
        let CompetitionDayDifference = calendar.dateComponents([.day, .hour, .minute], from: currentDate!, to: competitionDay)
        let daysLeft = CompetitionDayDifference.day
        let hoursLeft = CompetitionDayDifference.hour
        let minutesLeft = CompetitionDayDifference.minute
        
        emojiLabel.text = defaults.string(forKey: "emoji_0")
        descriptionLabel.text = defaults.string(forKey: "name_0")
        
        // TO DO - Adjust Days Hrs mins labels based on count
        DispatchQueue.main.async {
            self.dayLabel.text = "\(daysLeft ?? 0 ) Days"
            self.hrLabel.text = "\(hoursLeft ?? 0) Hours"
            self.minLabel.text = "\(minutesLeft ?? 0) Minutes"
            print("This runs every 15 secconds")
        }
        
    }
    @objc func updateSecondTimer() {
        let components = calendar.dateComponents([.hour, .minute, .month, .year, .day], from: date as Date)
        let currentDate = calendar.date(from: components)
        let year = defaults.string(forKey: "year_1")
        let yearint = Int(year!)
        let month = defaults.string(forKey: "month_1")
        let monthint = Int(month!)
        let day = defaults.string(forKey: "day_1")
        let dayint = Int(day!)
        let hour = defaults.string(forKey: "hour_1")
        let hourInt = Int(hour!)
        let minute = defaults.string(forKey: "minute_1")
        let minuteInt = Int(minute!)
        
        // Date of event
        competitionDate.year = yearint!
        competitionDate.month = monthint!
        competitionDate.day = dayint!
        competitionDate.hour = hourInt!
        competitionDate.minute = minuteInt!
        let competitionDay = userCalendar.date(from: competitionDate as DateComponents)!
        let CompetitionDayDifference = calendar.dateComponents([.day, .hour, .minute], from: currentDate!, to: competitionDay)
        let daysLeft = CompetitionDayDifference.day
        let hoursLeft = CompetitionDayDifference.hour
        let minutesLeft = CompetitionDayDifference.minute
        
        seccondEmojiLabel.text = defaults.string(forKey: "emoji_1")
        
        DispatchQueue.main.async {
            self.secondDayLabel.text = "\(daysLeft ?? 0 ) Days"
            self.secondHrLabel.text = "\(hoursLeft ?? 0) Hours"
            self.secondMinLabel.text = "\(minutesLeft ?? 0) Minutes"
           
        }
    }
    
    // MARK: Button Actions
    
    
    @IBAction func editButton(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "DatePicker")
        self.navigationController!.pushViewController(controller!, animated: true)
        
    }

    
    @IBAction func shareButtonClicked(sender: AnyObject)
      {
        
        let data = randomShare()
        let message = data.replacingOccurrences(of: "__DAYS__", with: "\(dayLabel.text ?? "UNKNOWN")")
        
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
        
          if let link = NSURL(string: "https://www.joeis.us")
        
          {
            let objectsToShare = [message,link] as [Any]
              let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            self.present(activityVC, animated: true, completion: nil)
          }
      }
}

