//
//  HotelInfoRepository.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/27/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
import Alamofire

class HotelFeatureRepository : PSRepository<Any> {
    
    //************************************************************
    //MARK: Get Hotel Features By Hotel Id
    //************************************************************
    var hotelFeaturesByHotelIdLiveData : LiveData<Resourse<[HotelFeature]>?> = LiveData(Resourse<[HotelFeature]>())
    
    func getHotelFeatureByHotelId(apiKey: String, hotelId: String) {
        
        
       
        let hotelFeature = HotelFeatureDao.sharedManager.getHotelFeatureById(hotelId)
        if hotelFeature.status == Status.SUCCESS {
            hotelFeature.status = Status.LOADING
            self.hotelFeaturesByHotelIdLiveData.value = hotelFeature
        }
        
        
        
        if Connectivity.isConnected() {
            Alamofire.request(APIRouters.GetHotelFeaturesByHotelId(apiKey, hotelId)).responseJSON{
                response in
                let result = self.parseJson(response: response, dataType: [HotelFeature].self)
                
                if result.status == Status.SUCCESS {
                    HotelFeatureDao.sharedManager.deleteHotelFeatureByParentId(hotelId)
                    
                    HotelFeatureDao.sharedManager.save(result.data!)
                
                }
                self.hotelFeaturesByHotelIdLiveData.value = HotelFeatureDao.sharedManager.getHotelFeatureById(hotelId)
                
            }
        }else {
            let noAction = Resourse<[HotelFeature]>()
            noAction.status = Status.NO_ACTION
            self.hotelFeaturesByHotelIdLiveData.value = noAction
        }
    }
    
    //************************************************************
    //MARK: Get Hotel Features By City Id
    //************************************************************
    var hotelFeaturesByCityIdLiveData : LiveData<Resourse<[HotelFeature]>?> = LiveData(Resourse<[HotelFeature]>())
    
    func getHotelFeatureByCityId(apiKey: String, cityId: String) {
        
        
        let hotelFeature = HotelFeatureDao.sharedManager.getHotelFeatureById(cityId)
        if hotelFeature.status == Status.SUCCESS {
            hotelFeature.status = Status.LOADING
            self.hotelFeaturesByCityIdLiveData.value = hotelFeature
        }
        
        
        if Connectivity.isConnected() {
            Alamofire.request(APIRouters.GetHotelFeaturesByCityId(apiKey, cityId)).responseJSON{
                response in
                let result = self.parseJson(response: response, dataType: [HotelFeature].self)
                
                if result.status == Status.SUCCESS {
                    HotelFeatureDao.sharedManager.deleteHotelFeatureByParentId(cityId)
                    
                    HotelFeatureDao.sharedManager.save(result.data!)
                    
                }
                self.hotelFeaturesByCityIdLiveData.value = HotelFeatureDao.sharedManager.getHotelFeatureById(cityId)
                
            }
        }else {
            let noAction = Resourse<[HotelFeature]>()
            noAction.status = Status.NO_ACTION
            self.hotelFeaturesByCityIdLiveData.value = noAction
        }
    }
    
    
    
}
