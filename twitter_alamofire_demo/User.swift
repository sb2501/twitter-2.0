//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var screen_name: String
    var profile_image_url: String
    
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as! String
        screen_name = dictionary["screen_name"] as! String
        profile_image_url = dictionary["profile_image_url"] as! String

    }
}
