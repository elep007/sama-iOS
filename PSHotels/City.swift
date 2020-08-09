//
//  City.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/23/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

struct City : PSObject, Equatable {
    let city_id : String
    let country_id : String
    let city_name : String
    let status : String
    let added_date : String
    let added_date_str : String
    let country : Country
    
    static func ==(lhs: City, rhs: City) -> Bool {
        let areEqual = lhs.city_id == rhs.city_id
        
        return areEqual
    }
}
