//
//  GuardsAddVC.swift
//  GS-Technology
//
//  Created by Mayank Rai on 07/05/20.
//  Copyright © 2020 Mayank Rai. All rights reserved.
//

import UIKit

class GuardsAddVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var txtName: HoshiTextField!
    @IBOutlet weak var txtAddress: HoshiTextField!
    @IBOutlet weak var txtDOB: HoshiTextField!
    @IBOutlet weak var txtContactNumber: HoshiTextField!
    @IBOutlet weak var txtAadhharNumber: HoshiTextField!
    @IBOutlet weak var txtBankName: HoshiTextField!
    @IBOutlet weak var txtBankAccountNumber: HoshiTextField!
    @IBOutlet weak var txtBankIFSC: HoshiTextField!
    @IBOutlet weak var txtPosition: HoshiTextField!
    @IBOutlet weak var txtSalaryPerDay: HoshiTextField!
    
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnDropDown: UIButton!
    
    var datePicker = UIDatePicker()
    var position = ["Guard","Head Guard","Bouncer","Manager"]
    var selectedGender = "Male"
    var FullName = ""
    var Address = ""
    var DOB = ""
    var ContantNumber = 0
    var AadharNumber = 0
    var BankName = ""
    var BankAccountNumber = 0
    var BankIFSC = ""
    var Position = ""
    var SalaryPerDay = 0
    var AddData : [String : Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        setDropdown(txtPosition)
        delegate(txtName)
        delegate(txtAddress)
        delegate(txtDOB)
        delegate(txtContactNumber)
        delegate(txtAadhharNumber)
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
        if textField == txtAadhharNumber{
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
    
    
    func setUpTheme(){
        
    }
    
    @IBAction func btnGenderAction(_ sender: UIButton) {
        if sender == btnMale {
            if !btnMale.isSelected {
                btnMale.isSelected = true
                btnMale.setImage(UIImage(named: "RadioButton_checked.png"), for: .normal)
            }
            btnFemale.isSelected = !btnFemale.isSelected
           selectedGender = "Male"
             btnFemale.setImage(UIImage(named:"RadioButton_unchecked.png"), for: .normal)

        }
        else {
            if !btnFemale.isSelected {
                btnFemale.isSelected = true
             btnFemale.setImage(UIImage(named: "RadioButton_checked.png"), for: .normal)
            }
            btnMale.isSelected = !btnFemale.isSelected
           selectedGender = "Female"
         btnMale.setImage(UIImage(named:"RadioButton_unchecked.png"), for: .normal)
        }
        
    }
    
    

    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func validation() -> (Bool,String){
 
           if checkTextValue(txtName) {
               return (false,"Full Name cannot be left blank")
           }
           if checkTextValue(txtAddress) {
               return (false,"Address cannot be empty")
           }
           if checkTextValue(txtDOB) {
                 return(false,"Date of Birth cannot be left blank")
           }
            if checkTextValue(txtContactNumber) {
                  return(false,"Contact Number cannot be left blank")
            }
            if checkTextValue(txtAadhharNumber) {
              return(false,"Aadhar Number cannot be left blank")
            }
            if checkTextValue(txtBankName) {
              return(false,"Bank Name cannot be left blank")
            }
            if checkTextValue(txtBankAccountNumber) {
              return(false,"Bank Account Number cannot be left blank")
            }
            if checkTextValue(txtBankIFSC) {
              return(false,"Bank IFSC cannot be left blank")
            }
            if checkTextValue(txtPosition) {
                    return(false,"Guard Position cannot be left blank")
              }
            if checkTextValue(txtSalaryPerDay) {
              return(false,"Salary per Day cannot be left blank")
            }
           
           return (true,"")
        }
    
    
    
    @IBAction func btnAddAction(_ sender: Any) {
        let val = validation()
        self.loadingView(flag: true)
        if val.0{
            let contact = txtContactNumber.text!
            let Aadhar = txtAadhharNumber.text!
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
            saveData()
            self.loadingView(flag: false)
            self.navigationController?.popViewController(animated: true)
            
            
            
        } else{
            self.loadingView(flag: false)
            self.view.makeToast(val.1, duration: 3.0, position: .bottom)
        }
    }
    
    func saveData(){
        FirebaseManager.shared.addGuard(FullName, AddData) { (data, err) in
            if err != ""{
                self.view.makeToast(err)
            } else
            {
                self.view.makeToast("Data Added Successfully")
            }
        }
        
    }
    
    
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donedatePicker));
        let attributes = [NSAttributedString.Key.font:  UIFont(name: "Helvetica-Bold", size: 14.0)!, NSAttributedString.Key.foregroundColor: UIColor.black]
        doneButton.setTitleTextAttributes(attributes, for: .normal)
        //BarButtonItemAppearance.setTitleTextAttributes(attributes, for: .highlighted)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        cancelButton.setTitleTextAttributes(attributes, for: .normal)
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        txtDOB.inputAccessoryView = toolbar
        txtDOB.inputView = datePicker
    }

    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd / MM / yyyy"//"yyyy-MM-dd"
        txtDOB.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
}


extension GuardsAddVC : UIPickerViewDataSource, UIPickerViewDelegate {
    func setDropdown(_ textField : UITextField) {
        let picker: UIPickerView
        picker = UIPickerView()//frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 300))
        picker.backgroundColor = .clear
        picker.tag = textField.tag
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self


        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black//UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.backgroundColor = .red
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(donePicker))
        let attributes = [NSAttributedString.Key.font:  UIFont(name: "Helvetica-Bold", size: 14.0)!, NSAttributedString.Key.foregroundColor: UIColor.black]
        cancelButton.setTitleTextAttributes(attributes, for: .normal)
        doneButton.setTitleTextAttributes(attributes, for: .normal)

        toolBar.setItems([cancelButton,spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        textField.inputView = picker
        textField.inputAccessoryView = toolBar
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return position.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return position[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            txtPosition.text = position[row]
    }

    @objc func donePicker() {
        txtPosition.endEditing(true)
    }
}
