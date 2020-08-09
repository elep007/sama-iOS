//
//  HotelRepository.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/24/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
import Alamofire

class HotelRepository : PSRepository<Any> {
    
    
    //************************************************************
    //MARK: Hotel By hotel_id
    //************************************************************
    var hotelByHotelIdLiveData : LiveData<Resourse<Hotel>?> = LiveData(Resourse<Hotel>())
    
    func getHotelByHotelId(apiKey: String,
                         hotelId: String,
                         loginUserId: String) {
        
        let hotel = HotelDao.sharedManager.getHotelById(hotelId)
        if hotel.status == Status.SUCCESS {
            hotel.status = Status.LOADING
            self.hotelByHotelIdLiveData.value = hotel
        }
        
        if Connectivity.isConnected() {
            Alamofire.request(APIRouters.GetHotelByHotelId(apiKey,
                                                     loginUserId,
                                                     hotelId)).responseJSON{
                    response in
                    let result = self.parseJson(response: response, dataType: [Hotel].self)
                                        
                                        
                    if result.status == Status.SUCCESS {
                        HotelDao.sharedManager.save(result.data!)
                    }
                                                        
                    self.hotelByHotelIdLiveData.value = HotelDao.sharedManager.getHotelById(hotelId)
            }
        }else {
            let noAction = Resourse<Hotel>()
            noAction.status = Status.NO_ACTION
            self.hotelByHotelIdLiveData.value = noAction
        }
    }
    
    //************************************************************
    //MARK: Get Recommended Hotels
    //************************************************************
    var recommendedHotelListLiveData : LiveData<Resourse<[Hotel]>?> = LiveData(Resourse<[Hotel]>())
    
    func getRecommendedHotelList(apiKey: String,
                         loginUserId : String,
                         limit: Int,
                         offset: Int,
                         isLoadFromServer : Bool? = true) {
        
        if (offset <= 0) {
            // Load From Local
            // Only for offset is 0
            // If offset is not 0, it is loading for next page,
            // So, no need to load from cache
            let hotel = HotelDao.sharedManager.getFeaturedHotel()
            if hotel.status == Status.SUCCESS {
                hotel.status = Status.LOADING
                self.recommendedHotelListLiveData.value = hotel
            }
        }
        
        // Load From Server
        if isLoadFromServer! {
            if Connectivity.isConnected() {
               
                Alamofire.request(APIRouters.GetRecommendedHotelList(apiKey, loginUserId, limit, offset)).responseJSON{
                    response in
                    
                    let result = self.parseJson(response: response, dataType: [Hotel].self)
                    
                    if offset <= 0 { // delete all search
                        HotelDao.sharedManager.deleteFeaturedHotel()
                    }
                    
                    if result.status == Status.SUCCESS {
                        let recommendedHotelList = HotelDao.sharedManager.convertToFeaturedHotel(result.data!)
                        
                        HotelDao.sharedManager.save(result.data!)
                        HotelDao.sharedManager.save(recommendedHotelList)
                    }
                    
                    let rData : Resourse<[Hotel]> = HotelDao.sharedManager.getFeaturedHotel()
                    rData.status = result.status
                    rData.message = result.message
                    self.recommendedHotelListLiveData.value = rData
                    
                }
            }else {
                let noAction = Resourse<[Hotel]>()
                noAction.status = Status.NO_ACTION
                self.recommendedHotelListLiveData.value = noAction
            }
        }
    }
    
    //************************************************************
    //MARK: Get Promotion Hotels
    //************************************************************
    var promotionHotelListLiveData : LiveData<Resourse<[Hotel]>?> = LiveData(Resourse<[Hotel]>())
    
    func getPromotionHotelList(apiKey: String,
                                 loginUserId : String,
                                 limit: Int,
                                 offset: Int,
                                 isLoadFromServer : Bool? = true) {
        
        if (offset <= 0) {
            // Load From Local
            // Only for offset is 0
            // If offset is not 0, it is loading for next page,
            // So, no need to load from cache
            let hotel = HotelDao.sharedManager.getPromotionHotel()
            if hotel.status == Status.SUCCESS {
                hotel.status = Status.LOADING
                self.promotionHotelListLiveData.value = hotel
                print("Return Promotion Data")
            }
        }
        
        // Load From Server
        if isLoadFromServer! {
            if Connectivity.isConnected() {
                
                Alamofire.request(APIRouters.GetPromotionHotelList(apiKey, loginUserId, limit, offset)).responseJSON{
                    response in
                    
                    let result = self.parseJson(response: response, dataType: [Hotel].self)
                    
                    if offset <= 0 { // delete all search
                        HotelDao.sharedManager.deletePromotionHotel()
                    }
                    
                    if result.status == Status.SUCCESS {
                        let promotionHotelList = HotelDao.sharedManager.convertToPromotionHotel(result.data!)
                        
                        HotelDao.sharedManager.save(result.data!)
                        HotelDao.sharedManager.save(promotionHotelList)
                    }
                    
                    let rData : Resourse<[Hotel]> = HotelDao.sharedManager.getPromotionHotel()
                    rData.status = result.status
                    rData.message = result.message
                    self.promotionHotelListLiveData.value = rData
                    
                }
            }else {
                let noAction = Resourse<[Hotel]>()
                noAction.status = Status.NO_ACTION
                self.promotionHotelListLiveData.value = noAction
            }
        }
    }
    
    
    //************************************************************
    //MARK: Get Popular Hotels
    //************************************************************
    var popularHotelListLiveData : LiveData<Resourse<[Hotel]>?> = LiveData(Resourse<[Hotel]>())
    
    func getPopularHotelList(apiKey: String,
                               loginUserId : String,
                               limit: Int,
                               offset: Int,
                               isLoadFromServer : Bool? = true) {
        
        if (offset <= 0) {
            // Load From Local
            // Only for offset is 0
            // If offset is not 0, it is loading for next page,
            // So, no need to load from cache
            let hotel = HotelDao.sharedManager.getPopularHotel()
            if hotel.status == Status.SUCCESS {
                hotel.status = Status.LOADING
                self.popularHotelListLiveData.value = hotel
                
            }
        }
        
        // Load From Server
        if isLoadFromServer! {
            if Connectivity.isConnected() {
                
                Alamofire.request(APIRouters.GetPopularHotelList(apiKey, loginUserId, limit, offset)).responseJSON{
                    response in
                    
                    let result = self.parseJson(response: response, dataType: [Hotel].self)
                    
                    if offset <= 0 { // delete all search
                        HotelDao.sharedManager.deletePopularHotel()
                    }
                    
                    if result.status == Status.SUCCESS {
                        let popularHotelList = HotelDao.sharedManager.convertToPopularHotel(result.data!)
                        
                        HotelDao.sharedManager.save(result.data!)
                        HotelDao.sharedManager.save(popularHotelList)
                    }
                    
                    let rData : Resourse<[Hotel]> = HotelDao.sharedManager.getPopularHotel()
                    rData.status = result.status
                    rData.message = result.message
                    self.popularHotelListLiveData.value = rData
                    
                }
            }else {
                let noAction = Resourse<[Hotel]>()
                noAction.status = Status.NO_ACTION
                self.popularHotelListLiveData.value = noAction
            }
        }
    }
    
    //************************************************************
    //MARK: Get Favourite Hotels
    //************************************************************
    var favouriteHotelListLiveData : LiveData<Resourse<[Hotel]>?> = LiveData(Resourse<[Hotel]>())
    
    func getFavouriteHotelList(apiKey: String,
                             loginUserId : String,
                             limit: Int,
                             offset: Int,
                             isLoadFromServer : Bool? = true) {
        
        if (offset <= 0) {
            // Load From Local
            // Only for offset is 0
            // If offset is not 0, it is loading for next page,
            // So, no need to load from cache
            let hotel = HotelDao.sharedManager.getFavouriteHotel()
            if hotel.status == Status.SUCCESS || hotel.status == Status.NO_ACTION {
                hotel.status = Status.LOADING
                self.favouriteHotelListLiveData.value = hotel
            }
            
        }
        
        // Load From Server
        if isLoadFromServer! {
            if Connectivity.isConnected() {
                
                Alamofire.request(APIRouters.GetFavouriteHotelList(apiKey, loginUserId, limit, offset)).responseJSON{
                    response in
                    
                    let result = self.parseJson(response: response, dataType: [Hotel].self)
                    
                    if offset <= 0 { // delete all Fav
                        HotelDao.sharedManager.deleteFavouriteHotel()
                    }
                    
                    if result.status == Status.SUCCESS {
                        let popularHotelList = HotelDao.sharedManager.convertToFavouriteHotel(result.data!)
                        
                        HotelDao.sharedManager.save(result.data!)
                        HotelDao.sharedManager.save(popularHotelList)
                    }
                    
                    let rData : Resourse<[Hotel]> = HotelDao.sharedManager.getFavouriteHotel()
                    rData.status = result.status
                    rData.message = result.message
                    self.favouriteHotelListLiveData.value = rData
                    
                }
            }else {
                let noAction = Resourse<[Hotel]>()
                noAction.status = Status.NO_ACTION
                self.favouriteHotelListLiveData.value = noAction
            }
        }
    }
    
    //************************************************************
    //MARK: Post Search Hotel
    //************************************************************
    var postSearchHotelLiveData : LiveData<Resourse<[Hotel]>?> = LiveData(Resourse<[Hotel]>())
    
    func postSearchHotel(apiKey: String,
                         loginUserId : String,
                         limit : Int,
                         offset : Int,
                         cityId: String,
                         hotelName : String,
                         starRating : String,
                         lowerPrice : String,
                         upperPrice : String,
                         infoType : String,
                         guestRating: String,
                         isLoadFromServer : Bool = true) {
        
        if isLoadFromServer {
            if Connectivity.isConnected() {
               
                
                let param: [String: AnyObject] = [ "city_id" : cityId as AnyObject,
                                                   "hotel_name" : hotelName as AnyObject,
                                                   "hotel_star_rating" : starRating as AnyObject,
                                                   "hotel_min_price" : lowerPrice as AnyObject,
                                                   "hotel_max_price" : upperPrice as AnyObject,
                                                   "filter_by_info_type" : infoType as AnyObject,
                                                   "min_user_rating" : guestRating as AnyObject
                                                ]
                
                Alamofire.request(APIRouters.PostSearchHotel(apiKey, loginUserId, limit, offset, param)).responseJSON{
                    response in
                    
                    let result = self.parseJson(response: response, dataType: [Hotel].self)
                    
                    if offset <= 0 { // delete all search
                        HotelDao.sharedManager.deleteSearchHotel()
                    }
                    
                    if result.status == Status.SUCCESS {
                        let searchHotelList = HotelDao.sharedManager.convertToSearchHotel(result.data!)
                        
                        HotelDao.sharedManager.save(result.data!)
                        HotelDao.sharedManager.save(searchHotelList)
                    }
     
                    let rData : Resourse<[Hotel]> = HotelDao.sharedManager.getSearchHotel()
                    rData.status = result.status
                    rData.message = result.message
                    self.postSearchHotelLiveData.value = rData
                    
                }
            }
        }else {
            let rData : Resourse<[Hotel]> = HotelDao.sharedManager.getSearchHotel()
            self.postSearchHotelLiveData.value = rData
        }
    }
    
    
    //************************************************************
    //MARK: Do Favourite Hotels
    //************************************************************
    var doFavHotelLiveData : LiveData<Resourse<Hotel>?> = LiveData(Resourse<Hotel>())
    
    func postFavHotel(apiKey: String,
                     hotelId: String,
                     loginUserId: String) {
        
        if Connectivity.isConnected() {
            let hotel = HotelDao.sharedManager.getHotelById(hotelId)
            
            if hotel.status == Status.SUCCESS {
                if hotel.data?.is_user_favourited == "true" {
                    hotel.data?.is_user_favourited = "false"
                }else {
                    hotel.data?.is_user_favourited = "true"
                }
                hotel.status = Status.LOADING
                self.doFavHotelLiveData.value = hotel
            }
            
            let param: [String: AnyObject] = ["hotel_id": hotelId as AnyObject,
                                              "login_user_id": loginUserId as AnyObject]
            
            Alamofire.request(APIRouters.PostFavHotel(apiKey, param)).responseJSON{
                response in
                let result = self.parseJson(response: response, dataType: Hotel.self)
                
                if result.status == Status.SUCCESS {
                    HotelDao.sharedManager.save(result.data!)
                    
                    if let data : Hotel = result.data {
                        if data.is_user_favourited == "false" {
                            HotelDao.sharedManager.deleteFavouriteHotelById(data.hotel_id)
                        }
                    }
                }
                
                
                
                self.doFavHotelLiveData.value = result
            }
        }
    }
 
    
    
    //************************************************************
    //MARK: Hotel Touch Count
    //************************************************************
    var postHotelTouchCountLiveData : LiveData<Resourse<ApiStatus>?> = LiveData(Resourse<ApiStatus>())
    
    func postHotelTouchCount(apiKey: String,
                            hotelId: String,
                            loginUserId: String) {
        
        if Connectivity.isConnected() {
            
            let param: [String: AnyObject] = ["hotel_id": hotelId as AnyObject,
                                              "login_user_id": loginUserId as AnyObject]
            
            Alamofire.request(APIRouters.PostHotelTouchCount(apiKey, param)).responseJSON{
                response in
                let result = self.parseJson(response: response, dataType: ApiStatus.self)
                
                self.postHotelTouchCountLiveData.value = result
            }
        }
    }
    
}
