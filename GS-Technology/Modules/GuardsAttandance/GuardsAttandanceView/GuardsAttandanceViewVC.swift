//
//  GuardsAttandanceViewVC.swift
//  GS-Technology
//
//  Created by Mayank Rai on 23/05/20.
//  Copyright © 2020 Mayank Rai. All rights reserved.
//

import UIKit

class GuardsAttandanceViewVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
