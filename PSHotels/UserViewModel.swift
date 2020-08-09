//
//  UserViewModel.swift
//  PSHotels
//
//  Created by Panacea-Soft on 1/17/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation

class UserViewModel : PSViewModel{
    
    //MARK: Variables for controller
    var isLoading : LiveData<Bool> = LiveData(Bool())
    
    //User Login
    var postUserLoginLiveData : LiveData<Resourse<User>?> = LiveData(Resourse<User>())
    
    // User Data By User ID
    var userLiveData : LiveData<Resourse<User>?> = LiveData(Resourse<User>())
    
    // Forgot Password
    var postForgotPasswordLiveData : LiveData<Resourse<ApiStatus>?> = LiveData(Resourse<ApiStatus>())
    
    // Register User
    var postRegisterUserLiveData : LiveData<Resourse<User>?> = LiveData(Resourse<User>())
    
    // Upload user profile photo
    var uploadUserProfileLiveData : LiveData<Resourse<User>?> = LiveData(Resourse<User>())
    
    // Do Update User
    var updateUserLiveData : LiveData<Resourse<User>?> = LiveData(Resourse<User>())
    
    // Do Update Password
    var updatePasswordLiveData : LiveData<Resourse<ApiStatus>?> = LiveData(Resourse<ApiStatus>())
    
    //MARK: Private Variables
    private let userRepository : UserRepository
    
    //MARK: Override Methods
    override init() {
        
        userRepository = UserRepository()
        isLoading.value = false
         
        super.init()
        
        // User Login
        userRepository.postUserLoginLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                if resourse.status != Status.NO_ACTION {
                    self?.postUserLoginLiveData.value = resourse
                }
                
            }
                
        }
        
        // News By ID
        userRepository.userLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                self?.userLiveData.value = resourse
                
            }
            
        }
        
        
        
        // Forgot Password
        userRepository.postForgotPasswordLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                self?.postForgotPasswordLiveData.value = resourse
                
            }
            
        }
        
        // Register User
        userRepository.postRegisterUserLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                self?.postRegisterUserLiveData.value = resourse
                
            }
            
        }
        
        // Upload Profile photo
        userRepository.uploadProfileLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                self?.uploadUserProfileLiveData.value = resourse
                
            }
            
        }
        
        // Update User
        userRepository.updateUserLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                self?.updateUserLiveData.value = resourse
                
            }
            
        }
        
        // Forgot Password
        userRepository.updateUserPasswordLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                self?.updatePasswordLiveData.value = resourse
                
            }
            
        }
        
    }
    
    
    //MARK: Custom Methods
    func postUserLogin(email: String, password : String) {
        
        if !isLoading.value {
            isLoading.value = true
            userRepository.postUserLogin(apiKey: configs.apiKey, email: email, password: password)
        }
        
        
    }
    
    func getUserById(userId: String) {
        
        if !isLoading.value {
            isLoading.value = true
            userRepository.getUserById(apiKey: configs.apiKey, userId: userId)
        }
        
    }
    
    func postForgotPassword(email: String) {
        
        if !isLoading.value {
            isLoading.value = true
            userRepository.postForgotPassword(apiKey: configs.apiKey, email: email)
        }
        
    }
    
    func postRegisterUser(userName: String, email: String, password: String) {
        
        if !isLoading.value {
            isLoading.value = true
            userRepository.postRegisterUser(apiKey: configs.apiKey, userName: userName, email: email, password: password)
        }
        
    }
    
    func uploadProfilePhoto(userId: String, image: UIImage) {
        
        var resizedImage = image
        print("image width and height \(String(describing: resizedImage.size.width)) \(String(describing: resizedImage.size.height))")
        
        let size:CGSize = Common.instance.getImageSize(resizedImage.size)
        resizedImage = Common.instance.scaleUIImageToSize(resizedImage, size: size)
        print("Converted size : \(String(describing: resizedImage.size.width)) \(String(describing: resizedImage.size.height))")
        
        
        if !isLoading.value {
            isLoading.value = true
            userRepository.uploadProfilePhoto(apiKey: configs.apiKey, userId: userId, platform: "ios", image: resizedImage)
        }
        
    }
    
    func updateUser(userId: String, userName: String, email: String, phone: String, aboutMe: String) {
        
        if !isLoading.value {
            isLoading.value = true
            userRepository.updateUser(apiKey: configs.apiKey, userId: userId, userName: userName, email: email, phone: phone, aboutme: aboutMe)
        }
        
    }
    
    func updatePassword(loginUserId: String, password: String) {
        
        if !isLoading.value {
            isLoading.value = true
            userRepository.updateUserPassword(apiKey: configs.apiKey, loginUserId: loginUserId, userPassword: password)
        }
        
    }

}
