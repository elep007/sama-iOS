//
//  InquiryRepository.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/14/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
import Alamofire

class InquiryRepository : PSRepository<Any> {
    
    //************************************************************
    //MARK: Post Inquiry
    //************************************************************
    var postInquiryLiveData : LiveData<Resourse<ApiStatus>?> = LiveData(Resourse<ApiStatus>())
    
    func postInquiry(apiKey : String,
                       hotelId: String,
                       roomId: String,
                       userId: String,
                       contactName : String,
                       contactEmail : String,
                       contactPhone : String,
                       inquiryTitle : String,
                       inquiryMessage : String) {
        
        if Connectivity.isConnected() {
            let param: [String: AnyObject] = [
                                              "hotel_id": hotelId as AnyObject,
                                              "room_id": roomId as AnyObject,
                                              "user_id": userId as AnyObject,
                                              "inq_name": inquiryTitle as AnyObject,
                                              "inq_desc": inquiryMessage as AnyObject,
                                              "inq_user_name": contactName as AnyObject,
                                              "inq_user_email": contactEmail as AnyObject,
                                              "inq_user_phone": contactPhone as AnyObject]
            print(param)
            Alamofire.request(APIRouters.PostInquiry(apiKey, param)).responseJSON{
                response in
                let result = self.parseJson(response: response, dataType: ApiStatus.self)
                
                self.postInquiryLiveData.value = result
            }
        }
    }
    
}
