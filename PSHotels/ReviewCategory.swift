//
//  ReviewCategories.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/1/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

struct ReviewCategory : PSObject, Equatable {
    var rvcat_id: String
    var rvcat_name: String
    var status: String
    var added: String
    //var rating: Rating
    //var review_parent_id : String
    
    static func ==(lhs: ReviewCategory, rhs: ReviewCategory) -> Bool {
        let areEqual = lhs.rvcat_id == rhs.rvcat_id 
        
        return areEqual
    }
}
