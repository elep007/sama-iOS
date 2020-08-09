//
//  RoomRepository.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/7/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
import Alamofire

class RoomRepository : PSRepository<Any> {
    
    //************************************************************
    //MARK: Get Room List By Hotel Id
    //************************************************************
    var roomListByHotelIdLiveData : LiveData<Resourse<[Room]>?> = LiveData(Resourse<[Room]>())
    
    func getRoomListByHotelId(apiKey: String, hotelId: String) {
        
        
        let roomList = RoomDao.sharedManager.getRoomByHotelId(hotelId)
        if roomList.status == Status.SUCCESS {
            roomList.status = Status.LOADING
            self.roomListByHotelIdLiveData.value = roomList
        }
        
        
        if Connectivity.isConnected() {
            Alamofire.request(APIRouters.GetRoomListByHotelId(apiKey, hotelId)).responseJSON{
                response in
                let result = self.parseJson(response: response, dataType: [Room].self)
                
                if result.status == Status.SUCCESS {
                    RoomDao.sharedManager.deleteRoomByHotelId(hotelId)
                    
                    RoomDao.sharedManager.save(result.data!)
                    
                }
                self.roomListByHotelIdLiveData.value = RoomDao.sharedManager.getRoomByHotelId(hotelId)
                
            }
        }else {
            let noAction = Resourse<[Room]>()
            noAction.status = Status.NO_ACTION
            self.roomListByHotelIdLiveData.value = noAction
        }
    }
    
    
    //************************************************************
    //MARK: Room By room_id
    //************************************************************
    var roomByRoomIdLiveData : LiveData<Resourse<Room>?> = LiveData(Resourse<Room>())
    
    func getRoomByRoomId(apiKey: String,
                           roomId: String,
                           loginUserId: String) {
        
        let room = RoomDao.sharedManager.getRoomById(roomId)
        if room.status == Status.SUCCESS {
            room.status = Status.LOADING
            self.roomByRoomIdLiveData.value = room
        }
        
        if Connectivity.isConnected() {
            Alamofire.request(APIRouters.GetRoomByRoomId(apiKey,
                                                            loginUserId,
                                                            roomId)).responseJSON{
                                                                response in
                            let result = self.parseJson(response: response, dataType: [Room].self)
                            
                            
                            if result.status == Status.SUCCESS {
                                RoomDao.sharedManager.save(result.data!)
                            }
                            
                            self.roomByRoomIdLiveData.value = RoomDao.sharedManager.getRoomById(roomId)
            }
        }else {
            let noAction = Resourse<Room>()
            noAction.status = Status.NO_ACTION
            self.roomByRoomIdLiveData.value = noAction
        }
    }
    
    //************************************************************
    //MARK: Room Touch Count
    //************************************************************
    var postRoomTouchCountLiveData : LiveData<Resourse<ApiStatus>?> = LiveData(Resourse<ApiStatus>())
    
    func postRoomTouchCount(apiKey: String,
                        roomId: String,
                        loginUserId: String) {
        
        if Connectivity.isConnected() {
            
            let param: [String: AnyObject] = ["room_id": roomId as AnyObject,
                                              "login_user_id": loginUserId as AnyObject]
            
            Alamofire.request(APIRouters.PostRoomTouchCount(apiKey, param)).responseJSON{
                response in
                let result = self.parseJson(response: response, dataType: ApiStatus.self)
                
                self.postRoomTouchCountLiveData.value = result
            }
        }
    }
    
}
