//
//  HotelInfoGroup.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/27/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

struct HotelInfoGroup : PSObject, Equatable {
    
    let hinfo_grp_id : String
    let hinfo_grp_name : String
    let types : [HotelInfoType]
    
    static func ==(lhs: HotelInfoGroup, rhs: HotelInfoGroup) -> Bool {
        let areEqual = lhs.hinfo_grp_id == rhs.hinfo_grp_id
        
        return areEqual
    }
}
