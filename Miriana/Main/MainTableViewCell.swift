//
//  MainTableViewCell.swift
//  Miriana
//
//  Created by Alumno on 9/19/19.
//  Copyright © 2019 Sector Defectuoso. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var txtMessage: UILabel!
    

    var post: Dictionary<String, Any> = [:]{
        didSet{
            self.updateData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateData(){
        self.txtMessage.text = self.post["message"] as! String
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
