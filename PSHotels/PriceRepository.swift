//
//  PriceRepository.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/1/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
import Alamofire

class PriceRepository : PSRepository<Any> {
    
    //************************************************************
    //MARK: Get Price
    //************************************************************
    var priceLiveData : LiveData<Resourse<Price>?> = LiveData(Resourse<Price>())
    
    func getPrice(apiKey: String) {
        
        let price = PriceDao.sharedManager.getPrice()
        if price.status == Status.SUCCESS {
            price.status = Status.LOADING
            self.priceLiveData.value = price
        }
        
        if Connectivity.isConnected() {
            Alamofire.request(APIRouters.GetPrice(apiKey)).responseJSON{
                response in
                
                let result = self.parseJson(response: response, dataType: Price.self)
                
                if result.status == Status.SUCCESS {
                    PriceDao.sharedManager.save(result.data!)
                }
                
                self.priceLiveData.value = PriceDao.sharedManager.getPrice()
            }
        }else {
            let noAction = Resourse<Price>()
            noAction.status = Status.NO_ACTION
            self.priceLiveData.value = noAction
        }
    }
    
}

