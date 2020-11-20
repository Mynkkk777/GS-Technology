//
//  App_Functions.swift
//  GS-Technology
//
//  Created by Mayank Rai on 02/05/20.
//  Copyright © 2020 Mayank Rai. All rights reserved.
//

import Foundation
import UIKit

var window : UIWindow?

func getStoryboard(storyBoard : StoryBoards) -> UIStoryboard {
    return UIStoryboard.init(name: storyBoard.rawValue, bundle: nil)
}

func createRootView(){
     let viewController : HomeVC = StoryBoards.Main.getStoryBoard().instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            let navigationController : UINavigationController = UINavigationController(rootViewController: viewController)
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.rootViewController = navigationController
        navigationController.isNavigationBarHidden = true
        appdelegate.window?.makeKeyAndVisible()
            // window?.makeKeyAndVisible()
    
}

func checkTextValue(_ txtField : UITextField) -> Bool {
    return txtField.text?.replacingOccurrences(of: " ", with: "") == ""
}

func isValidEmail(testStr:String) -> Bool {
    // println("validate calendar: \(testStr)")
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}

func isValidPhone(value: String) -> Bool {
    let PHONE_REGEX = "^[0-9]{7,15}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    let result =  phoneTest.evaluate(with: value)
    return result
}



