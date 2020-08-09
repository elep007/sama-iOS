//
//  CityRepository.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/23/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
import Alamofire

class CityRepository : PSRepository<Any> {
    
    //************************************************************
    //MARK: Get Cities
    //************************************************************
    var citiesLiveData : LiveData<Resourse<[City]>?> = LiveData(Resourse<[City]>())
    
    func getCities(apiKey: String) {
       
        let cityList = CityDao.sharedManager.getCityList()
        if cityList.status == Status.SUCCESS {
            cityList.status = Status.LOADING
            self.citiesLiveData.value = cityList
        }
        
        
        if Connectivity.isConnected() {
            Alamofire.request(APIRouters.GetCities(apiKey)).responseJSON{
                    response in
                    let result = self.parseJson(response: response, dataType: [City].self)
                
                    if result.status == Status.SUCCESS {
                        CityDao.sharedManager.deleteCityList()
                        CityDao.sharedManager.save(result.data!)
                    }
                
                    self.citiesLiveData.value = CityDao.sharedManager.getCityList()
            }
        }else {
            let noAction = Resourse<[City]>()
            noAction.status = Status.NO_ACTION
            self.citiesLiveData.value = noAction
        }
    }
}
