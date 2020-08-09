//
//  HotelInfoType.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/27/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

struct HotelInfoType : PSObject, Equatable {
    
    let hinfo_typ_id : String
    let hinfo_grp_id : String
    let hinfo_typ_name : String
    let hinfo_parent_id : String
    
    static func ==(lhs: HotelInfoType, rhs: HotelInfoType) -> Bool {
        let areEqual = lhs.hinfo_typ_id == rhs.hinfo_typ_id && lhs.hinfo_parent_id == rhs.hinfo_parent_id
        
        return areEqual
    }
}
