//
//  HotelFeature.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/3/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

struct HotelFeature : PSObject, Equatable {
    
    let hinfo_grp_id : String
    let hinfo_grp_name : String
    let hinfo_parent_id : String
    let default_photo : Image
    let types : [HotelInfoType]
    
    static func ==(lhs: HotelFeature, rhs: HotelFeature) -> Bool {
        let areEqual = lhs.hinfo_grp_id == rhs.hinfo_grp_id && lhs.hinfo_parent_id == rhs.hinfo_parent_id
        
        return areEqual
    }
}
