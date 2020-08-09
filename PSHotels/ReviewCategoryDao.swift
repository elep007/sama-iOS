//
//  ReviewCategoryDao.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/10/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class ReviewCategoryDao {
    
    // Singleton
    class var sharedManager: ReviewCategoryDao {
        struct Static {
            static let instance = ReviewCategoryDao()
        }
        return Static.instance
    }
    
    // Core ReviewCategory
    private let reviewCategoryFile = "ReviewCategory.json"
    private var reviewCategoryList  = Resourse<[ReviewCategory]>()

    // init
    init() {
        
        // Init Core
        if let reviewCategoryListFromFile : [ReviewCategory] = Storage.retrieve(reviewCategoryFile, from: .documents, as: [ReviewCategory].self) {
            reviewCategoryList = Resourse<[ReviewCategory]>(status: Status.SUCCESS, message: "", data: reviewCategoryListFromFile)
        }
    }
    
    
    //***************************************************************
    //MARK: Core ReviewCategory
    //***************************************************************
    
    // Save and Replace
    func save(_ reviewCategory : ReviewCategory) {
        
        if let data = self.reviewCategoryList.data {
            let index = data.firstIndex{$0 == reviewCategory}
            
            if let i = index {
                self.reviewCategoryList.data?[i] = reviewCategory
            }else {
                self.reviewCategoryList.data?.append(reviewCategory)
            }
            
        }else {
            self.reviewCategoryList.status = Status.SUCCESS
            self.reviewCategoryList.data = [reviewCategory]
        }
        self.reviewCategoryList.status = Status.SUCCESS
        Storage.store(reviewCategoryList.data!, to: .documents, as: reviewCategoryFile)
    }
    
    // Save and Replace All
    func save(_ reviewCategoryList : [ReviewCategory]) {
        for hotelFeature in reviewCategoryList {
            save(hotelFeature)
        }
    }
    
    // delete
    func deleteReviewCategory() {
        
        reviewCategoryList.data = [ReviewCategory]()
        Storage.store(reviewCategoryList.data!, to: .documents, as: reviewCategoryFile)
    }
    
    // get ReviewCategory by parent id
    func getReviewCategory()  -> Resourse<[ReviewCategory]> {
        
//        let reviewHolder : Resourse<[ReviewCategory]> = Resourse<[ReviewCategory]>()
//
//        if let data = reviewCategoryList.data {
//            let hotelFilter = data.filter{$0.review_parent_id == parent_id}
//            if hotelFilter.count > 0 {
//                reviewHolder.data = hotelFilter[0]
//                reviewHolder.status = Status.SUCCESS
//            }
//        }
        
        return reviewCategoryList
    }
    
    //***************************************************************
    // End Core ReviewCategory
    //***************************************************************
        
}
