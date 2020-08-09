//
//  PriceDao.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/1/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class PriceDao {
    
    // Singleton
    class var sharedManager: PriceDao {
        struct Static {
            static let instance = PriceDao()
        }
        return Static.instance
    }
    
    // Core Price
    private let priceFile = "priceFile.json"
    private var price  = Resourse<Price>()
    
    // init
    init() {
        
        // Init
        if let priceFromFile : Price = Storage.retrieve(priceFile, from: .documents, as: Price.self) {
            price = Resourse<Price>(status: Status.SUCCESS, message: "", data: priceFromFile)
        }
    }
    
    
    //***************************************************************
    //MARK: Core Price
    //***************************************************************
    
    // Save and Replace
    func save(_ price : Price) {
        
        self.price.data = price
        self.price.status = Status.SUCCESS
        
        Storage.store(self.price.data!, to: .documents, as: priceFile)
    }
    
    
    // Save and Replace All
    func save(_ priceList : [Price]) {
        
        if let _ = self.price.data {
            for price in priceList {
                self.price.status = Status.SUCCESS
                self.price.data = price
                
            }
        }else {
            if priceList.count > 0 {
                self.price.status = Status.SUCCESS
                self.price.data = priceList[0]
            }
        }
        
        Storage.store(self.price.data!, to: .documents, as: priceFile)
    }
    
    // get Price
    func getPrice()  -> Resourse<Price> {
        return self.price
    }
    
}
