//
//  ReviewCategoryViewModel.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/10/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class ReviewCategoryViewModel : PSViewModel{
    
    //MARK: Variables for controllers
    var isLoading : LiveData<Bool> = LiveData(Bool())
    var cellId: String = ""
    
    
    // Hotel Review by hotel Id
    var reviewCategoryLiveData : LiveData<Resourse<[ReviewCategory]>?> = LiveData(Resourse<[ReviewCategory]>())
    
    //MARK: Private Variables
    private let reviewCategoryRepository : ReviewCategoryRepository

    //MARK: Override Methods
    override init() {
        
        reviewCategoryRepository = ReviewCategoryRepository()
        isLoading.value = false
        
        super.init()
        
        
        // reviewCategoryRepository
        reviewCategoryRepository.reviewCategoryLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                if resourse.status != Status.NO_ACTION {
                    self?.reviewCategoryLiveData.value = resourse
                }
                
            }
        }
    }
    
    // MARK: CUSTOM Functions
    
    func getReviewCategoryList() {
        
        if !isLoading.value {
            isLoading.value = true
            reviewCategoryRepository.getReviewCategoryList(apiKey: configs.apiKey)
        }
        
    }
    
            
}
