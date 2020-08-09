//
//  BookingViewModel.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 5/3/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class BookingViewModel : PSViewModel{
    
    //MARK: Variables for controller
    var isLoading : LiveData<Bool> = LiveData(Bool())
    var cellId : String = ""
    
    // post Booking
    var postBookingLiveData : LiveData<Resourse<Booking>?> = LiveData(Resourse<Booking>())
    
    // get booking list
    var bookingListLiveData : LiveData<Resourse<[Booking]>?> = LiveData(Resourse<[Booking]>())
    var bookingListOffset = 0
    
    //MARK: Private Variables
    private let bookingRepository : BookingRepository
    
    //MARK: Override Methods
    override init() {
        bookingRepository = BookingRepository()
        isLoading.value = false
        
        super.init()
        
        // Post Booking
        bookingRepository.postBookingLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                self?.postBookingLiveData.value = resourse
                
            }
            
        }
        
        // Booking List
        bookingRepository.bookingListLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                if resourse.status != Status.NO_ACTION{
                    self?.bookingListLiveData.value = resourse
                    if let data = resourse.data {
                        self?.bookingListOffset = data.count
                    }
                }
            }
            
        }
    }
    
    func postBooking(
        loginUserId: String,
        userName: String,
        userEmail: String,
        userPhone : String,
        hotelId : String,
        roomId : String,
        adultCount : String,
        kidCount : String,
        startDate : String,
        endDate : String,
        extraBed : String,
        remark : String) {
        
        if !isLoading.value {
            isLoading.value = true
            bookingRepository.postBooking(apiKey: configs.apiKey,
                                          loginUserId: loginUserId,
                                          userName: userName,
                                          userEmail: userEmail,
                                          userPhone : userPhone,
                                          hotelId : hotelId,
                                          roomId : roomId,
                                          adultCount : adultCount,
                                          kidCount : kidCount,
                                          startDate : startDate,
                                          endDate : endDate,
                                          extraBed : extraBed,
                                          remark : remark)
        }
        
    }
    
    //get Booking List
    func getBookingList(loginUserId: String, isLoadFromServer: Bool? = true ) {
        
        if !isLoading.value {
            isLoading.value = true
            bookingRepository.getBookingList(apiKey: configs.apiKey,
                                             loginUserId: loginUserId,
                                             limit: configs.BOOKING_LIST_COUNT,
                                             offset: bookingListOffset,
                                             isLoadFromServer: isLoadFromServer)
    
        }
    }
    
}
