//
//  CityDao.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/28/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class CityDao {
    
    // Singleton
    class var sharedManager: CityDao {
        struct Static {
            static let instance = CityDao()
        }
        return Static.instance
    }
    
    // Core City
    private let cityFile = "cityFile.json"
    private var cityList  = Resourse<[City]>()
    
    // init
    init() {
        
        // Init
        if let cityListFromFile : [City] = Storage.retrieve(cityFile, from: .documents, as: [City].self) {
            cityList = Resourse<[City]>(status: Status.SUCCESS, message: "", data: cityListFromFile)
        }
    }
    
    
    //***************************************************************
    //MARK: Core City
    //***************************************************************
    
    // Save and Replace
    func save(_ city : City) {
        
        if let data = self.cityList.data {
            let index = data.firstIndex{$0 == city}
            
            if let i = index {
                self.cityList.data?[i] = city
            }else {
                self.cityList.data?.append(city)
            }
            
        }else {
            self.cityList.status = Status.SUCCESS
            self.cityList.data = [city]
        }
        
        Storage.store(cityList.data!, to: .documents, as: cityFile)
    }
    
    // Save and Replace All
    func save(_ cityList : [City]) {
        if let _ = self.cityList.data {
            for city in cityList {
                
                if let data = self.cityList.data {
                    let index = data.firstIndex{$0 == city}
                    
                    if let i = index {
                        self.cityList.data?[i] = city
                    }else {
                        self.cityList.data?.append(city)
                    }
                    self.cityList.status = Status.SUCCESS
                }else {
                    self.cityList.status = Status.SUCCESS
                    self.cityList.data?.append(city)
                }
            }
        }else {
            self.cityList.status = Status.SUCCESS
            self.cityList.data = cityList
        }
        
        
        Storage.store(self.cityList.data!, to: .documents, as: cityFile)
    }
    
    
    func getCityList() -> Resourse<[City]> {
        return cityList
    }
   
    func deleteCityList() {
        cityList.data = [City]()
        Storage.store(self.cityList.data!, to: .documents, as: cityFile)
    }
    
}

