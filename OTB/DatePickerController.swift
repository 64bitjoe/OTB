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
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var textFeild: UITextField!
    @IBOutlet weak var emojiField: UITextField!
    @IBOutlet weak var bgImageView: UIImageView!
    
    override func viewDidLoad() {
        initHideKeybaord()
        bgImageView.image = randomImage()
        
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
            segmentedControl.setTitle(textFeild.text ?? "", forSegmentAt: 0)
            let result = strDate.split(separator: "-")
            let defaults = UserDefaults.standard
            UserDefaults.standard.set(String(result[0]), forKey: "day_0")
            UserDefaults.standard.set(String(result[1]), forKey: "month_0")
            UserDefaults.standard.set(String(result[2]), forKey: "year_0")
            UserDefaults.standard.set(textFeild.text, forKey: "name_0")
            UserDefaults.standard.set(emojiField.text, forKey: "emoji_0")
            defaults.synchronize()
            
        } else if segmentedControl.selectedSegmentIndex == 1 {
           dateLabel.text = strDate
            segmentedControl.setTitle(textFeild.text ?? "", forSegmentAt: 1)
           let result = strDate.split(separator: "-")
           let defaults = UserDefaults.standard
            UserDefaults.standard.set(String(result[0]), forKey: "day_1")
            UserDefaults.standard.set(String(result[1]), forKey: "month_1")
            UserDefaults.standard.set(String(result[2]), forKey: "year_1")
            UserDefaults.standard.set(textFeild.text, forKey: "name_1")
            UserDefaults.standard.set(emojiField.text, forKey: "emoji_1")
           defaults.synchronize()
           

        }
    }

}

extension DatePickerController {
    func initHideKeybaord() {
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
        target: self,
        action: #selector(dismissMyKeyboard))
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard(){
    //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
    //In short- Dismiss the active keyboard.
    view.endEditing(true)
    }
}

