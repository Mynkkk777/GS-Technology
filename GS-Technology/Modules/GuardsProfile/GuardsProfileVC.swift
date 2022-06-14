//
//  GuardsProfileVC.swift
//  GS-Technology
//
//  Created by Mayank Rai on 02/05/20.
//  Copyright © 2020 Mayank Rai. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class GuardsProfileVC: UIViewController {
    
    
    var GuardNames : [String] = []
    var filteredGuardName : [String] = []
    var type = ""
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableVew: UITableView!
    var lbl : UILabel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVew.delegate = self
        tableVew.dataSource = self
        searchBar.delegate = self
        viewGuards()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewGuards()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       // animateTableView()
    }
    func shadowEffect(_ vew : UIView){
           vew.layer.shadowColor = UIColor.gray.cgColor
           vew.layer.shadowOpacity = 1
           vew.layer.shadowOffset = .zero
           vew.layer.shadowRadius = 7
           vew.layer.cornerRadius = 10
       }
       
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func viewGuards(){
        loadingView(flag: true)
        Firestore.firestore().collection("Users").document(UserManager.shared.userId).collection("Guards").getDocuments { (document, err) in
            if err != nil {
                return
            } else{
                guard let values = document?.documents else {return}
                let nameGuard = values.compactMap{$0.documentID}
                self.GuardNames = nameGuard
                self.tableVew.reloadData()
                self.loadingView(flag: false)
            }
            
        }
       
        
    }
    
    @IBAction func BtnAddAction(_ sender: Any) {
        let vc = GuardsAddVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func animateTableView(){
        tableVew.reloadData()
        let cells = tableVew.visibleCells
        let tableHeight = tableVew.bounds.size.height
        for cell in cells{
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        var delayCounter = 0
        for cell in cells{
            
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    
    
}

extension GuardsProfileVC : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.text == "" {
            return GuardNames.count
        } else {
            return filteredGuardName.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : GuardsProfileTVC = tableVew.dequeueReusableCell(withIdentifier: "GuardsProfileTVC", for: indexPath) as! GuardsProfileTVC
        if searchBar.text == "" {
            cell.lblName.text = GuardNames[indexPath.row]
            self.searchBar.endEditing(true)
        } else {
            cell.lblName.text = filteredGuardName[indexPath.row]
           // return filteredGuardName.count
        }
        
        cell.cellvew.isUserInteractionEnabled = false
        self.shadowEffect(cell.cellvew)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchBar.endEditing(true)
        let vc = GuardsViewVC()
        vc.NameSelected = GuardNames[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension GuardsProfileVC : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchContent), object: nil)
        perform(#selector(searchContent), with: self, afterDelay: 1.0)
    }
    
    @objc func searchContent(){
        self.filteredGuardName = []
        if searchBar.text?.count ?? 0 > 2{
            loadingView(flag: true)
            
            for i in GuardNames {
                                       if i.contains(self.searchBar.text ?? "") {
                                           if !self.filteredGuardName.contains(i){
                                               self.filteredGuardName.append(i)
                                           }
           
                                       }
                                   }
                                   if self.filteredGuardName.count == 0{
                                       self.lbl?.text = "Looks like there are no search results"
                                   }
           
                                   self.tableVew.reloadData()
                                   self.loadingView(flag: false)
            
            
        }
        else if searchBar.text == ""
        {
            self.tableVew.reloadData()
        }
    }
    
}
