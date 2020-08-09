//
//  Image2.swift
//  PSHotels
//
//  Created by Panacea-Soft on 1/17/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation

struct Image : PSObject {
    
    let img_id: String
    let img_parent_id: String
    let img_type: String
    let img_path: String
    let Img_width: String
    let img_height: String
    let img_desc: String
    
    init() {
        img_id = ""
        img_parent_id = ""
        img_type = ""
        img_path = ""
        Img_width = ""
        img_height = ""
        img_desc = ""
    }
    
    static func ==(lhs: Image, rhs: Image) -> Bool {
        let areEqual = lhs.img_id == rhs.img_id
        
        return areEqual
    }
    
}

