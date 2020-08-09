//
//  ReviewCategories.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/10/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

struct ReviewCategories : PSObject, Equatable {
    var rvcat_id: String
    var rvcat_name: String
    var status: String
    var added: String
    var rating: Rating
    var review_parent_id : String
    
    static func ==(lhs: ReviewCategories, rhs: ReviewCategories) -> Bool {
        let areEqual = lhs.rvcat_id == rhs.rvcat_id && lhs.review_parent_id == rhs.review_parent_id
        
        return areEqual
    }
}
