//
//  AllPostsViewController.swift
//  Miriana
//
//  Created by Alumno on 9/19/19.
//  Copyright © 2019 Sector Defectuoso. All rights reserved.
//

import UIKit

class AllPostsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension AllPostsViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "MainTableView"
        let  cell = tableView.dequeueReusableCell(withIdentifier: identifier , for: indexPath) as! MainTableViewCell
        
        let r = CGFloat(arc4random()%255) / 255.0
        let g = CGFloat(arc4random()%255) / 255.0
        let b = CGFloat(arc4random()%255) / 255.0
        
        cell.backgroundColor = UIColor(displayP3Red: r, green: g, blue: b, alpha: 1)
        
        
        return cell
    }
}
