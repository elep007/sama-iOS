//
//  RoomFeatureViewModel.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/14/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class RoomFeatureViewModel : PSViewModel{
    
    //MARK: Variables for controllers
    var isLoading : LiveData<Bool> = LiveData(Bool())
    var cellId : String = ""
    var headerCellId: String = ""
    
    // Room Features List By room Id
    var roomFeatureListByRoomIdLiveData : LiveData<Resourse<[RoomFeature]>?> = LiveData(Resourse<[RoomFeature]>())
    
    // Room Features List By hotel Id
    var roomFeatureListByHotelIdLiveData : LiveData<Resourse<[RoomFeature]>?> = LiveData(Resourse<[RoomFeature]>())
    
    //MARK: Private Variables
    private let roomFeatureRepository : RoomFeatureRepository
    
    
    //MARK: Override Methods
    override init() {
        
        roomFeatureRepository = RoomFeatureRepository()
        isLoading.value = false
        
        super.init()
        
        // Room Features By Room Id
        roomFeatureRepository.roomFeatureListByRoomIdLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                if resourse.status != Status.NO_ACTION {
                    self?.roomFeatureListByRoomIdLiveData.value = resourse
                    
                }
                
            }
            
        }
        
        
        // Room Features By Hotel Id
        roomFeatureRepository.roomFeatureListByHotelIdLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                if resourse.status != Status.NO_ACTION {
                    self?.roomFeatureListByHotelIdLiveData.value = resourse
                    
                }
                
            }
            
        }
    }
    
    //MARK: Custom Methods
   
    func getRoomFeatures(roomId: String) {
        
        if !isLoading.value {
            isLoading.value = true
            roomFeatureRepository.getRoomFeatureListByRoomId(apiKey: configs.apiKey, roomId: roomId)
            
        }
    }
    
    func getRoomFeatures(hotelId: String) {
        
        if !isLoading.value {
            isLoading.value = true
            roomFeatureRepository.getRoomFeatureListByHotelId(apiKey: configs.apiKey, hotelId: hotelId)
            
        }
    }
}
