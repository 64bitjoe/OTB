////  DatePickerController.swift
//  OTB
//  Created on: 11/24/19
//  Using Swift 5.0
//  Copyright ©  2019 All rights reserved.
//


// TODO: - ADD REJECTION FOR NON EMOJIS IN THE EMOJI TEXT FEILD ON SAVE!!
// TODO: Load timer names for segmemtedcontrol

import UIKit
import CoreData

class DatePickerController: ViewController {
    
    @IBOutlet weak var bagroundView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var textFeild: UITextField!
    @IBOutlet weak var emojiField: UITextField!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        initHideKeybaord()
        bgImageView.image = randomImage()
        
        // init segmented controll and update data based off of what is saved.
    }
    override func viewWillAppear(_ animated: Bool) {
         navigationController?.setNavigationBarHidden(false, animated: animated)
        bagroundView.layer.cornerRadius = 10
        bagroundView.clipsToBounds = true
    }
    
    // For debug not used to save data
    @IBAction func datePicker(_ sender: Any) {
        // Date
        let dateFormatter = DateFormatter()
    
           dateFormatter.dateFormat = "MM-dd-YYYY"
           let strDate = dateFormatter.string(from: datePicker.date)
           print(strDate)
        
        // Time
        
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        let strTime = dateFormatter.string(from: datePicker.date)
        
        print(strTime)
// 13:00 need to use string interpolation to seperate the hour and minute
    
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
           
           dateFormatter.dateFormat = "MM-dd-YYYY"
           let strDate = dateFormatter.string(from: datePicker.date)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.timeZone = TimeZone.autoupdatingCurrent
        let strTime = timeFormatter.string(from: datePicker.date)
           
        navigationController?.dismiss(animated: true, completion: nil)
        
        if segmentedControl.selectedSegmentIndex == 0 {
            segmentedControl.setTitle(textFeild.text ?? "Timer 1", forSegmentAt: 0)
            let result = strDate.split(separator: "-")
            let defaults = UserDefaults.standard
            defaults.set(String(result[1]), forKey: "day_0")
            defaults.set(String(result[0]), forKey: "month_0")
            defaults.set(String(result[2]), forKey: "year_0")
            
            let timeresult = strTime.split(separator: ":")
            defaults.set(String(timeresult[0]), forKey: "hours_0")
            defaults.set(String(timeresult[1]), forKey: "minutes_0")
            
            defaults.set(textFeild.text, forKey: "name_0")
            defaults.set(emojiField.text, forKey: "emoji_0")
            defaults.synchronize()
            
        } else if segmentedControl.selectedSegmentIndex == 1 {
            segmentedControl.setTitle(textFeild.text ?? "Timer 2", forSegmentAt: 1)
           let result = strDate.split(separator: "-")
           let defaults = UserDefaults.standard
            defaults.set(String(result[1]), forKey: "day_1")
            defaults.set(String(result[0]), forKey: "month_1")
            defaults.set(String(result[2]), forKey: "year_1")
            
            let timeresult = strTime.split(separator: ":")
            defaults.set(String(timeresult[0]), forKey: "hours_1")
            defaults.set(String(timeresult[1]), forKey: "minutes_1")
            
            defaults.set(textFeild.text, forKey: "name_1")
            defaults.set(emojiField.text, forKey: "emoji_1")
            defaults.synchronize()
           

        }
    }

}


extension DatePickerController {
    func initHideKeybaord() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
        target: self,
        action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
    view.endEditing(true)
    }
}

