//
//  UserDao.swift
//  PSUser
//
//  Created by Panacea-Soft on 2/7/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation

class UserDao {
    
    // Singleton
    class var sharedManager: UserDao {
        struct Static {
            static let instance = UserDao()
        }
        return Static.instance
    }
    
    // Core User
    private let userFile = "userFile.json"
    private var userList  = Resourse<[User]>()
    
    // init
    init() {
        
        // Init
        if let userListFromFile : [User] = Storage.retrieve(userFile, from: .documents, as: [User].self) {
            userList = Resourse<[User]>(status: Status.SUCCESS, message: "", data: userListFromFile)
        }
    }
    
    
    //***************************************************************
    //MARK: Core User
    //***************************************************************
    
    // Save and Replace
    func save(_ user : User) {
        
        if let data = self.userList.data {
            let index = data.firstIndex{$0 == user}
            // print("\(String(describing: index))")
            
            if let i = index {
                self.userList.data?[i] = user
            }else {
                self.userList.data?.append(user)
            }
            
        }else {
            self.userList.status = Status.SUCCESS
            self.userList.data = [user]
        }
        
        Storage.store(userList.data!, to: .documents, as: userFile)
    }
    
    // Save and Replace All
    func saveAll(_ userList : [User]) {
        if let _ = self.userList.data {
            for user in userList {
                
                if let data = self.userList.data {
                    let index = data.firstIndex{$0 == user}
                    // print("\(String(describing: index))")
                    
                    if let i = index {
                        self.userList.data?[i] = user
                    }else {
                        self.userList.data?.append(user)
                    }
                    
                }else {
                    self.userList.data?.append(user)
                }
            }
        }else {
            self.userList.status = Status.SUCCESS
            self.userList.data = userList
        }
        
        
        Storage.store(self.userList.data!, to: .documents, as: userFile)
    }
    
    // get User by User ID
    func getUserById(_ userId: String)  -> Resourse<User> {
        
        let userHolder : Resourse<User> = Resourse<User>()
        
        if let data = userList.data {
            let userFilter = data.filter{$0.user_id == userId}
            if userFilter.count > 0 {
                userHolder.data = userFilter[0]
                userHolder.status = Status.SUCCESS
            }
            
        }
        
        return userHolder
    }
    
    func deleteAllUser() {
        
        let userHolder : Resourse<[User]> = Resourse<[User]>()
        Storage.store(userHolder.data!, to: .documents, as: userFile)
        self.userList = userHolder
        
    }
    
}
