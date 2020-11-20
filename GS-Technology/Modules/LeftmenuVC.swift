//
//  LeftmenuVC.swift
//  GS-Technology
//
//  Created by Mayank Rai on 02/05/20.
//  Copyright © 2020 Mayank Rai. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LeftmenuVC: UIViewController {

    @IBOutlet var imgSet: [UIImageView]!
    override func viewDidLoad() {
        super.viewDidLoad()
        setImgTintColor(imgSet, color: hexStringToUIColor("ffffff"))
    }
    
    
    @IBAction func btnHomeAction(_ sender: Any) {
        dismissMenu()
    }
    
    
    @IBAction func btnProfileAction(_ sender: Any) {
        let vc : GuardsProfileVC = StoryBoards.Main.getStoryBoard().instantiateViewController(withIdentifier: "GuardsProfileVC") as! GuardsProfileVC
              vc.type = "leftMenu"
              vc.modalPresentationStyle = .overFullScreen
              self.presentDetails(vc)
    }
    
    
    @IBAction func btnAttendanceAction(_ sender: Any) {
         let vc : GuardsAttendanceVC = StoryBoards.Main.getStoryBoard().instantiateViewController(withIdentifier: "GuardsAttendanceVC") as! GuardsAttendanceVC
              vc.type = "leftMenu"
              vc.modalPresentationStyle = .overFullScreen
              self.presentDetails(vc)
    }
    
    
    @IBAction func btnExpenseAction(_ sender: Any) {
         let vc : GuardsExpensesVC = StoryBoards.Main.getStoryBoard().instantiateViewController(withIdentifier: "GuardsExpensesVC") as! GuardsExpensesVC
              vc.type = "leftMenu"
              vc.modalPresentationStyle = .overFullScreen
              self.presentDetails(vc)
    }
    
    
    @IBAction func btnSalaryAction(_ sender: Any) {
        let vc : GuardsSalaryVC = StoryBoards.Main.getStoryBoard().instantiateViewController(withIdentifier: "GuardsSalaryVC") as! GuardsSalaryVC
              vc.type = "leftMenu"
              vc.modalPresentationStyle = .overFullScreen
              self.presentDetails(vc)
    }
    
    
    @IBAction func btnLogoutAction(_ sender: Any) {
//        Auth.auth().signOut().t( signOut(){
//            self.view.makeToast("Logged Out Successfully")
//        }).catch {
//          print("Error")
//        };
        do {
            try Auth.auth().signOut()
            signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        
    }
    
    
    @IBAction func btnDismissAction(_ sender: Any) {
        dismissMenu()
    }
    
    
    func signOut(){
        let vc : LoginVC = StoryBoards.Login.getStoryBoard().instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        vc.modalPresentationStyle = .overFullScreen
        UserManager.shared.password = ""
        UserManager.shared.userId = ""
        self.presentMenu(vc)
       
    }
}
