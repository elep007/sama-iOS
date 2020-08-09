//
//  NotificationViewModel.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/17/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class NotificationViewModel : PSViewModel {
    
    
    //MARK: Variables for controllers
    var isLoading : LiveData<Bool> = LiveData(Bool())
    
    // Noti
    var postNotificationLiveData : LiveData<Resourse<ApiStatus>?> = LiveData(Resourse<ApiStatus>())
    
    //MARK: Private Variables
    private let notificationRepository : NotificationRepository
    
    //MARK: Override Methods
    override init() {
        
        notificationRepository = NotificationRepository()
        isLoading.value = false
        
        super.init()
        
        notificationRepository.postRegisterNotiLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                self?.postNotificationLiveData.value = resourse
                
            }
            
        }
        
        notificationRepository.postUnRegisterNotiLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                self?.postNotificationLiveData.value = resourse
                
            }
            
        }
    }
    
    
    func postNotification(token: String, platform: String, isRegister: Bool) {
        
        if isRegister {
            if !isLoading.value {
                isLoading.value = true
                notificationRepository.postRegisterNotification(apiKey: configs.apiKey, platform: platform, token: token)
            }
        }else {
            if !isLoading.value {
                isLoading.value = true
                notificationRepository.postUnRegisterNotification(apiKey: configs.apiKey, platform: platform, token: token)
            }
        }
        
    }
        
}
