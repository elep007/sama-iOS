//
//  RatingPostObject.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/10/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

struct  RatingPostObject : PSObject{
    
    var rvcat_id : String
    var rvrating_rate : String
    
    init(rvcatId: String, rvratingRate: String) {
        rvcat_id = rvcatId
        rvrating_rate = rvratingRate
    }
    
}
