//
//  FavouriteHotel.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/28/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

struct FavouriteHotel : PSObject, Equatable {
    var hotel_id: String
    
    init(_ hotel_id : String ) {
        self.hotel_id = hotel_id
    }
    
    static func ==(lhs: FavouriteHotel, rhs: FavouriteHotel) -> Bool {
        let areEqual = lhs.hotel_id == rhs.hotel_id
        
        return areEqual
    }
}
