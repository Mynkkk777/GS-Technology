//
//  SplashVC.swift
//  GS-Technology
//
//  Created by Mayank Rai on 07/05/20.
//  Copyright © 2020 Mayank Rai. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SplashVC: UIViewController {
    
    var dispatchGroup = DispatchGroup()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dispatchGroup.notify(queue: .main) {
            self.userCheck()
               }
    }
    
    func userCheck(){
        if UserManager.shared.userId != "" && UserManager.shared.password != ""{
            loginUser()
        } else{
            login()
        }
    }
    
    func login(){
        let vc : LoginVC = StoryBoards.Login.getStoryBoard().instantiateViewController(identifier: "LoginVC") as! LoginVC
        vc.modalPresentationStyle = .overFullScreen
               self.present(vc, animated: true, completion: nil)
    }
    
    func loginUser(){
        Auth.auth().signIn(withEmail: UserManager.shared.userId, password: UserManager.shared.password) { (Result, err) in
            if err != nil{
                self.loadingView(flag: false)
                self.view.makeToast(err?.localizedDescription, duration: 3, position: .bottom)
                 self.login()
            }
            else {
                self.loadingView(flag: false)
                self.createHome()
            }
        }
    
    }
    
    func createHome(){
        createRootView()
         let vc : HomeVC = StoryBoards.Main.getStoryBoard().instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        // self.navigationController?.pushViewController(vc, animated: true)
         vc.modalPresentationStyle = .overFullScreen
         self.present(vc, animated: true, completion: nil)
    }
    
}
