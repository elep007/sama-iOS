//
//  RoomFeatureDao.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/14/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class RoomFeatureDao {
    
    // Singleton
    class var sharedManager: RoomFeatureDao {
        struct Static {
            static let instance = RoomFeatureDao()
        }
        return Static.instance
    }
    
    // Core RoomFeature
    private let roomFeatureFile = "RoomFeature.json"
    private var roomFeatureList  = Resourse<[RoomFeature]>()
    
    // init
    init() {
        
        // Init Core
        if let roomFeatureListFromFile : [RoomFeature] = Storage.retrieve(roomFeatureFile, from: .documents, as: [RoomFeature].self) {
            roomFeatureList = Resourse<[RoomFeature]>(status: Status.SUCCESS, message: "", data: roomFeatureListFromFile)
        }
        
    }
    
    
    //***************************************************************
    //MARK: Core RoomFeature
    //***************************************************************
    
    // Save and Replace
    func save(_ roomFeature : RoomFeature) {
        
        if let data = self.roomFeatureList.data {
            let index = data.firstIndex{$0 == roomFeature}
            
            if let i = index {
                self.roomFeatureList.data?[i] = roomFeature
            }else {
                self.roomFeatureList.data?.append(roomFeature)
            }
            
        }else {
            self.roomFeatureList.status = Status.SUCCESS
            self.roomFeatureList.data = [roomFeature]
        }
        
        Storage.store(roomFeatureList.data!, to: .documents, as: roomFeatureFile)
    }
    
    // Save and Replace All
    func save(_ roomFeatureList : [RoomFeature]) {
        for roomFeature in roomFeatureList {
            save(roomFeature)
        }
    }
    
    // delete by parent id
    func deleteRoomFeatureByParentId(_ parent_id: String) {
        if let data = roomFeatureList.data {
            let result = data.filter{$0.rinfo_parent_id != parent_id}
            roomFeatureList.data = result
            Storage.store(roomFeatureList.data!, to: .documents, as: roomFeatureFile)
        }
    }
    
    // get roomFeature by parent id
    func getRoomFeatureById(_ hinfo_parent_id: String)  -> Resourse<[RoomFeature]> {
        
        let roomFeatureHolder : Resourse<[RoomFeature]> = Resourse<[RoomFeature]>()
        
        if let data = roomFeatureList.data {
            let roomFilter = data.filter{$0.rinfo_parent_id == hinfo_parent_id}
            if roomFilter.count > 0 {
                roomFeatureHolder.data = roomFilter
                roomFeatureHolder.status = Status.SUCCESS
            }
            
        }
        
        return roomFeatureHolder
    }
    
    //***************************************************************
    // End Core RoomFeature
    //***************************************************************
    
}
