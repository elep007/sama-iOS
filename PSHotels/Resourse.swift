//
//  Resourse.swift
//  PSHotels
//
//  Created by Panacea-Soft on 1/18/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation

class Resourse<PSObject> {
    
    var status: Status
    var message: String
    var data: PSObject?
    
    init() {
        status = Status.NO_ACTION
        message = ""
        data = nil
    }
    
    init(status: Status, message: String) {
        self.status = status
        self.message = message
        data = nil
    }
    
    init(status: Status, message: String, data: PSObject) {
        self.status = status
        self.message = message
        self.data = data
    }
    
    
    
}
