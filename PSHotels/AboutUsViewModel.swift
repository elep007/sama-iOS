//
//  AboutUsViewModel.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/16/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class AboutUsViewModel : PSViewModel{
    
    //MARK: Variables for controllers
    var isLoading : LiveData<Bool> = LiveData(Bool())
    
    // About Us
    var aboutUsLiveData : LiveData<Resourse<AboutUs>?> = LiveData(Resourse<AboutUs>())
    
    
    //MARK: Private Variables
    private let aboutUsRepository : AboutUsRepository
    
    
    //MARK: Override Methods
    override init() {
        
        aboutUsRepository = AboutUsRepository()
        isLoading.value = false
        
        super.init()
        
        // News By ID
        aboutUsRepository.aboutUsLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                if resourse.status != Status.NO_ACTION {
                    self?.aboutUsLiveData.value = resourse
                }
                
            }
            
        }
    }
    
    func getAboutUs() {
        
        if !isLoading.value {
            isLoading.value = true
            aboutUsRepository.getAboutUs(apiKey: configs.apiKey)
        }
        
    }
    
    
}
