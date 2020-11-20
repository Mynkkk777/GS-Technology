//
//  FirebaseManager.swift
//  GS-Technology
//
//  Created by Mayank Rai on 13/05/20.
//  Copyright © 2020 Mayank Rai. All rights reserved.
//

import UIKit
import Firebase

class FirebaseManager: NSObject {
    let db = Firestore.firestore()

    static let shared = FirebaseManager()
    
    func addGuard(_ documentPath : String, _ Data : [String : Any], onCompletion : @escaping(_ success : String, _ Error: String) -> ()){
        let documentp = "Users/\(UserManager.shared.userId)/Guards/\(documentPath)"
        db.document(documentp).setData(Data) { (err) in
            if err != nil{
                onCompletion("",err!.localizedDescription)
            } else {
                onCompletion("success","")
            }
        }
        
        
    }
//
    func viewGuards(_ onCompletion : @escaping (_ toData : [String : Any], _ err : String) -> ()){
        let documentp = "Users/\(UserManager.shared.userId)/Guards"
        db.document(documentp).addSnapshotListener { (doc, error) in
            if error != nil{
                onCompletion([:],error!.localizedDescription)
            } else{
                let finalData = doc?.data()
                
                onCompletion(finalData!,"")
            }

        }
    }
    
    func view(_ onCompletion : @escaping (_ toData : [String], _ err : String) -> ()){
        db.collection("Users").document("\(UserManager.shared.userId)").collection("Guards").addSnapshotListener { (doc, err) in
            if err != nil{
                onCompletion([],err!.localizedDescription)
            } else{
                var finalData : [String] = []
                finalData.append(doc!.documents.description)
                onCompletion(finalData,"")
            }
            
        }
        
    }
    
    
//
}
