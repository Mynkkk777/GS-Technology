//
//  GuardsSalaryVC.swift
//  GS-Technology
//
//  Created by Mayank Rai on 02/05/20.
//  Copyright © 2020 Mayank Rai. All rights reserved.
//

import UIKit

class GuardsSalaryVC: UIViewController {
    
    var type = ""

    override func viewDidLoad() {
        super.viewDidLoad()

   
    }
    


    @IBAction func btnBackAction(_ sender: Any) {
        if type == "leftMenu"{
            dismissMenuLeft()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
