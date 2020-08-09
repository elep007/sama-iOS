//
//  RoomViewModel.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/7/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class RoomViewModel : PSViewModel{

    //MARK: Variables for controllers
    var isLoading : LiveData<Bool> = LiveData(Bool())
    var cellId : String = ""
    var headerCellId : String = ""
    var isFilter : Bool = false
    var filterRoomList : [Room] = [Room]()
    
    // Room List By Hotel Id
    var roomListByHotelIdLiveData : LiveData<Resourse<[Room]>?> = LiveData(Resourse<[Room]>())
    
    // Room By Id
    var roomByRoomIdLiveData : LiveData<Resourse<Room>?> = LiveData(Resourse<Room>())
    
    // Do Post Room Touch Count
    var postRoomTouchCountLiveData : LiveData<Resourse<ApiStatus>?> = LiveData(Resourse<ApiStatus>())
    
    
    //MARK: Private Variables
    private let roomRepository : RoomRepository
    
    
    //MARK: Override Methods
    override init() {
        
        roomRepository = RoomRepository()
        isLoading.value = false
        
        super.init()
        
        // Room List By Hotel Id
        roomRepository.roomListByHotelIdLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                if resourse.status != Status.NO_ACTION {
                    self?.roomListByHotelIdLiveData.value = resourse
                    
                }
                
            }
            
        }
        
        // Hotel By ID
        roomRepository.roomByRoomIdLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                if resourse.status != Status.NO_ACTION {
                    self?.roomByRoomIdLiveData.value = resourse
                }
                
            }
            
        }
        
        // Do Post Room Touch Count
        roomRepository.postRoomTouchCountLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                
                if resourse.status != Status.NO_ACTION {
                    self?.postRoomTouchCountLiveData.value = resourse
                }
                
            }
            
        }
        
        
    }
    
    //MARK: Custom Methods
    func getRoomListByHotelId(hotelId: String) {
        
        if !isLoading.value {
            isLoading.value = true
            roomRepository.getRoomListByHotelId(apiKey: configs.apiKey, hotelId: hotelId)
            
        }
    }
    
    func filterCity(_ filterStr: String){
        
        if let cities : [Room] = roomListByHotelIdLiveData.value?.data {
            filterRoomList = cities.filter{$0.room_name.localizedStandardContains(filterStr)}
            
        }
    }
    
    func getRoomById(loginUserId: String, roomId: String) {
        
        if !isLoading.value {
            isLoading.value = true
            roomRepository.getRoomByRoomId(apiKey: configs.apiKey, roomId: roomId, loginUserId: loginUserId)
        }
        
    }
    
    func doPostRoomTouchCount(roomId: String, loginUserId: String) {
        
        roomRepository.postRoomTouchCount(apiKey: configs.apiKey, roomId: roomId, loginUserId: loginUserId)
        
    }
    
}
