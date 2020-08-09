//
//  ReviewCategoryRepository.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/10/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
import Alamofire

class ReviewCategoryRepository : PSRepository<Any> {
    
    //************************************************************
    //MARK: Get Review Category
    //************************************************************
    var reviewCategoryLiveData : LiveData<Resourse<[ReviewCategory]>?> = LiveData(Resourse<[ReviewCategory]>())
    
    func getReviewCategoryList(apiKey: String) {
        
        let reviewData = ReviewCategoryDao.sharedManager.getReviewCategory()
        if reviewData.status == Status.SUCCESS {
            reviewData.status = Status.LOADING
            self.reviewCategoryLiveData.value = reviewData
        }
        
        if Connectivity.isConnected() {
            Alamofire.request(APIRouters.GetReviewCategory(apiKey)).responseJSON{
                response in
                
                let result = self.parseJson(response: response, dataType: [ReviewCategory].self)
                
                if result.status == Status.SUCCESS {
                    
                    ReviewCategoryDao.sharedManager.deleteReviewCategory()
                    
                    ReviewCategoryDao.sharedManager.save(result.data!)
                }
                
                self.reviewCategoryLiveData.value = ReviewCategoryDao.sharedManager.getReviewCategory()
            }
        }else {
            let noAction = Resourse<[ReviewCategory]>()
            noAction.status = Status.NO_ACTION
            self.reviewCategoryLiveData.value = noAction
        }
    }
}
