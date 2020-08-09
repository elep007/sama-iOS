//
//  HotelFeatureDao.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/7/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class HotelFeatureDao {
    
    // Singleton
    class var sharedManager: HotelFeatureDao {
        struct Static {
            static let instance = HotelFeatureDao()
        }
        return Static.instance
    }
    
    // Core HotelFeature
    private let hotelFeatureFile = "HotelFeature.json"
    private var hotelFeatureList  = Resourse<[HotelFeature]>()
    
    // init
    init() {
        
        // Init Core
        if let hotelFeatureListFromFile : [HotelFeature] = Storage.retrieve(hotelFeatureFile, from: .documents, as: [HotelFeature].self) {
            hotelFeatureList = Resourse<[HotelFeature]>(status: Status.SUCCESS, message: "", data: hotelFeatureListFromFile)
        }
        
    }
    
    
    //***************************************************************
    //MARK: Core HotelFeature
    //***************************************************************
    
    // Save and Replace
    func save(_ hotelFeature : HotelFeature) {
        
        if let data = self.hotelFeatureList.data {
            let index = data.firstIndex{$0 == hotelFeature}
            
            if let i = index {
                self.hotelFeatureList.data?[i] = hotelFeature
            }else {
                self.hotelFeatureList.data?.append(hotelFeature)
            }
            
        }else {
            self.hotelFeatureList.status = Status.SUCCESS
            self.hotelFeatureList.data = [hotelFeature]
        }
        
        Storage.store(hotelFeatureList.data!, to: .documents, as: hotelFeatureFile)
    }
    
    // Save and Replace All
    func save(_ hotelFeatureList : [HotelFeature]) {
        for hotelFeature in hotelFeatureList {
            save(hotelFeature)
        }
    }
    
    // delete by parent id
    func deleteHotelFeatureByParentId(_ parent_id: String) {
        if let data = hotelFeatureList.data {
            let result = data.filter{$0.hinfo_parent_id != parent_id}
            hotelFeatureList.data = result
            Storage.store(hotelFeatureList.data!, to: .documents, as: hotelFeatureFile)
        }
    }
    
    // get hotelFeature by parent id
    func getHotelFeatureById(_ hinfo_parent_id: String)  -> Resourse<[HotelFeature]> {
        
        let hotelFeatureHolder : Resourse<[HotelFeature]> = Resourse<[HotelFeature]>()
        
        if let data = hotelFeatureList.data {
            let hotelFilter = data.filter{$0.hinfo_parent_id == hinfo_parent_id}
            if hotelFilter.count > 0 {
                hotelFeatureHolder.data = hotelFilter
                hotelFeatureHolder.status = Status.SUCCESS
            }
            
        }
        
        return hotelFeatureHolder
    }
    
    //***************************************************************
    // End Core HotelFeature
    //***************************************************************
    
}

