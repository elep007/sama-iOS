//
//  NotificationRepository.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/17/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
import Alamofire

class NotificationRepository : PSRepository<Any> {

    //************************************************************
    //MARK: Register Notification
    //************************************************************
    var postRegisterNotiLiveData : LiveData<Resourse<ApiStatus>?> = LiveData(Resourse<ApiStatus>())
    
    func postRegisterNotification(apiKey: String,
                                  platform : String,
                                  token: String) {
        
        let param: [String: AnyObject] = ["platform_name": platform as AnyObject, "device_id": token as AnyObject]
        
        if Connectivity.isConnected() {
            Alamofire.request(APIRouters.PostRegisterNotiToken(apiKey, param)).responseJSON{
                response in
                let result = self.parseJson(response: response, dataType: ApiStatus.self)
                
                self.postRegisterNotiLiveData.value = result
            }
        }
    }
    
    //************************************************************
    //MARK: UnRegister Notification
    //************************************************************
    var postUnRegisterNotiLiveData : LiveData<Resourse<ApiStatus>?> = LiveData(Resourse<ApiStatus>())
    
    func postUnRegisterNotification(apiKey: String,
                                  platform : String,
                                  token: String) {
        
        let param: [String: AnyObject] = ["platform_name": platform as AnyObject, "device_id": token as AnyObject]
        
        if Connectivity.isConnected() {
            Alamofire.request(APIRouters.PostUnregisterNotiToken(apiKey, param)).responseJSON{
                response in
                let result = self.parseJson(response: response, dataType: ApiStatus.self)
                
                self.postUnRegisterNotiLiveData.value = result
            }
        }
    }
    
}
