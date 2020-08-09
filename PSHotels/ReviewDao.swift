//
//  ReviewDao.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/9/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class ReviewDao {
    
    // Singleton
    class var sharedManager: ReviewDao {
        struct Static {
            static let instance = ReviewDao()
        }
        return Static.instance
    }
    
    // Core Review
    private let reviewFile = "Review.json"
    private var reviewList  = Resourse<[Review]>()
    
    
    private let reviewDetailFile = "ReviewDetail.json"
    private var reviewDetailList  = Resourse<[ReviewDetail]>()
    
    // init
    init() {
        
        // Init Core
        if let reviewListFromFile : [Review] = Storage.retrieve(reviewFile, from: .documents, as: [Review].self) {
            reviewList = Resourse<[Review]>(status: Status.SUCCESS, message: "", data: reviewListFromFile)
        }
        
        // Review Detail
        if let reviewDetailListFromFile : [ReviewDetail] = Storage.retrieve(reviewDetailFile, from: .documents, as: [ReviewDetail].self) {
            reviewDetailList = Resourse<[ReviewDetail]>(status: Status.SUCCESS, message: "", data: reviewDetailListFromFile)
        }
        
    }
    
    
    //***************************************************************
    //MARK: Core Review
    //***************************************************************
    
    // Save and Replace
    func save(_ review : Review) {
        
        if let data = self.reviewList.data {
            let index = data.firstIndex{$0 == review}
            
            if let i = index {
                self.reviewList.data?[i] = review
                
                self.reviewList.data?[i].rating = Rating()
            }else {
                self.reviewList.data?.append(review)
            }
            
        }else {
            self.reviewList.status = Status.SUCCESS
            self.reviewList.data = [review]
        }
        
        Storage.store(reviewList.data!, to: .documents, as: reviewFile)
    }
    
    // Save and Replace All
    func save(_ reviewList : [Review]) {
        for hotelFeature in reviewList {
            save(hotelFeature)
        }
    }
    
    // delete by parent id
    func deleteReviewByParentId(_ parent_id: String) {
        if let data = reviewList.data {
            let result = data.filter{$0.review_parent_id != parent_id}
            reviewList.data = result
            Storage.store(reviewList.data!, to: .documents, as: reviewFile)
        }
    }
    
    // get Review by parent id
    func getReviewById(_ parent_id: String)  -> Resourse<Review> {
        
        let reviewHolder : Resourse<Review> = Resourse<Review>()
        
        if let data = reviewList.data {
            let hotelFilter = data.filter{$0.review_parent_id == parent_id}
            if hotelFilter.count > 0 {
                reviewHolder.data = hotelFilter[0]
                reviewHolder.status = Status.SUCCESS
            }
        }
        
        return reviewHolder
    }
    
    //***************************************************************
    // End Core Review
    //***************************************************************
    
    
    
    //***************************************************************
    //MARK: Core ReviewDetail
    //***************************************************************
    
    // Save and Replace
    func save(_ reviewDetail : ReviewDetail) {
        
        if let data = self.reviewDetailList.data {
            let index = data.firstIndex{$0 == reviewDetail}
            
            if let i = index {
                self.reviewDetailList.data?[i] = reviewDetail
            }else {
                self.reviewDetailList.data?.append(reviewDetail)
            }
            
        }else {
            self.reviewDetailList.status = Status.SUCCESS
            self.reviewDetailList.data = [reviewDetail]
        }
        
        Storage.store(reviewDetailList.data!, to: .documents, as: reviewDetailFile)
    }
    
    // Save and Replace All
    func save(_ reviewDetailList : [ReviewDetail]) {
        for hotelFeature in reviewDetailList {
            save(hotelFeature)
        }
    }
    
    // delete by parent id
    func deleteReviewDetailByParentId(_ parent_id: String) {
        if let data = reviewDetailList.data {
            let result = data.filter{$0.review_parent_id != parent_id}
            reviewDetailList.data = result
            Storage.store(reviewDetailList.data!, to: .documents, as: reviewDetailFile)
        }
    }
    
    // get ReviewDetail by parent id
    func getReviewDetailById(_ parent_id: String)  -> Resourse<[ReviewDetail]> {
        
        let reviewDetailHolder : Resourse<[ReviewDetail]> = Resourse<[ReviewDetail]>()
        
        if let data = reviewDetailList.data {
            let hotelFilter = data.filter{$0.review_parent_id == parent_id}
            if hotelFilter.count > 0 {
                reviewDetailHolder.data = hotelFilter
                reviewDetailHolder.status = Status.SUCCESS
            }else {
                reviewDetailHolder.status = Status.ERROR
            }
        }
        
        return reviewDetailHolder
    }
    
    //***************************************************************
    // End Review Detail
    //***************************************************************
    
}
