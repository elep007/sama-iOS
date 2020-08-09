//
//  Hotel.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/24/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

struct Hotel : PSObject, Equatable {
    
    let hotel_id : String
    let city_id : String
    let hotel_name : String
    let hotel_desc : String
    let hotel_address : String
    let hotel_lat : String
    let hotel_lng : String
    let hotel_phone : String
    let hotel_email : String
    let hotel_min_price : String
    let hotel_max_price : String
    let hotel_star_rating : String
    let hotel_check_in : String
    let hotel_check_out : String
    let is_recommended : String
    let status : String
    let added_date : String
    let added_date_str : String
    let default_photo: Image
    let currency_symbol : String
    let currency_short_form : String
    let promotion : Promotion
    let rating : Rating
    let touch_count : String
    let image_count : String
    var is_user_favourited : String
    
    
    static func ==(lhs: Hotel, rhs: Hotel) -> Bool {
        let areEqual = lhs.hotel_id == rhs.hotel_id
        
        return areEqual
    }
}
