//
//  ImageViewModel.swift
//  PSImage
//
//  Created by Panacea-Soft on 2/14/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation

class ImageViewModel : PSViewModel{
    
    //MARK: Variables for controllers
    var cellId : String = ""
    var isLoading : LiveData<Bool> = LiveData(Bool())


    // Image List
    var imageListLiveData : LiveData<Resourse<[Image]>?> = LiveData(Resourse<[Image]>())

    //MARK: Private Variables
    private let imageRepository : ImageRepository
    
    
    //MARK: Override Methods
    override init() {
        
        imageRepository = ImageRepository()
        isLoading.value = false
        
        super.init()
        
        // Image List
        imageRepository.imageListLiveData.bind { [weak self] in
            
            if let resourse = $0 {
                
                if resourse.status != Status.LOADING {
                    self?.isLoading.value = false
                }
                
                if resourse.status != Status.NO_ACTION {
                    self?.imageListLiveData.value = resourse
                }
                
            }
            
        }
    }

    
    //MARK: Custom Methods
    func getImageList(newsId : String) {
        
        if !isLoading.value {
            
            isLoading.value = true
            imageRepository.getImageList(apiKey: configs.apiKey,
                                         newsId: newsId)
            
        }
    }
}
