//
//  ReviewRepository.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/3/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
import Alamofire

class ReviewRepository : PSRepository<Any> {
    
    //************************************************************
    //MARK: Get Hotel Reviews Summary
    //************************************************************
    var hotelReviewSummaryLiveData : LiveData<Resourse<Review>?> = LiveData(Resourse<Review>())
    
    func getHotelReviewSummary(apiKey: String, parentId: String) {
        
        let reviewData = ReviewDao.sharedManager.getReviewById(parentId)
        if reviewData.status == Status.SUCCESS {
            reviewData.status = Status.LOADING
            self.hotelReviewSummaryLiveData.value = reviewData
        }
        
        if Connectivity.isConnected() {
            Alamofire.request(APIRouters.GetHotelReviewSummary(apiKey, parentId)).responseJSON{
                response in
                
                let result = self.parseJson(response: response, dataType: Review.self)
                
                if result.status == Status.SUCCESS {
                    
                    ReviewDao.sharedManager.deleteReviewByParentId(parentId)
                    
                    ReviewDao.sharedManager.save(result.data!)
                }
                
                self.hotelReviewSummaryLiveData.value = ReviewDao.sharedManager.getReviewById(parentId)
            }
        }else {
            let noAction = Resourse<Review>()
            noAction.status = Status.NO_ACTION
            self.hotelReviewSummaryLiveData.value = noAction
        }
    }
    
    //************************************************************
    //MARK: Hotel Review Detail
    //************************************************************
    var hotelReviewDetailListLiveData : LiveData<Resourse<[ReviewDetail]>?> = LiveData(Resourse<[ReviewDetail]>())
    
    func getHotelReviewDetailList(apiKey: String,
                             parentId: String,
                             limit: Int,
                             offset: Int,
                             isResetData : Bool = false,
                             isLoadFromServer : Bool = true) {
        
        if isResetData {
            let reviewDetailList: Resourse<[ReviewDetail]> = Resourse<[ReviewDetail]>()
            reviewDetailList.status = Status.LOADING
            hotelReviewDetailListLiveData.value = reviewDetailList
            
        }else {
            if (offset == 0) {
                // Load From Local
                // Only for offset is 0
                // If offset is not 0, it is loading for next page,
                // So, no need to load from cache
                let reviewDetailList: Resourse<[ReviewDetail]> = ReviewDao.sharedManager.getReviewDetailById(parentId)
                if reviewDetailList.status == Status.SUCCESS {
                    reviewDetailList.status = Status.LOADING
                    hotelReviewDetailListLiveData.value = reviewDetailList
                }
                
            }
        }
        
        // Load From Server
        if isLoadFromServer {
            if Connectivity.isConnected() {
                Alamofire.request(APIRouters.GetHotelReviewDetail(apiKey,
                                                             parentId,
                                                             limit,
                                                             offset
                                                             )).responseJSON{
                                                                response in
                    let result = self.parseJson(response: response, dataType: [ReviewDetail].self)
                    
                    if result.status == Status.SUCCESS {
                        
                        ReviewDao.sharedManager.deleteReviewDetailByParentId(parentId)
                        
                        ReviewDao.sharedManager.save(result.data!)
                        
                    } else if result.status == Status.ERROR
                        && offset == 0 {
                        ReviewDao.sharedManager.deleteReviewDetailByParentId(parentId)
                    }
                    
                    self.hotelReviewDetailListLiveData.value = ReviewDao.sharedManager.getReviewDetailById(parentId)
                                                                
                }
            }else {
                let noAction = Resourse<[ReviewDetail]>()
                noAction.status = Status.NO_ACTION
                self.hotelReviewDetailListLiveData.value = noAction
            }
        }
        
        
    }
    
    
    //************************************************************
    //MARK: Get Room Reviews Summary
    //************************************************************
    var roomReviewSummaryLiveData : LiveData<Resourse<Review>?> = LiveData(Resourse<Review>())
    
    func getRoomReviewSummary(apiKey: String, parentId: String) {
        
        let reviewData = ReviewDao.sharedManager.getReviewById(parentId)
        if reviewData.status == Status.SUCCESS {
            reviewData.status = Status.LOADING
            self.roomReviewSummaryLiveData.value = reviewData
        }
        
        if Connectivity.isConnected() {
            Alamofire.request(APIRouters.GetRoomReviewSummary(apiKey, parentId)).responseJSON{
                response in
                
                let result = self.parseJson(response: response, dataType: Review.self)
                
                if result.status == Status.SUCCESS {
                    
                    ReviewDao.sharedManager.deleteReviewByParentId(parentId)
                    
                    ReviewDao.sharedManager.save(result.data!)
                }
                
                self.roomReviewSummaryLiveData.value = ReviewDao.sharedManager.getReviewById(parentId)
            }
        }else {
            let noAction = Resourse<Review>()
            noAction.status = Status.NO_ACTION
            self.roomReviewSummaryLiveData.value = noAction
        }
    }
    
    //************************************************************
    //MARK: Room Review Detail
    //************************************************************
    var roomReviewDetailListLiveData : LiveData<Resourse<[ReviewDetail]>?> = LiveData(Resourse<[ReviewDetail]>())
    
    func getRoomReviewDetailList(apiKey: String,
                                  parentId: String,
                                  limit: Int,
                                  offset: Int,
                                  isResetData : Bool = false,
                                  isLoadFromServer : Bool = true) {
        
        if isResetData {
            let reviewDetailList: Resourse<[ReviewDetail]> = Resourse<[ReviewDetail]>()
            reviewDetailList.status = Status.LOADING
            roomReviewDetailListLiveData.value = reviewDetailList
            
        }else {
            if (offset == 0) {
                // Load From Local
                // Only for offset is 0
                // If offset is not 0, it is loading for next page,
                // So, no need to load from cache
                let reviewDetailList: Resourse<[ReviewDetail]> = ReviewDao.sharedManager.getReviewDetailById(parentId)
                if reviewDetailList.status == Status.SUCCESS {
                    reviewDetailList.status = Status.LOADING
                    roomReviewDetailListLiveData.value = reviewDetailList
                }
                
            }
        }
        
        // Load From Server
        if isLoadFromServer {
            if Connectivity.isConnected() {
                Alamofire.request(APIRouters.GetRoomReviewDetail(apiKey,
                                                                  parentId,
                                                                  limit,
                                                                  offset
                )).responseJSON{
                    response in
                    let result = self.parseJson(response: response, dataType: [ReviewDetail].self)
                    
                    if result.status == Status.SUCCESS {
                        
                        ReviewDao.sharedManager.deleteReviewDetailByParentId(parentId)
                        
                        ReviewDao.sharedManager.save(result.data!)
                        
                    } else if result.status == Status.ERROR
                        && offset == 0 {
                        ReviewDao.sharedManager.deleteReviewDetailByParentId(parentId)
                    }
                    
                    self.roomReviewDetailListLiveData.value = ReviewDao.sharedManager.getReviewDetailById(parentId)
                    
                }
            }else {
                let noAction = Resourse<[ReviewDetail]>()
                noAction.status = Status.NO_ACTION
                self.roomReviewDetailListLiveData.value = noAction
            }
        }
        
        
    }
    
    //************************************************************
    //MARK: Post Review
    //************************************************************
    var postReviewLiveData : LiveData<Resourse<ApiStatus>?> = LiveData(Resourse<ApiStatus>())
    
    func postReview(apiKey: String, userId: String, roomId: String, desc: String, ratingObjArr: [RatingPostObject]) {
        
        if Connectivity.isConnected() {
            
            do {
          
                let ratingJSON = try JSONEncoder().encode(ratingObjArr)
                let jsonString = NSString(data: ratingJSON, encoding: String.Encoding.utf8.rawValue)
                
                if let rj : NSString = jsonString {
                    
                    let param: [String: AnyObject] = ["room_id": roomId as AnyObject,
                                                      "user_id": userId as AnyObject,
                                                      "review_desc": desc as AnyObject,
                                                      "ratings": rj ]
                
                    Alamofire.request(APIRouters.PostReview(apiKey, param)).responseJSON{
                        response in

                        let result = self.parseJson(response: response, dataType: ApiStatus.self)
                        
                        self.postReviewLiveData.value = result
                        
                    }
                }
            
            } catch _ {
                
            }
        }
    }
    
    
    
}
