//
//  ReviewViewModel.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/3/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class ReviewViewModel : PSViewModel{
    
    //MARK: Variables for controllers
    var isLoading : LiveData<Bool> = LiveData(Bool())
    var cellId: String = ""
    var headerCellId: String = ""
    
    
    // Hotel Review by hotel Id
    var hotelReviewSummaryLiveData : LiveData<Resourse<Review>?> = LiveData(Resourse<Review>())

    // Hotel Review Detail
    var hotelReviewDetailLiveData : LiveData<Resourse<[ReviewDetail]>?> = LiveData(Resourse<[ReviewDetail]>())
    var hotelReviewDetailListOffset = 0
    
    // Room Review by hotel Id
    var roomReviewSummaryLiveData : LiveData<Resourse<Review>?> = LiveData(Resourse<Review>())
    
    // Room Review Detail
    var roomReviewDetailLiveData : LiveData<Resourse<[ReviewDetail]>?> = LiveData(Resourse<[ReviewDetail]>())
    var roomReviewDetailListOffset = 0
    
    // Post Review
    var postReviewLiveData : LiveData<Resourse<ApiStatus>?> = LiveData(Resourse<ApiStatus>())
    
    
    //MARK: Private Variables
    private let reviewRepository : ReviewRepository
    
    
    //MARK: Override Methods
    override init() {
        
        reviewRepository = ReviewRepository()
        isLoading.value = false
        
        super.init()
        
        
        // hotel review summary
        reviewRepository.hotelReviewSummaryLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                
                if resourse.status != Status.NO_ACTION {
                    self?.hotelReviewSummaryLiveData.value = resourse
                }
                
            }
            
        }
        
        
        // hotel review detail
        reviewRepository.hotelReviewDetailListLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                if resourse.status != Status.NO_ACTION {
                    self?.hotelReviewDetailLiveData.value = resourse
                    if let data = resourse.data {
                        self?.hotelReviewDetailListOffset = data.count
                    }
                }
                
            }
        }
        
        // room review summary
        reviewRepository.roomReviewSummaryLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                
                if resourse.status != Status.NO_ACTION {
                    self?.roomReviewSummaryLiveData.value = resourse
                }
                
            }
            
        }
        
        
        // room review detail
        reviewRepository.roomReviewDetailListLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                if resourse.status != Status.NO_ACTION {
                    self?.roomReviewDetailLiveData.value = resourse
                    if let data = resourse.data {
                        self?.roomReviewDetailListOffset = data.count
                    }
                }
                
            }
        }
        
        // Post Review
        reviewRepository.postReviewLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                self?.postReviewLiveData.value = resourse
                
            }
            
        }
        
    }
    
    // MARK: CUSTOM Functions
    
    func getHotelReviewSummary(parentId: String) {
        
        reviewRepository.getHotelReviewSummary(apiKey: configs.apiKey, parentId: parentId)
        
    }
    
    func getHotelReviewDetail(parentId: String) {
        
        if !isLoading.value {
            isLoading.value = true
            reviewRepository.getHotelReviewDetailList(apiKey: configs.apiKey,
                                                 parentId: parentId,
                                                 limit: configs.REVIEW_DETAIL_COUNT,
                                                 offset: hotelReviewDetailListOffset)
        }
        
    }
    
    func getRoomReviewSummary(parentId: String) {
        
        reviewRepository.getRoomReviewSummary(apiKey: configs.apiKey, parentId: parentId)
        
    }
    
    func getRoomReviewDetail(parentId: String) {
        
        if !isLoading.value {
            isLoading.value = true
            reviewRepository.getRoomReviewDetailList(apiKey: configs.apiKey,
                                                      parentId: parentId,
                                                      limit: configs.REVIEW_DETAIL_COUNT,
                                                      offset: hotelReviewDetailListOffset)
        }
        
    }
    
    
    func doPostReview(roomId: String, loginUserId: String, desc: String, ratingObjArr: [RatingPostObject]) {
        
        if !isLoading.value {
            isLoading.value = true
            reviewRepository.postReview(apiKey: configs.apiKey, userId: loginUserId, roomId: roomId, desc: desc, ratingObjArr: ratingObjArr)
        }
    }
    
}
