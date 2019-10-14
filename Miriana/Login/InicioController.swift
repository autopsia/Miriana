//
//  InicioController.swift
//  Miriana
//
//  Created by Alumno on 9/25/19.
//  Copyright © 2019 Sector Defectuoso. All rights reserved.
//

import UIKit
import FirebaseAuth

class InicioController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
}
