//
//  User.swift
//  PSHotels
//
//  Created by Panacea-Soft on 1/18/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation

struct User : PSObject {
    
    let user_id : String
    let user_is_sys_admin : String
    let facebook_id : String
    var user_name : String
    var user_email : String
    var user_phone : String
    let user_password : String
    var user_about_me : String
    let user_cover_photo : String
    let user_profile_photo : String
    let added_date : String
    let like_count : String
    let comment_count : String
    let favourite_count : String
    
    static func ==(lhs: User, rhs: User) -> Bool {
        let areEqual = lhs.user_id == rhs.user_id
        
        return areEqual
    }
}
