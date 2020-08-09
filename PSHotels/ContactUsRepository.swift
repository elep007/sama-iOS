//
//  ContactUsRepository.swift
//  PSHotels
//
//  Created by Panacea-Soft on 2/13/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation
import Alamofire

class ContactUsRepository : PSRepository<Any> {
    
    //************************************************************
    //MARK: Post Contact us
    //************************************************************
    var postContactUsLiveData : LiveData<Resourse<ApiStatus>?> = LiveData(Resourse<ApiStatus>())
    
    func postContactUs(apiKey: String,
                       contactName : String,
                       contactEmail: String,
                       contactMessage : String,
                       contactPhone : String) {
        
        if Connectivity.isConnected() {
            let param: [String: AnyObject] = ["contact_name": contactName as AnyObject,
                                              "contact_email": contactEmail as AnyObject,
                                              "contact_message": contactMessage as AnyObject,
                                              "contact_phone": contactPhone as AnyObject ]
            
            Alamofire.request(APIRouters.PostContactUs(apiKey, param)).responseJSON{
                response in
                let result = self.parseJson(response: response, dataType: ApiStatus.self)
                
                self.postContactUsLiveData.value = result
            }
        }
    }
    
}
