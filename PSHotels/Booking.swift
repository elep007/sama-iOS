//
//  Booking.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 5/3/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

struct Booking : PSObject {
    var booking_id: String
    var user_id: String
    var booking_user_name: String
    var booking_user_email: String
    var booking_user_phone: String
    var hotel_id: String
    var room_id: String
    var booking_adult_count: String
    var booking_kid_count: String
    var booking_start_date: String
    var booking_end_date: String
    var booking_extra_bed: String
    var booking_remark: String
    var booking_status: String
    var added_date: String
    var added_date_str: String
    var hotel: Hotel
    var room: Room
    
    static func ==(lhs: Booking, rhs: Booking) -> Bool {
        let areEqual = lhs.booking_id == rhs.booking_id
        
        return areEqual
    }
}
