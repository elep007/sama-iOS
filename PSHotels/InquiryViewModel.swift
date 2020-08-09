//
//  InquiryViewModel.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/15/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class InquiryViewModel : PSViewModel{
    
    //MARK: Variables for controller
    var isLoading : LiveData<Bool> = LiveData(Bool())
    
    // post contact Us
    var postInquiryLiveData : LiveData<Resourse<ApiStatus>?> = LiveData(Resourse<ApiStatus>())
    
    //MARK: Private Variables
    private let inquiryRepository : InquiryRepository
    
    //MARK: Override Methods
    override init() {
        inquiryRepository = InquiryRepository()
        isLoading.value = false
        
        super.init()
        
        // Post Contact Us
        inquiryRepository.postInquiryLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                self?.postInquiryLiveData.value = resourse
                
            }
            
        }
    }
    
    func postInquiry(
                     hotelId: String,
                     roomId: String,
                     userId: String,
                     contactName : String,
                     contactEmail : String,
                     contactPhone : String,
                     inquiryTitle : String,
                     inquiryMessage : String) {
        
        if !isLoading.value {
            isLoading.value = true
            inquiryRepository.postInquiry(apiKey: configs.apiKey,
                                          hotelId: hotelId,
                                          roomId: roomId,
                                          userId: userId,
                                          contactName: contactName,
                                          contactEmail: contactEmail,
                                          contactPhone: contactPhone,
                                          inquiryTitle: inquiryTitle,
                                          inquiryMessage: inquiryMessage)
        }
        
    }
    
}
