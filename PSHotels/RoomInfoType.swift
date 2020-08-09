//
//  RoomInfoType.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/14/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

struct RoomInfoType : PSObject, Equatable {
    
    let rinfo_typ_id : String
    let rinfo_grp_id : String
    let rinfo_typ_name : String
    let rinfo_parent_id : String
    
    static func ==(lhs: RoomInfoType, rhs: RoomInfoType) -> Bool {
        let areEqual = lhs.rinfo_typ_id == rhs.rinfo_typ_id && lhs.rinfo_parent_id == rhs.rinfo_parent_id
        
        return areEqual
    }
}
