//
//  Country.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/23/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

struct Country : PSObject, Equatable {
    let country_id : String
    let country_name : String
    let status : String
    let added_date : String
    
    static func ==(lhs: Country, rhs: Country) -> Bool {
        let areEqual = lhs.country_id == rhs.country_id
        
        return areEqual
    }
}
