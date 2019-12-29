////  DatePickerController.swift
//  OTB
//  Created on: 11/24/19
//  Using Swift 5.0
//  Copyright ©  2019 All rights reserved.
//

import UIKit

class DatePickerController: ViewController {
    
    @IBOutlet weak var bagroundView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var textFeild: UITextField!
    
    override func viewDidLoad() {
        
    }
    override func viewWillAppear(_ animated: Bool) {
         navigationController?.setNavigationBarHidden(false, animated: animated)
        bagroundView.layer.cornerRadius = 10
        bagroundView.clipsToBounds = true
    }
    
    @IBAction func datePicker(_ sender: Any) {
        let dateFormatter = DateFormatter()
           
           dateFormatter.dateFormat = "dd-MM-YYYY"
           let strDate = dateFormatter.string(from: datePicker.date)
           
           print(strDate)


    }
    
    @IBAction func saveButton(_ sender: Any) {
        let dateFormatter = DateFormatter()
           
           dateFormatter.dateFormat = "dd-MM-YYYY"
           let strDate = dateFormatter.string(from: datePicker.date)
           
        navigationController?.dismiss(animated: true, completion: nil)
        
        if segmentedControl.selectedSegmentIndex == 0 {
            dateLabel.text = strDate
            let result = strDate.split(separator: "-")
            let defaults = UserDefaults.standard
            UserDefaults.standard.set(String(result[0]), forKey: "day_0")
            UserDefaults.standard.set(String(result[1]), forKey: "month_0")
            UserDefaults.standard.set(String(result[2]), forKey: "year_0")
            defaults.synchronize()
            
        } else if segmentedControl.selectedSegmentIndex == 1 {
           dateLabel.text = strDate
           let result = strDate.split(separator: "-")
           let defaults = UserDefaults.standard
           UserDefaults.standard.set(String(result[0]), forKey: "day_1")
           UserDefaults.standard.set(String(result[1]), forKey: "month_1")
           UserDefaults.standard.set(String(result[2]), forKey: "year_1")
           defaults.synchronize()
           

        }
    }
    @IBAction func settingsButton(_ sender: Any) {
        
    overrideUserInterfaceStyle = .dark
    }
    
}
