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
    let ImageArray = [
        "bg-0.jpeg",
        "bg-1.jpeg",
        "bg-2.jpeg",
        "bg-3.jpeg",
        "bg-4.jpeg",
    ]

    override func viewDidLoad() {
        firstLaunch()
        
        updateTimer()
        if #available(iOS 13.0, *) {
            let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .heavy, scale: .large)
            let img = UIImage(systemName: "airplane", withConfiguration: config)
            imageView.image = img
            
        } else {
            return
        }

        platterView.layer.cornerRadius = 10
        platterView.clipsToBounds = true
        dayLabel.font = .boldSystemFont(ofSize: 47)

    super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        updateTimer()
        backgroundImageView.image = self.randomImage()
        

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         navigationController?.setNavigationBarHidden(false, animated: animated)
    }


    
    func updateTimer() {
        let date = NSDate()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .month, .year, .day], from: date as Date)
        let currentDate = calendar.date(from: components)
        let userCalendar = Calendar.current
        let defaults = UserDefaults.standard
        let year = defaults.string(forKey: "year")
        let yearint = Int(year!)
        let month = defaults.string(forKey: "month")
        let monthint = Int(month!)
        let day = defaults.string(forKey: "day")
        let dayint = Int(day!)
        
        // Date of event
        let competitionDate = NSDateComponents()
        competitionDate.year = yearint!
        competitionDate.month = monthint!
        competitionDate.day = dayint!
        
        competitionDate.hour = 00
        competitionDate.minute = 00
        let competitionDay = userCalendar.date(from: competitionDate as DateComponents)!
        //
        let CompetitionDayDifference = calendar.dateComponents([.day, .hour, .minute], from: currentDate!, to: competitionDay)
        //
        let daysLeft = CompetitionDayDifference.day
        let hoursLeft = CompetitionDayDifference.hour
        let minutesLeft = CompetitionDayDifference.minute
        //
        dayLabel.text = "\(daysLeft ?? 0 ) Days"
        hrLabel.text = "\(hoursLeft ?? 0) Hours"
        minLabel.text = "\(minutesLeft ?? 0) Minutes"
        
    }
    @IBAction func editButton(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "DatePicker")
        self.navigationController!.pushViewController(controller!, animated: true)
        
    }
    func randomImage() -> UIImage {
        let unsignedArrayCount = UInt32(ImageArray.count)
        let unsignedRandomNumber = arc4random_uniform(unsignedArrayCount)
        let randomNumber = Int(unsignedRandomNumber)
        return UIImage(named: ImageArray[randomNumber])!
    }

    @IBAction func shareButtonClicked(sender: AnyObject)
      {
          //Set the default sharing message.
        let message = "OTB reports I have  \(dayLabel.text ?? "UNKNOWN") left"
        // Add array and radomize the message
          //Set the link to share.
          if let link = NSURL(string: "http://www.joeis.us")
        
          {
            let objectsToShare = [message,link] as [Any]
              let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            self.present(activityVC, animated: true, completion: nil)
          }
      }
    func firstLaunch(){
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchednever")
        if launchedBefore {
            print("Not First Launch")
        } else {
            let strDate = "01-01-2020"
            let result = strDate.split(separator: "-")
            let defaults = UserDefaults.standard
            UserDefaults.standard.set(String(result[0]), forKey: "day")
            UserDefaults.standard.set(String(result[1]), forKey: "month")
            UserDefaults.standard.set(String(result[2]), forKey: "year")
            defaults.synchronize()
            UserDefaults.standard.set(true, forKey: "launchednever")
            
            //display UI alert Giving option to set First Coundown timer
            
        }
    }
    
}

