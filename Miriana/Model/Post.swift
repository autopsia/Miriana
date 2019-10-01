//
//  Post.swift
//  Miriana
//
//  Created by Alumno on 10/1/19.
//  Copyright © 2019 Sector Defectuoso. All rights reserved.
//

import UIKit

struct Post {
    var id: String
    var author: String
    var categories: [String]
    var comments: [Comment]
    var likes: Array<String>
    var location: String
    var message: String
    var pictures: [String]
    var reactions: [Reaction]
    

}
