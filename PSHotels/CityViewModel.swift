//
//  CityViewModel.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/23/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class CityViewModel : PSViewModel{

    //MARK: Variables for controllers
    var cellId : String = ""
    var isLoading : LiveData<Bool> = LiveData(Bool())
    var isFilter = false
    
    // City List
    var citiesLiveData : LiveData<Resourse<[City]>?> = LiveData(Resourse<[City]>())
    var filterCities : [City] = [City]()
    
    
    //MARK: Private Variables
    private let cityRepository : CityRepository
    
    
    //MARK: Override Methods
    override init() {
        
        cityRepository = CityRepository()
        isLoading.value = false
        
        super.init()
        
        // Cities
        cityRepository.citiesLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                if resourse.status != Status.NO_ACTION {
                    self?.citiesLiveData.value = resourse
                }
            }
            
        }
    }
    
    //MARK: Custom Methods
    func getCities() {
        
        if !isLoading.value {
            isLoading.value = true
            cityRepository.getCities(apiKey: configs.apiKey)
            
        }
    }
    
    func filterCity(_ filterStr: String){
        
        if let cities : [City] = citiesLiveData.value?.data {
            filterCities = cities.filter{$0.city_name.localizedStandardContains(filterStr)}
            
        }
    }
    
}
