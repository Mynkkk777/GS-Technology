//
//  UserManager.swift
//  GS-Technology
//
//  Created by Mayank Rai on 07/05/20.
//  Copyright © 2020 Mayank Rai. All rights reserved.
//

import Foundation
import UIKit


class UserManager : NSObject{
   static let shared = UserManager()
    
    var userId : String{
        get {
            if let val = UserDefaults.standard.object(forKey: USERDEFAULTKEYS.UserId.rawValue) as? String {
                return val
            } else {
                return ""
            }
        }

        set {
            UserDefaults.standard.set(newValue, forKey: USERDEFAULTKEYS.UserId.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    var password : String{
        get {
            if let val = UserDefaults.standard.object(forKey: USERDEFAULTKEYS.Password.rawValue) as? String {
                return val
            } else {
                return ""
            }
        }

        set {
            UserDefaults.standard.set(newValue, forKey: USERDEFAULTKEYS.Password.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
}
