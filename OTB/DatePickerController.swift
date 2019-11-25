////  DatePickerController.swift
//  OTB
//  Created on: 11/24/19
//  Using Swift 5.0
//  Copyright ©  2019 All rights reserved.
//

import UIKit

class DatePickerController: ViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        
    }
    override func viewWillAppear(_ animated: Bool) {
         navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    
    @IBAction func datePicker(_ sender: Any) {
        let dateFormatter = DateFormatter()
           
           dateFormatter.dateFormat = "dd-MM-YYYY"
           let strDate = dateFormatter.string(from: datePicker.date)
           
           print(strDate)
        //Save each part as one string in userdefaults
        //update main view

    }
    
    @IBAction func saveButton(_ sender: Any) {
        let dateFormatter = DateFormatter()
           
           dateFormatter.dateFormat = "dd-MM-YYYY"
           let strDate = dateFormatter.string(from: datePicker.date)
           
        dateLabel.text = strDate
        let result = strDate.split(separator: "-")
        let defaults = UserDefaults.standard
        UserDefaults.standard.set(String(result[0]), forKey: "day")
        UserDefaults.standard.set(String(result[1]), forKey: "month")
        UserDefaults.standard.set(String(result[2]), forKey: "year")
        defaults.synchronize()
        navigationController?.dismiss(animated: true, completion: nil)
        
    }
    
}
