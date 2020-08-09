//
//  Room.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/28/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

struct Room : PSObject, Equatable {
    
    let room_id : String
    let hotel_id : String
    let room_name : String
    let room_desc : String
    let room_size : String
    let room_price : String
    let room_no_of_beds : String
    let room_adult_limit : String
    let room_kid_limit : String
    let room_extra_bed_price : String
    let touch_count : String
    let image_count : String
    let currency_symbol : String
    let currency_short_form : String
    let default_photo : Image
    let promotion : Promotion
    let rating: Rating
    let is_available : String
    
    static func ==(lhs: Room, rhs: Room) -> Bool {
        let areEqual = lhs.room_id == rhs.room_id
        
        return areEqual
    }
}
