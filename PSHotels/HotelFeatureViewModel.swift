//
//  HotelInfoViewModel.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/27/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class HotelFeatureViewModel : PSViewModel{

    //MARK: Variables for controllers
    var isLoading : LiveData<Bool> = LiveData(Bool())
    var cellId : String = ""
    var headerCellId : String = ""
    
    // Hotel Features List By Hotel Id
    var hotelFeatureListByHotelIdLiveData : LiveData<Resourse<[HotelFeature]>?> = LiveData(Resourse<[HotelFeature]>())
    
    // Hotel Features List By City Id
    var hotelFeatureListByCityIdLiveData : LiveData<Resourse<[HotelFeature]>?> = LiveData(Resourse<[HotelFeature]>())
    
    //MARK: Private Variables
    private let hotelFeatureRepository : HotelFeatureRepository
    
    
    //MARK: Override Methods
    override init() {
        
        hotelFeatureRepository = HotelFeatureRepository()
        isLoading.value = false
        
        super.init()
        
        // Hotel Features By Hotel Id
        hotelFeatureRepository.hotelFeaturesByHotelIdLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                if resourse.status != Status.NO_ACTION {
                    self?.hotelFeatureListByHotelIdLiveData.value = resourse
                    
                }
                
            }
            
        }
        
        
        // Hotel Features By City Id
        hotelFeatureRepository.hotelFeaturesByCityIdLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                if resourse.status != Status.NO_ACTION {
                    self?.hotelFeatureListByCityIdLiveData.value = resourse
                    
                }
                
            }
            
        }
    }
    
    //MARK: Custom Methods
    
    func getHotelFeatures(hotelId: String) {
        
        if !isLoading.value {
            isLoading.value = true
            hotelFeatureRepository.getHotelFeatureByHotelId(apiKey: configs.apiKey, hotelId: hotelId)
            
        }
    }
    
    func getHotelFeatures(cityId: String) {
        
        if !isLoading.value {
            isLoading.value = true
            hotelFeatureRepository.getHotelFeatureByCityId(apiKey: configs.apiKey, cityId: cityId)
            
        }
    }
}
