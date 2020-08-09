//
//  RoomFeature.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/14/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

struct RoomFeature : PSObject, Equatable {
    
    let rinfo_grp_id : String
    let rinfo_grp_name : String
    let rinfo_parent_id : String
    let default_photo : Image
    let types : [RoomInfoType]
    
    static func ==(lhs: RoomFeature, rhs: RoomFeature) -> Bool {
        let areEqual = lhs.rinfo_grp_id == rhs.rinfo_grp_id && lhs.rinfo_parent_id == rhs.rinfo_parent_id
        
        return areEqual
    }
}
