//
//  HomeVC.swift
//  GS-Technology
//
//  Created by Mayank Rai on 02/05/20.
//  Copyright © 2020 Mayank Rai. All rights reserved.
//

import UIKit
import Firebase
import SideMenu

class HomeVC: UIViewController {
    
    @IBOutlet weak var vewOne: UIView!
    @IBOutlet weak var vewTwo: UIView!
    @IBOutlet weak var vewThree: UIView!
    @IBOutlet weak var vewFour: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var imgAttendance: UIImageView!
    @IBOutlet weak var imgGeneralExpenses: UIImageView!
    @IBOutlet weak var imgSalary: UIImageView!
    var menu : SideMenuNavigationController?
    var image : UIImage!
    var GuardName : [String] = []
    var LeftMenuVCForNavigation : LeftmenuVC?

    override func viewDidLoad() {
        super.viewDidLoad()
    //    guardData()
        LeftMenuVCForNavigation = StoryBoards.Main.getStoryBoard().instantiateViewController(identifier: "LeftmenuVC") as! LeftmenuVC
        menu = SideMenuNavigationController.init(rootViewController: LeftMenuVCForNavigation ?? UIViewController())
        menu?.navigationBar.isHidden = true
        menu?.menuWidth = UIScreen.main.bounds.width * 0.75
        menu?.hidesBarsOnTap = true
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        shadowEffect(vewOne)
        shadowEffect(vewTwo)
        shadowEffect(vewThree)
        shadowEffect(vewFour)
        setImgTintColor([imgAttendance,imgProfile,imgGeneralExpenses,imgSalary], color: hexStringToUIColor("2A96E7"))

    }
    
    func shadowEffect(_ vew : UIView){
        vew.layer.shadowColor = UIColor.gray.cgColor
        vew.layer.shadowOpacity = 1
        vew.layer.shadowOffset = .zero
        vew.layer.shadowRadius = 7
        vew.layer.cornerRadius = 10
    }
    
    func guardData(){
        Firestore.firestore().collection("Users").document(UserManager.shared.userId).collection("Guards").getDocuments { (document, err) in
            if err != nil {
                return
            } else{
                guard let values = document?.documents else {return}
                   // self.Name = values.compactMap{$0.documentID }
                let nameGuard = values.compactMap{$0.documentID}
                self.GuardName = nameGuard
            }
            
        }
    }

    @IBAction func btnProfileAction(_ sender: Any) {
        let vc : GuardsProfileVC = StoryBoards.Main.getStoryBoard().instantiateViewController(withIdentifier: "GuardsProfileVC") as! GuardsProfileVC
      //  vc.Name = GuardName
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnAttendanceAction(_ sender: Any) {
        let vc : GuardsAttendanceVC = StoryBoards.Main.getStoryBoard().instantiateViewController(withIdentifier: "GuardsAttendanceVC") as! GuardsAttendanceVC
         self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnExpensesAction(_ sender: Any) {
        let vc : GuardsExpensesVC = StoryBoards.Main.getStoryBoard().instantiateViewController(withIdentifier: "GuardsExpensesVC") as! GuardsExpensesVC
             self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnSalaryAction(_ sender: Any) {
        let vc : GuardsSalaryVC = StoryBoards.Main.getStoryBoard().instantiateViewController(withIdentifier: "GuardsSalaryVC") as! GuardsSalaryVC
                   self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnLeftMenuAction(_ sender: Any) {
//        let vc : LeftmenuVC = StoryBoards.Main.getStoryBoard().instantiateViewController(identifier: "LeftmenuVC") as! LeftmenuVC
//
//        vc.modalPresentationStyle = .overFullScreen
//        self.presentMenu(vc)
        present(menu!, animated: true, completion: nil)
    }
    

}
