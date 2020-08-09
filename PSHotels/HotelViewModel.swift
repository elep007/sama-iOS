//
//  HotelViewModel.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/24/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class HotelViewModel : PSViewModel{
    
    //MARK: Variables for controllers
    var cellId : String = ""
    var isLoading : LiveData<Bool> = LiveData(Bool())
    var isFilter = false
    
    // Hotel By Id
    var hotelByHotelIdLiveData : LiveData<Resourse<Hotel>?> = LiveData(Resourse<Hotel>())
    
    // Recommended Hotel List
    var recommendedHotelLiveData : LiveData<Resourse<[Hotel]>?> = LiveData(Resourse<[Hotel]>())
    var recommendedHotelListOffset = 0
    
    // Promotion Hotel List
    var promotionHotelLiveData : LiveData<Resourse<[Hotel]>?> = LiveData(Resourse<[Hotel]>())
    var promotionHotelListOffset = 0
    
    // Popular Hotel List
    var popularHotelLiveData : LiveData<Resourse<[Hotel]>?> = LiveData(Resourse<[Hotel]>())
    var popularHotelListOffset = 0
    
    // Favourite Hotel List
    var favouriteHotelLiveData : LiveData<Resourse<[Hotel]>?> = LiveData(Resourse<[Hotel]>())
    var favouriteHotelListOffset = 0
    
    // Do Fav Hotels
    var doFavHotelsLiveData : LiveData<Resourse<Hotel>?> = LiveData(Resourse<Hotel>())
    
    // Post Search Hotel
    var postSearchHotelLiveData : LiveData<Resourse<[Hotel]>?> = LiveData(Resourse<[Hotel]>())
    var postSearchHotelListOffset = 0
    
    // Do Hotel Post Touch Count
    var postHotelTouchCountLiveData : LiveData<Resourse<ApiStatus>?> = LiveData(Resourse<ApiStatus>())
    
    
    //MARK: Private Variables
    private let hotelRepository : HotelRepository
    
    
    //MARK: Override Methods
    override init() {
        
        hotelRepository = HotelRepository()
        isLoading.value = false
        
        super.init()
        
        // Hotel By ID
        hotelRepository.hotelByHotelIdLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                if resourse.status != Status.NO_ACTION {
                    self?.hotelByHotelIdLiveData.value = resourse
                }
                
            }
            
        }
        
        // Recommended Hotel List
        hotelRepository.recommendedHotelListLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                if resourse.status != Status.NO_ACTION{
                    self?.recommendedHotelLiveData.value = resourse
                    if let data = resourse.data {
                        self?.recommendedHotelListOffset = data.count
                    }
                }
                
            }
        }
        
        // Promotion Hotel List
        hotelRepository.promotionHotelListLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                if resourse.status != Status.NO_ACTION{
                    self?.promotionHotelLiveData.value = resourse
                    if let data = resourse.data {
                        self?.promotionHotelListOffset = data.count
                    }
                }
                
            }
        }
        
        // Popular Hotel List
        hotelRepository.popularHotelListLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                if resourse.status != Status.NO_ACTION{
                    self?.popularHotelLiveData.value = resourse
                    if let data = resourse.data {
                        self?.popularHotelListOffset = data.count
                    }
                }
                
            }
        }
        
        // Favourite Hotel List
        hotelRepository.favouriteHotelListLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                if resourse.status != Status.NO_ACTION{
                    self?.favouriteHotelLiveData.value = resourse
                    if let data = resourse.data {
                        self?.favouriteHotelListOffset = data.count
                    }
                }
                
            }
        }
        
        // Post Search Hotels
        hotelRepository.postSearchHotelLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                if resourse.status != Status.NO_ACTION{
                    self?.postSearchHotelLiveData.value = resourse
                    if let data = resourse.data {
                        self?.postSearchHotelListOffset = data.count
                    }
                }
                
            }
        }
        
        // Do Fav Hotel
        hotelRepository.doFavHotelLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                if resourse.status != Status.NO_ACTION {
                    self?.doFavHotelsLiveData.value = resourse
                }
                
            }
            
        }
        
        // Do Hotel Post Touch Count
        hotelRepository.postHotelTouchCountLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                
                if resourse.status != Status.NO_ACTION {
                    self?.postHotelTouchCountLiveData.value = resourse
                }
                
            }
            
        }
        
    }
    
    //MARK: Custom Methods
    
    func getHotelById(loginUserId: String, hotelId: String) {
        
        if !isLoading.value {
            isLoading.value = true
            hotelRepository.getHotelByHotelId(apiKey: configs.apiKey, hotelId: hotelId, loginUserId: loginUserId)
        }
        
    }
    
    // Promotion Hotels
    func getPromotionHotelList(loginUserId: String, isLoadFromServer : Bool? = true) {
        
        if !isLoading.value || !isLoadFromServer! {
            isLoading.value = true
            hotelRepository.getPromotionHotelList(apiKey: configs.apiKey,
                                                    loginUserId: loginUserId,
                                                    limit: configs.HOTEL_LIST_COUNT,
                                                    offset: promotionHotelListOffset,
                                                    isLoadFromServer: isLoadFromServer)
            
        }
    }
    
    // Popular Hotels
    func getPopularHotelList(loginUserId: String, isLoadFromServer : Bool? = true) {
        
        if !isLoading.value || !isLoadFromServer! {
            isLoading.value = true
            hotelRepository.getPopularHotelList(apiKey: configs.apiKey,
                                                  loginUserId: loginUserId,
                                                  limit: configs.HOTEL_LIST_COUNT,
                                                  offset: popularHotelListOffset,
                                                  isLoadFromServer: isLoadFromServer)
            
        }
    }
    
    // Favourite Hotels
    func getFavouriteHotelList(loginUserId: String, isLoadFromServer : Bool? = true) {
        
        if !isLoading.value || !isLoadFromServer! {
            isLoading.value = true
            hotelRepository.getFavouriteHotelList(apiKey: configs.apiKey,
                                                loginUserId: loginUserId,
                                                limit: configs.HOTEL_LIST_COUNT,
                                                offset: favouriteHotelListOffset,
                                                isLoadFromServer: isLoadFromServer)
            
        }
    }
    
    // Recommended Hotels
    func getRecommendedHotelList(loginUserId: String, isLoadFromServer : Bool? = true) {
        
        if !isLoading.value || !isLoadFromServer! {
            isLoading.value = true
            hotelRepository.getRecommendedHotelList(apiKey: configs.apiKey,
                                                    loginUserId: loginUserId,
                                                    limit: configs.HOTEL_LIST_COUNT,
                                                    offset: recommendedHotelListOffset,
                                                    isLoadFromServer: isLoadFromServer)
            
        }
    }
    
    func postSearchHotels(cityId: String,
                          loginUserId: String,
                          hotelName : String,
                          starRating : String,
                          lowerPrice : String,
                          upperPrice : String,
                          infoType : String,
                          guestRating: String,
                          isLoadFromServer : Bool = true) {
        
        if !isLoading.value {
            isLoading.value = true
            hotelRepository.postSearchHotel(apiKey: configs.apiKey,
                                            loginUserId: loginUserId,
                                            limit: configs.HOTEL_LIST_COUNT,
                                            offset: postSearchHotelListOffset,
                                            cityId: cityId,
                                            hotelName: hotelName,
                                            starRating: starRating,
                                            lowerPrice: lowerPrice,
                                            upperPrice: upperPrice,
                                            infoType: infoType,
                                            guestRating: guestRating,
                                            isLoadFromServer : isLoadFromServer)
            
        }
    }
    
    
    func doFavHotel(hotelId: String, loginUserId: String) {
        
        if !isLoading.value {
            isLoading.value = true
            hotelRepository.postFavHotel(apiKey: configs.apiKey, hotelId: hotelId, loginUserId: loginUserId)
        }
        
    }
    
    
    func doPostHotelTouchCount(hotelId: String, loginUserId: String) {
        
        hotelRepository.postHotelTouchCount(apiKey: configs.apiKey, hotelId: hotelId, loginUserId: loginUserId)
        
    }
    
}
