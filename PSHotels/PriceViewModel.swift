//
//  PriceViewModel.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/1/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class PriceViewModel : PSViewModel{
    
    //MARK: Variables for controllers
    var isLoading : LiveData<Bool> = LiveData(Bool())
    
    // News By News Id
    var pirceLiveData : LiveData<Resourse<Price>?> = LiveData(Resourse<Price>())
    
    
    //MARK: Private Variables
    private let priceRepository : PriceRepository
    
    
    //MARK: Override Methods
    override init() {
        
        priceRepository = PriceRepository()
        isLoading.value = false
        
        super.init()
        
        priceRepository.priceLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                if resourse.status != Status.NO_ACTION {
                    self?.pirceLiveData.value = resourse
                }
                
            }
            
        }
    }
    
    func getPrice() {
        
        if !isLoading.value {
            isLoading.value = true
            priceRepository.getPrice(apiKey: configs.apiKey)
        }
        
    }
    
    
}
