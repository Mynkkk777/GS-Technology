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
    var type = ""
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableVew: UITableView!
    var lbl : UILabel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVew.delegate = self
        tableVew.dataSource = self
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewGuards()
        tableVew.reloadData()
    }
    
    func shadowEffect(_ vew : UIView){
           vew.layer.shadowColor = UIColor.gray.cgColor
           vew.layer.shadowOpacity = 1
           vew.layer.shadowOffset = .zero
           vew.layer.shadowRadius = 7
           vew.layer.cornerRadius = 10
       }
       
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        if type == "leftMenu"{
            dismissMenuLeft()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func viewGuards(){
        loadingView(flag: true)
        Firestore.firestore().collection("Users").document(UserManager.shared.userId).collection("Guards").getDocuments { (document, err) in
            if err != nil {
                return
            } else{
                guard let values = document?.documents else {return}
                   // self.Name = values.compactMap{$0.documentID }
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
    
    
}

extension GuardsProfileVC : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GuardNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : GuardsProfileTVC = tableVew.dequeueReusableCell(withIdentifier: "GuardsProfileTVC", for: indexPath) as! GuardsProfileTVC
        cell.lblName.text = GuardNames[indexPath.row]
        self.shadowEffect(cell.cellvew)
       // tableVew.reloadData()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        if searchBar.text == ""{
            self.lbl?.text = "Looks like there are no search results"
            self.tableVew.reloadData()
        }else{
            loadingView(flag: true)
//            Firestore.firestore().collection("Users").document(UserManager.shared.userId).collection("Guards").getDocuments { (document, err) in
//                if err != nil {
//                    return
//                } else{
//                    guard let values = document?.documents else {return}
//                       // self.Name = values.compactMap{$0.documentID }
//                    let nameGuard = values.compactMap{$0.documentID}
//                    self.GuardNames = nameGuard
//                    self.tableVew.reloadData()
//                    self.loadingView(flag: false)
//                }
//
//            }
//            Firestore.firestore().collection("Users").document(UserManager.shared.userId).collection("Guards").g
        }
    }
    
}
