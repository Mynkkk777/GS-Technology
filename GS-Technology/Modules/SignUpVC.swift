//
//  SignUpVC.swift
//  GS-Technology
//
//  Created by Mayank Rai on 03/05/20.
//  Copyright © 2020 Mayank Rai. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class SignUpVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtName: HoshiTextField!
    @IBOutlet weak var txtEmailMobile: HoshiTextField!
    @IBOutlet weak var txtPassword: HoshiTextField!
    @IBOutlet weak var txtConfirmPassword: HoshiTextField!
    @IBOutlet weak var txtCompanyName: HoshiTextField!
    
    
    var name = ""
    var EmailMobile = ""
    var CompanyName = ""
    var password = ""
    var AddData : [String : Any] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate(txtName)
        delegate(txtPassword)
        delegate(txtEmailMobile)
        delegate(txtCompanyName)
        delegate(txtConfirmPassword)
        
        
       
    }
    
    
    func delegate(_ textField: UITextField){
        textField.delegate = self
        textField.returnKeyType = .done
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtName{
            self.view.endEditing(true)
        }
        if textField == txtEmailMobile{
            self.view.endEditing(true)
        }
        if textField == txtPassword{
            self.view.endEditing(true)
        }
        if textField == txtConfirmPassword{
            self.view.endEditing(true)
        }
        if textField == txtCompanyName{
            self.view.endEditing(true)
        }
        return true
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
           if checkTextValue(txtName) {
               return (false,"Full Name cannot be left blank")
           }
           if checkTextValue(txtPassword) {
               return (false,"Password cannot be empty")
           }
           if checkTextValue(txtConfirmPassword) {
                 return(false,"Confirm Password cannot be left blank")
           }
           if txtPassword.text?.count ?? 0 < 6 {
               return (false, "Password must contain at least 6 characters")
           }
            if txtPassword.text! != txtConfirmPassword.text!
            {
             return(false, "Password does not Match")
            }
           return (true,"")
       }


    @IBAction func btnSignUpAction(_ sender: Any) {
         let val = validation()
        self.loadingView(flag: true)
        if val.0{
            name = txtName.text!
            EmailMobile = txtEmailMobile.text!
            CompanyName = txtCompanyName.text!
            password = txtPassword.text!
            AddData = ["Name" : name,"Email Id/Mobile Number" : EmailMobile, "Company Name" : CompanyName]
            createUser()
            
        }
        else {
            self.loadingView(flag: false)
            self.view.makeToast(val.1, duration: 3.0, position: .bottom)
        }
    }
    
    func createUser(){
        
        Auth.auth().createUser(withEmail: EmailMobile, password: password) { (result, error) in
            if error != nil{
                self.loadingView(flag: false)
                self.view.makeToast(error?.localizedDescription, duration: 3, position: .bottom)
                return
            }
            else {
                Firestore.firestore().collection("Users").document(self.txtEmailMobile.text!).setData(self.AddData) { (error) in
                    if error != nil{
                        self.view.makeToast(error?.localizedDescription)
                    }
                    else{
                        self.loadingView(flag: false)
                        //self.createHome()
                        self.createLogin()
                        
                    }
                }
            }
        }
    }
    
    func createLogin(){
        let vc : LoginVC = StoryBoards.Login.getStoryBoard().instantiateViewController(identifier: "LoginVC") as! LoginVC
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
    
    
    @IBAction func btnSignInAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
