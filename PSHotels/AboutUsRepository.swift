//
//  AboutUsRepository.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/16/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
import Alamofire

class AboutUsRepository : PSRepository<Any> {

    //************************************************************
    //MARK: Get About Us
    //************************************************************
    var aboutUsLiveData : LiveData<Resourse<AboutUs>?> = LiveData(Resourse<AboutUs>())
    
    func getAboutUs(apiKey: String) {
        
        let aboutUs = AboutUsDao.sharedManager.getAboutUs()
        if aboutUs.status == Status.SUCCESS {
            aboutUs.status = Status.LOADING
            self.aboutUsLiveData.value = aboutUs
        }
        
        if Connectivity.isConnected() {
            Alamofire.request(APIRouters.GetAboutUs(apiKey)).responseJSON{
                response in
                
                    let result = self.parseJson(response: response, dataType: [AboutUs].self)
                
                    if result.status == Status.SUCCESS {
                        AboutUsDao.sharedManager.save(result.data!)
                    }
                
                    self.aboutUsLiveData.value = AboutUsDao.sharedManager.getAboutUs()
            }
        }else {
            let noAction = Resourse<AboutUs>()
            noAction.status = Status.NO_ACTION
            self.aboutUsLiveData.value = noAction
        }
    }

}
