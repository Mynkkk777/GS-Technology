//
//  GuardsViewVC.swift
//  GS-Technology
//
//  Created by Mayank Rai on 07/05/20.
//  Copyright © 2020 Mayank Rai. All rights reserved.
//

import UIKit
import Firebase

class GuardsViewVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var txtName: HoshiTextField!
    @IBOutlet weak var txtAddress: HoshiTextField!
    @IBOutlet weak var txtDOB: HoshiTextField!
    @IBOutlet weak var txtContactNumber: HoshiTextField!
    @IBOutlet weak var txtAadharNumber: HoshiTextField!
    @IBOutlet weak var txtBankName: HoshiTextField!
    @IBOutlet weak var txtBankAccountNumber: HoshiTextField!
    @IBOutlet weak var txtBankIFSC: HoshiTextField!
    @IBOutlet weak var txtPosition: HoshiTextField!
    @IBOutlet weak var txtSalaryPerDay: HoshiTextField!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnEdit: GradientButton!
    @IBOutlet weak var btnDelete: GradientButton!
    
    var NameSelected = ""
    var GuardData : [String:Any] = [:]
    var AccountNumber : Int = 0
    var AadharNumber : Int = 0
    var SalaryPerDay : Int = 0
    var contact : Int = 0
    var FullName = ""
    var Address = ""
    var DOB = ""
    var ContantNumber = 0
 //   var AadharNumber = 0
    var selectedGender : String = ""
    var BankName = ""
    var BankAccountNumber = 0
    var BankIFSC = ""
    var Position = ""
    //var SalaryPerDay = 0
    var AddData : [String : Any] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDetails()
        editable(false)
        delegate(txtName)
        delegate(txtAddress)
        delegate(txtDOB)
        delegate(txtContactNumber)
        delegate(txtAadharNumber)
        delegate(txtBankName)
        delegate(txtBankAccountNumber)
        delegate(txtBankIFSC)
        delegate(txtPosition)
        delegate(txtSalaryPerDay)
    }
    
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtName{
            self.view.endEditing(true)
        }
        if textField == txtAddress{
            self.view.endEditing(true)
        }
        if textField == txtDOB{
            self.view.endEditing(true)
        }
        if textField == txtContactNumber{
            self.view.endEditing(true)
        }
        if textField == txtAadharNumber{
            self.view.endEditing(true)
        }
        if textField == txtBankName{
            self.view.endEditing(true)
        }
        if textField == txtBankAccountNumber{
            self.view.endEditing(true)
        }
        if textField == txtBankIFSC{
            self.view.endEditing(true)
        }
        if textField == txtPosition{
            self.view.endEditing(true)
        }
        if textField == txtSalaryPerDay{
            self.view.endEditing(true)
        }
        return true
    }
    
    
    
    
    
    func delegate(_ textField: UITextField){
        textField.delegate = self
        textField.returnKeyType = .done
    }
    
    func editable( _ action : Bool){
        txtName.isUserInteractionEnabled = action
        txtAddress.isUserInteractionEnabled = action
        txtDOB.isUserInteractionEnabled = action
        txtContactNumber.isUserInteractionEnabled = action
        txtAadharNumber.isUserInteractionEnabled = action
        txtBankName.isUserInteractionEnabled = action
        txtBankAccountNumber.isUserInteractionEnabled = action
        txtBankIFSC.isUserInteractionEnabled = action
        txtPosition.isUserInteractionEnabled = action
        txtSalaryPerDay.isUserInteractionEnabled = action
       
    }
    
    func showDetails(){
        loadingView(flag: true)
        Firestore.firestore().document("Users/\(UserManager.shared.userId)/Guards/\(NameSelected)").getDocument { (data, err) in
            if err != nil{
                self.view.makeToast(err?.localizedDescription)
            }  else {
                let doc = data!.data()
                self.GuardData = doc!
                self.addDetails(self.GuardData)
                self.loadingView(flag: false)
                
            }
        }
    }
    
    func addDetails(_ GuardDetails : [String : Any]){
        
        AccountNumber = GuardDetails["Bank Account Number"] as? Int ?? 0
        SalaryPerDay = GuardData["SalaryPerDay"] as? Int ?? 0
        AadharNumber = GuardData["Aadhar Number"] as? Int ?? 0
        contact = GuardData["Contact Number"] as? Int ?? 0
        selectedGender = GuardData["Gender"] as? String ?? ""
        
        txtName.text = GuardData["Name"] as? String ?? ""
        txtAddress.text = GuardData["Address"] as? String ?? ""
        txtDOB.text = GuardData["DOB"] as? String ?? ""
        txtContactNumber.text = String(contact)//GuardData["Contact Number"] as? String ?? ""
        txtAadharNumber.text = String(AadharNumber)//GuardData["Aadhar Number"] as? String ?? ""
        txtBankName.text = GuardData["Bank Name"] as? String ?? ""
        txtBankAccountNumber.text = String(AccountNumber)
        txtBankIFSC.text = GuardData["Bank IFSC"] as? String ?? ""
        txtPosition.text = GuardData["Position"] as? String ?? ""
        txtSalaryPerDay.text = String(SalaryPerDay)//GuardData["SalaryPerDay"] as? String ?? ""
        
        
        if selectedGender == "Male"{
            btnMale.setImage(UIImage(named: "RadioButton_checked.png"), for: .normal)
            btnFemale.setImage(UIImage(named:"RadioButton_unchecked.png"), for: .normal)
        } else if selectedGender == "Female" {
            btnMale.setImage(UIImage(named: "RadioButton_unchecked.png"), for: .normal)
            btnFemale.setImage(UIImage(named:"RadioButton_checked.png"), for: .normal)
        }
        
        
        
    }
    


    @IBAction func btnEditAction(_ sender: Any) {
        if btnEdit.titleLabel?.text == "Save"{
            updateData()
            
            
        } else {
            editable(true)
            btnEdit.setTitle("Save", for: .normal)
        }
        
    }
    
    
    func updateData(){
        let contact = txtContactNumber.text!
        let Aadhar = txtAadharNumber.text!
        let BankAccount = txtBankAccountNumber.text!
        let Salary = txtSalaryPerDay.text!
        
        
        FullName = txtName.text!
        Address = txtAddress.text!
        DOB = txtDOB.text!
        ContantNumber = Int(contact) ?? 0
        AadharNumber = Int(Aadhar) ?? 0
        BankName = txtBankName.text!
        BankAccountNumber = Int(BankAccount) ?? 0
        BankIFSC = txtBankIFSC.text!
        Position = txtPosition.text!
        SalaryPerDay = Int(Salary) ?? 0
        
        AddData = ["Name" : FullName, "Address" : Address, "DOB" : DOB, "Gender" : selectedGender ,"Contact Number" : ContantNumber,"Aadhar Number" : AadharNumber, "Bank Name" : BankName, "Bank Account Number" : BankAccountNumber, "Bank IFSC" : BankIFSC, "Position" : Position, "SalaryPerDay" : SalaryPerDay]
        
        self.loadingView(flag: true)
        Firestore.firestore().document("Users/\(UserManager.shared.userId)/Guards/\(NameSelected)").updateData(AddData) { (err) in
            if err != nil{
                self.loadingView(flag: false)
                self.view.makeToast(err?.localizedDescription)
            } else{
                self.loadingView(flag: false)
                self.view.makeToast("Data Updated")
                self.editable(false)
                self.btnEdit.setTitle("Edit", for: .normal)
            }
        }
    }
    
    @IBAction func btnDeleteAction(_ sender: Any) {
        self.alertWithCustomBtnCallback(title: "GS-Tech", message: "Are you sure you want to delete the details", buttonTitle: "Proceed") {
            self.deleteUser()
        }
        
        
    }
    
    @IBAction func btnGenderAction(_ sender: Any) {
    }
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func deleteUser(){
        self.loadingView(flag: true)
        Firestore.firestore().document("Users/\(UserManager.shared.userId)/Guards/\(NameSelected)").delete { (err) in
            if err != nil {
                self.loadingView(flag: false)
                self.view.makeToast(err?.localizedDescription)
            } else {
                self.loadingView(flag: true)
                self.view.makeToast("Selected Guard data deleted successfully")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
