//
//  RoomDao.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/28/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class RoomDao {
    
    // Singleton
    class var sharedManager: RoomDao {
        struct Static {
            static let instance = RoomDao()
        }
        return Static.instance
    }
    
    // Core Room
    private let roomFile = "roomFile.json"
    private var roomList  = Resourse<[Room]>()
    
    // init
    init() {
        
        // Init Core
        if let roomListFromFile : [Room] = Storage.retrieve(roomFile, from: .documents, as: [Room].self) {
            roomList = Resourse<[Room]>(status: Status.SUCCESS, message: "", data: roomListFromFile)
        }
        
        
    }
    
    //***************************************************************
    //MARK: Core Room
    //***************************************************************
    
    // Save and Replace
    func save(_ room : Room) {
        
        if let data = self.roomList.data {
            let index = data.firstIndex{$0 == room}
            // print("\(String(describing: index))")
            
            if let i = index {
                self.roomList.data?[i] = room
            }else {
                self.roomList.data?.append(room)
            }
            
        }else {
            self.roomList.status = Status.SUCCESS
            self.roomList.data = [room]
        }
        
        Storage.store(roomList.data!, to: .documents, as: roomFile)
    }
    
    // Save and Replace All
    func save(_ roomList : [Room]) {
        for room in roomList {
            save(room)
        }
    }
    
    // delete by hotelId
    func deleteRoomByHotelId(_ hotelId: String) {
        if let data = roomList.data {
            let result = data.filter{$0.hotel_id != hotelId}
            roomList.data = result
            Storage.store(roomList.data!, to: .documents, as: roomFile)
        }
    }
    
    // get room by hotel id
    func getRoomByHotelId(_ hotelId: String)  -> Resourse<[Room]> {
        
        let roomHolder : Resourse<[Room]> = Resourse<[Room]>()
        
        if let data = roomList.data {
            let roomFilter = data.filter{$0.hotel_id == hotelId}
            if roomFilter.count > 0 {
                roomHolder.data = roomFilter
                roomHolder.status = Status.SUCCESS
            }
            
        }
        
        return roomHolder
    }
    
    // get room by roomid
    func getRoomById(_ roomId: String)  -> Resourse<Room> {
        
        let roomHolder : Resourse<Room> = Resourse<Room>()
        
        if let data = roomList.data {
            let roomFilter = data.filter{$0.room_id == roomId}
            if roomFilter.count > 0 {
                roomHolder.data = roomFilter[0]
                roomHolder.status = Status.SUCCESS
            }
            
        }
        
        return roomHolder
    }

    //***************************************************************
    // End Core Room
    //***************************************************************



}
