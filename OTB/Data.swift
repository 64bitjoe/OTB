////  Data.swift
//  OTB
//  Created on: 12/4/19
//  Using Swift 5.0
//  Copyright ©  2019 All rights reserved.
//

import Foundation
import UIKit
// MARK: SHARE TIME 

let SHARE_0 = "I have __DAYS__  🥳"
let SHARE_1 = "I should start packing with __DAYS__ left! 😅"
let SHARE_2 = "I Should stop bragging __DAYS__ left 😎"
let SHARE_3 = "Don't fuck it up __DAYS__ left 🙈 "
let SHARE_4 = "Time to partayyyy 😎 __DAYS__ "
let SHARE_5 = "Joe, Stop telling people how many days are left. They already want you to leave. __DAYS__ "

// MARK: QUOTES FOR MAIN VIEW
let QUOTE_0 = "\"Put something inspirational here\""
let QUOTE_1 = ""
let QUOTE_2 = "I think it’s great that they’re doing this, and I hope it works out."
let QUOTE_3 = "Most important, have the courage to follow your heart and intuition."
let QUOTE_4 = "\"Be proud of yourself. Do the best work of your life.\""
let QUOTE_5 = "\"Do you still work here?\""


// MARK: DECLARE ARRAY OF DATA
let QUARRAY = [
    QUOTE_0,
    QUOTE_1,
    QUOTE_2,
    QUOTE_3,
    QUOTE_4,
    QUOTE_5
]

let SHARRAY = [
    SHARE_0,
    SHARE_1,
    SHARE_2,
    SHARE_3,
    SHARE_4,
    SHARE_5
]


let ImageArray = [
    "bg-0.jpeg",
    "bg-1.jpeg",
    "bg-2.jpeg",
    "bg-3.jpeg",
    "bg-4.jpeg",
]

func randomImage() -> UIImage {
    let unsignedArrayCount = UInt32(ImageArray.count)
    let unsignedRandomNumber = arc4random_uniform(unsignedArrayCount)
    let randomNumber = Int(unsignedRandomNumber)
    return UIImage(named: ImageArray[randomNumber])!
}


func randomText() -> String {
    return QUARRAY[Int(arc4random_uniform(UInt32(QUARRAY.count)))]
}

func randomShare() -> String {
    return SHARRAY[Int(arc4random_uniform(UInt32(SHARRAY.count)))]
}

class EmojiTextField: UITextField {

   // required for iOS 13
   override var textInputContextIdentifier: String? { "" } // return non-nil to show the Emoji keyboard ¯\_(ツ)_/¯

    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                return mode
            }
        }
        return nil
    }
}
