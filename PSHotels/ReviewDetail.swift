//
//  ReviewDetail.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/1/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

struct ReviewDetail : PSObject, Equatable {
    
    var review_id: String
    var room_id: String
    var user_id: String
    var review_desc: String
    var status: String
    var added_date: String
    var added_date_str: String
    var room_name: String
    var user: User
    var rating: Rating
    var review_parent_id: String
    
    static func ==(lhs: ReviewDetail, rhs: ReviewDetail) -> Bool {
        let areEqual = lhs.review_id == rhs.review_id && lhs.review_parent_id == rhs.review_parent_id
        
        return areEqual
    }
}
