//
//  LoginVC.swift
//  GS-Technology
//
//  Created by Mayank Rai on 02/05/20.
//  Copyright © 2020 Mayank Rai. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class LoginVC: UIViewController {

    @IBOutlet weak var mainVew: UIView!
    @IBOutlet weak var txtEmailMobile: HoshiTextField!
    @IBOutlet weak var txtPassword: HoshiTextField!
       var EmailMobile = ""
       var password = ""
       var AddData : [String : Any] = [:]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmailMobile.delegate = self
        txtPassword.delegate = self
       // txtPassword.returnKeyType = .done
        shadowEffect(mainVew)
    }
    func shadowEffect(_ vew : UIView){
        vew.layer.shadowColor = UIColor.gray.cgColor
        vew.layer.shadowOpacity = 1
        vew.layer.shadowOffset = .zero
        vew.layer.shadowRadius = 7
        vew.layer.cornerRadius = 10
    }
    
    
    
    
    func validation() -> (Bool,String){
    if checkTextValue(txtEmailMobile) {
            return (false,"Mobile Number or Email id cannot be Empty")
        }
        else {
            if isValidPhone(value: txtEmailMobile.text!) {
                print("Valid Phone")
            }
            else if isValidEmail(testStr: txtEmailMobile.text!) {
                print("Valid Email")
            }
            else {
                print("Error Text")
                return (false,"Email Id/Mobile No Id is not valid")
            }
        }
        if checkTextValue(txtPassword) {
            return (false,"Password cannot be empty")
        }
        if txtPassword.text?.count ?? 0 < 6 {
            return (false, "Password must contain at least 6 characters")
        }
        return (true,"")
    }


    @IBAction func btnLoginAction(_ sender: Any) {
        let val = validation()
        self.loadingView(flag: true)
        if val.0{
            EmailMobile = txtEmailMobile.text!
            password = txtPassword.text!
            login()
            
            
        }else{
            self.loadingView(flag: false)
             self.view.makeToast(val.1, duration: 3.0, position: .bottom)
        }
        
    }
    
    
    
    func login(){
        Auth.auth().signIn(withEmail: EmailMobile, password: password) { (Result, err) in
            if err != nil{
                self.loadingView(flag: false)
                self.view.makeToast(err?.localizedDescription, duration: 3, position: .bottom)
            }
            else {
                self.loadingView(flag: false)
                UserManager.shared.userId = self.txtEmailMobile.text!
                UserManager.shared.password = self.txtPassword.text!
                self.createHome()
            }
        }
    
    }
    @IBAction func btnSignUpAction(_ sender: Any) {
        let vc : SignUpVC = StoryBoards.Main.getStoryBoard().instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        
         vc.modalPresentationStyle = .overFullScreen
         self.present(vc, animated: true, completion: nil)
    }
    
    func createHome(){
        createRootView()
            let vc : HomeVC = StoryBoards.Main.getStoryBoard().instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
           // self.navigationController?.pushViewController(vc, animated: true)
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
}

extension LoginVC : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtPassword{
            self.view.endEditing(true)
        }
        return true
    }
    
}
