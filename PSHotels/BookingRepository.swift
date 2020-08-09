//
//  BookingRepository.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 5/3/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
import Alamofire

class BookingRepository : PSRepository<Any> {
    
    //************************************************************
    //MARK: Post Booking
    //************************************************************
    var postBookingLiveData : LiveData<Resourse<Booking>?> = LiveData(Resourse<Booking>())
    
    func postBooking(apiKey : String,
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
        
        if Connectivity.isConnected() {
            
            let param: [String: AnyObject] = [
                "login_user_id": loginUserId as AnyObject,
                "booking_user_name": userName as AnyObject,
                "booking_user_email": userEmail as AnyObject,
                "booking_user_phone": userPhone as AnyObject,
                "hotel_id": hotelId as AnyObject,
                "room_id": roomId as AnyObject,
                "booking_adult_count": adultCount as AnyObject,
                "booking_kid_count": kidCount as AnyObject,
                "booking_start_date": startDate as AnyObject,
                "booking_end_date": endDate as AnyObject,
                "booking_extra_bed": extraBed as AnyObject,
                "booking_remark": remark as AnyObject]
            
            print(param)
            Alamofire.request(APIRouters.PostBooking(apiKey, param)).responseJSON{
                response in
                let result = self.parseJson(response: response, dataType: Booking.self)
                
                self.postBookingLiveData.value = result
            }
        }
    }
    
    
    //************************************************************
    //MARK: Get Booking List
    //************************************************************
    var bookingListLiveData : LiveData<Resourse<[Booking]>?> = LiveData(Resourse<[Booking]>())
    
    func getBookingList(apiKey: String,
                        loginUserId : String,
                        limit : Int,
                        offset : Int,
                        isLoadFromServer: Bool? = true) {
        
        if (offset <= 0) {
            // Load From Local
            // Only for offset is 0
            // If offset is not 0, it is loading for next page,
            // So, no need to load from cache
            let bookingList = BookingDao.sharedManager.getbookingList()
            if bookingList.status == Status.SUCCESS || bookingList.status == Status.NO_ACTION {
                bookingList.status = Status.LOADING
                self.bookingListLiveData.value = bookingList
            }
            
        }
        
        // Load From Server
        if isLoadFromServer! {
            if Connectivity.isConnected() {
                Alamofire.request(APIRouters.GetBookingList(apiKey, loginUserId, limit, offset)).responseJSON{
                    response in
                    let result = self.parseJson(response: response, dataType: [Booking].self)
                    
                    if offset <= 0 { // delete all booking
                        BookingDao.sharedManager.deletebookingList()
                    }
                    
                    if result.status == Status.SUCCESS {
                        BookingDao.sharedManager.save(result.data!)
                    }
                    
                    let rData : Resourse<[Booking]> = BookingDao.sharedManager.getbookingList()
                    rData.status = result.status
                    rData.message = result.message
                    self.bookingListLiveData.value = rData
                }
            }else {
                let noAction = Resourse<[Booking]>()
                noAction.status = Status.NO_ACTION
                self.bookingListLiveData.value = noAction
            }
        }
    }
    
}
