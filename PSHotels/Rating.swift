//
//  Review.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/27/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

struct Rating : PSObject {
    
    let final_rating : String
    let rating_text : String
    let review_count : String
    
    init() {
        final_rating = ""
        rating_text = ""
        review_count = ""
    }
}
