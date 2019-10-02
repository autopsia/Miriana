//
//  Post.swift
//  Miriana
//
//  Created by Alumno on 10/1/19.
//  Copyright © 2019 Sector Defectuoso. All rights reserved.
//

import UIKit

class Post: NSObject {
    var id = ""
    var author = ""
    var categories = [String]()
    var comments = [Comment]()
    var likes = [String]()
    var location = ""
    var message = ""
    var pictures = [String]()
    var reactions = [Reaction]()
    
}
