//
//  RoomFeatureRepository.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/14/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
import Alamofire

class RoomFeatureRepository : PSRepository<Any> {


    //************************************************************
    //MARK: Get Room Features By Room Id
    //************************************************************
    var roomFeatureListByRoomIdLiveData : LiveData<Resourse<[RoomFeature]>?> = LiveData(Resourse<[RoomFeature]>())
    
    func getRoomFeatureListByRoomId(apiKey: String, roomId: String) {
        
        
        let roomFeature = RoomFeatureDao.sharedManager.getRoomFeatureById(roomId)
        if roomFeature.status == Status.SUCCESS {
            roomFeature.status = Status.LOADING
            self.roomFeatureListByRoomIdLiveData.value = roomFeature
        }
        
        
        if Connectivity.isConnected() {
            Alamofire.request(APIRouters.GetRoomFeaturesByRoomId(apiKey, roomId)).responseJSON{
                response in
                let result = self.parseJson(response: response, dataType: [RoomFeature].self)
                
                if result.status == Status.SUCCESS {
                    RoomFeatureDao.sharedManager.deleteRoomFeatureByParentId(roomId)
                    
                    RoomFeatureDao.sharedManager.save(result.data!)
                    
                }
                self.roomFeatureListByRoomIdLiveData.value = RoomFeatureDao.sharedManager.getRoomFeatureById(roomId)
                
            }
        }else {
            let noAction = Resourse<[RoomFeature]>()
            noAction.status = Status.NO_ACTION
            self.roomFeatureListByRoomIdLiveData.value = noAction
        }
    }
    
    //************************************************************
    //MARK: Get Room Features By Hotel Id
    //************************************************************
    var roomFeatureListByHotelIdLiveData : LiveData<Resourse<[RoomFeature]>?> = LiveData(Resourse<[RoomFeature]>())
    
    func getRoomFeatureListByHotelId(apiKey: String, hotelId: String) {
        
        
        let hotelFeature = RoomFeatureDao.sharedManager.getRoomFeatureById(hotelId)
        if hotelFeature.status == Status.SUCCESS {
            hotelFeature.status = Status.LOADING
            self.roomFeatureListByHotelIdLiveData.value = hotelFeature
        }
        
        
        if Connectivity.isConnected() {
            Alamofire.request(APIRouters.GetRoomFeaturesByHotelId(apiKey, hotelId)).responseJSON{
                response in
                let result = self.parseJson(response: response, dataType: [RoomFeature].self)
                
                if result.status == Status.SUCCESS {
                    RoomFeatureDao.sharedManager.deleteRoomFeatureByParentId(hotelId)
                    
                    RoomFeatureDao.sharedManager.save(result.data!)
                    
                }
                self.roomFeatureListByHotelIdLiveData.value = RoomFeatureDao.sharedManager.getRoomFeatureById(hotelId)
                
            }
        }else {
            let noAction = Resourse<[RoomFeature]>()
            noAction.status = Status.NO_ACTION
            self.roomFeatureListByHotelIdLiveData.value = noAction
        }
    }
    
    
}
