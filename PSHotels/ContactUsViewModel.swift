//
//  ContactUsViewModel.swift
//  PSHotels
//
//  Created by Panacea-Soft on 2/13/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation

class ContactUsViewModel : PSViewModel{

    //MARK: Variables for controller
    var isLoading : LiveData<Bool> = LiveData(Bool())
    
    // post contact Us
    var postContactUsLiveData : LiveData<Resourse<ApiStatus>?> = LiveData(Resourse<ApiStatus>())
    
    //MARK: Private Variables
    private let contactUsRepository : ContactUsRepository
    
    //MARK: Override Methods
    override init() {
        contactUsRepository = ContactUsRepository()
        isLoading.value = false
        
        super.init()
        
        // Post Contact Us
        contactUsRepository.postContactUsLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                self?.postContactUsLiveData.value = resourse
                
            }
            
        }
    }
    
    func postContactUs(contactName: String, contactEmail: String, contactPhone: String, contactMessage: String) {
        
        if !isLoading.value {
            isLoading.value = true
            contactUsRepository.postContactUs(apiKey: configs.apiKey, contactName: contactName, contactEmail: contactEmail, contactMessage: contactMessage, contactPhone: contactPhone)
        }
        
    }
    
}
