//
//  GuardsAttendanceVC.swift
//  GS-Technology
//
//  Created by Mayank Rai on 02/05/20.
//  Copyright © 2020 Mayank Rai. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class GuardsAttendanceVC: UIViewController {
    var type = ""
    @IBOutlet weak var btnMarkAttandance: UIButton!
    @IBOutlet weak var btnViewAttandance: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func shadowEffect(_ vew : UIView){
        vew.layer.shadowColor = UIColor.gray.cgColor
        vew.layer.shadowOpacity = 1
        vew.layer.shadowOffset = .zero
        vew.layer.shadowRadius = 7
        vew.layer.cornerRadius = 20
    }
    @IBAction func btnBackAction(_ sender: Any) {
        if type == "leftMenu"{
            dismissMenuLeft()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func btnMarkAttandanceAction(_ sender: Any) {
       
        var vc = GuardsAttandanceAddVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func btnViewAttandanceAction(_ sender: Any) {
         var vc = GuardsAttandanceViewVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}

