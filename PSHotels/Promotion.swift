//
//  Promotion.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/1/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

struct Promotion : PSObject, Equatable {
    
    var promo_id : String
    var promo_name: String
    var promo_desc: String
    var promo_percent: String
    var promo_start_time: String
    var promo_end_time: String
    var status: String
    var added_date: String
    
    static func ==(lhs: Promotion, rhs: Promotion) -> Bool {
        let areEqual = lhs.promo_id == rhs.promo_id
        
        return areEqual
    }
}
