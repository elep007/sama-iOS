//
//  UserRepository.swift
//  PSHotels
//
//  Created by Panacea-Soft on 1/17/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation
import Alamofire

class UserRepository : PSRepository<Any> {
    
    //************************************************************
    //MARK: User By User ID
    //**********************var***********************************
    var userLiveData: LiveData<Resourse<User>?> = LiveData(Resourse<User>())
    
    func getUserById(apiKey: String,
                         userId: String) {
        
        let user = UserDao.sharedManager.getUserById(userId)
        if user.status == Status.SUCCESS {
            user.status = Status.LOADING
            self.userLiveData.value = user
        }
        
        if Connectivity.isConnected() {
            Alamofire.request(APIRouters.GetUser(apiKey, userId)).responseJSON{
                response in
                let result = self.parseJson(response: response, dataType: [User].self)
                
                if result.status == Status.SUCCESS {
                    UserDao.sharedManager.saveAll(result.data!)
                }
                
                self.userLiveData.value = UserDao.sharedManager.getUserById(userId)
            }
        }else {
            let noAction = Resourse<User>()
            noAction.status = Status.NO_ACTION
            self.userLiveData.value = noAction
        }
    }
    
    //************************************************************
    //MARK: Forgot Password
    //************************************************************
    var postForgotPasswordLiveData : LiveData<Resourse<ApiStatus>?> = LiveData(Resourse<ApiStatus>())
    
    func postForgotPassword(apiKey: String,
                     email: String) {
        
        let param: [String: AnyObject] = ["user_email": email as AnyObject]
        
        if Connectivity.isConnected() {
            Alamofire.request(APIRouters.PostForgotPassword(apiKey, param)).responseJSON{
                response in
                let result = self.parseJson(response: response, dataType: ApiStatus.self)
                
                self.postForgotPasswordLiveData.value = result
            }
        }
    }
    
    //************************************************************
    //MARK: Register New User
    //************************************************************
    var postRegisterUserLiveData : LiveData<Resourse<User>?> = LiveData(Resourse<User>())
    
    func postRegisterUser(apiKey: String,
                            userName: String,
                            email: String,
                            password: String) {
        
        let param: [String: AnyObject] = ["user_name": userName as AnyObject,
                                          "user_email": email as AnyObject,
                                          "user_password": password as AnyObject]
        
        if Connectivity.isConnected() {
            Alamofire.request(APIRouters.PostUser(apiKey, param)).responseJSON{
                response in
                let result = self.parseJson(response: response, dataType: User.self)
                
                if result.status == Status.SUCCESS {
                    UserDao.sharedManager.save(result.data!)
                }
                
                self.postRegisterUserLiveData.value = result
            }
        }
    }
    
    //************************************************************
    //MARK: Password Update
    //************************************************************
    var updateUserPasswordLiveData : LiveData<Resourse<ApiStatus>?> = LiveData(Resourse<ApiStatus>())
    
    func updateUserPassword(apiKey: String,
                          loginUserId: String,
                          userPassword: String) {
        
        let param: [String: AnyObject] = ["login_user_id": loginUserId as AnyObject,
                                          "user_password": userPassword as AnyObject]
        
        if Connectivity.isConnected() {
            Alamofire.request(APIRouters.PutPassword(apiKey, param)).responseJSON{
                response in
                
                let result = self.parseJson(response: response, dataType: ApiStatus.self)
                
                self.updateUserPasswordLiveData.value = result
                
            }
        }
    }
    
    //************************************************************
    //MARK: Upload User Profile Photo
    //************************************************************
    var uploadProfileLiveData : LiveData<Resourse<User>?> = LiveData(Resourse<User>())
    
    func uploadProfilePhoto(apiKey: String,
                          userId: String,
                          platform: String,
                          image: UIImage) {
        
        
        if Connectivity.isConnected() {
            UploadImage(url: "\(APIRouters.doUploadImage)\(apiKey)" ,userId : userId, platform: platform, image: image) { (result) in
            
                if result.status == Status.SUCCESS {
                    UserDao.sharedManager.save(result.data!)
                }
                
                self.uploadProfileLiveData.value = result
            }
        }
       
    }
    
    
    //************************************************************
    //MARK: Update User
    //************************************************************
    var updateUserLiveData : LiveData<Resourse<User>?> = LiveData(Resourse<User>())
    
    func updateUser(apiKey: String,
                    userId: String,
                    userName: String,
                    email: String,
                    phone: String,
                    aboutme: String) {
        
        if Connectivity.isConnected() {
            let userData = UserDao.sharedManager.getUserById(userId)
            
            if let _ = userData.data {
                userData.data?.user_name = userName
                userData.data?.user_email = email
                userData.data?.user_phone = phone
                userData.data?.user_about_me = aboutme
                
                let param: [String: AnyObject] = ["login_user_id": userId as AnyObject,
                                                    "user_name": userName as AnyObject,
                                                    "user_email": email as AnyObject,
                                                    "user_phone": phone as AnyObject,
                                                    "user_about_me": aboutme as AnyObject]
                
                Alamofire.request(APIRouters.PutUser(apiKey, param)).responseJSON{
                    response in
                    let result = self.parseJson(response: response, dataType: ApiStatus.self)
                    
                    if result.status == Status.SUCCESS {
                        
                        UserDao.sharedManager.save(userData.data!)
                    }
                    
                    self.updateUserLiveData.value = userData
                }
            }else {
                let userData = Resourse<User>()
                userData.status = Status.ERROR
                userData.message = language.error_message__no_user_in_local
                
            }
        }
    }
    
    //************************************************************
    //MARK: User Login
    //************************************************************
    var postUserLoginLiveData : LiveData<Resourse<User>?> = LiveData(Resourse<User>())
    
    func postUserLogin(apiKey: String, email: String, password: String) {
        
        let param: [String: AnyObject] = ["user_email": email as AnyObject,
                                          "user_password": password as AnyObject]
        
        if Connectivity.isConnected() {
            Alamofire.request(APIRouters.PostUserLogin(apiKey, param)).responseJSON {
                response in
                
                let result = self.parseJson(response: response, dataType: User.self)
                
                self.postUserLoginLiveData.value = result
            }
        }
       
    }
        
}










