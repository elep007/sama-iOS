//
//  Review.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/1/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

struct Review : PSObject {
    var review_parent_id: String
    var rating : Rating
    var review_categories: [ReviewCategories]
    
    static func ==(lhs: Review, rhs: Review) -> Bool {
        let areEqual = lhs.review_parent_id == rhs.review_parent_id
        
        return areEqual
    }
}
