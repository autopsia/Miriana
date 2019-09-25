//
//  LoginViewController.swift
//  Miriana
//
//  Created by Alumno on 9/25/19.
//  Copyright © 2019 Sector Defectuoso. All rights reserved.
//

import UIKit
import FirebaseFirestore

class LoginViewController: UIViewController {
    @IBOutlet weak var lblUsuario: CSMTextField!
    @IBOutlet weak var lblClave: CSMTextField!
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loguear(_ sender: CSMButton) {
        let user: String? = self.lblUsuario.text
        let pass: String? = self.lblClave.text
        
        db.collection("users").whereField("username", isEqualTo: user as Any).whereField("password", isEqualTo: pass as Any)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        
                    }
                }
        }
    }
    
}
