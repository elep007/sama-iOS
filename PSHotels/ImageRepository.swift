//
//  ImageRepository.swift
//  PSHotels
//
//  Created by Panacea-Soft on 2/14/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation
import Alamofire

class ImageRepository : PSRepository<Any> {
    
    //************************************************************
    //MARK: Get Image List
    //************************************************************
    var imageListLiveData : LiveData<Resourse<[Image]>?> = LiveData(Resourse<[Image]>())
    
    func getImageList(apiKey: String,
                              newsId: String,
                              shouldFetch : Bool = true) {
        
        
        let imageList: Resourse<[Image]> = ImageDao.sharedManager.getImageByNewsId(newsId)
        if imageList.status == Status.SUCCESS {
            imageList.status = Status.LOADING
            imageListLiveData.value = imageList
        }
        
        
        // Load From Server
        if shouldFetch {
            
            if Connectivity.isConnected() {
            
                Alamofire.request(APIRouters.GetImageList(apiKey, newsId)).responseJSON{
                    response in
                    let result = self.parseJson(response: response, dataType: [Image].self)
                    
                    if result.status == Status.SUCCESS {
                        
                        ImageDao.sharedManager.deleteImageByNewsId(newsId)
                        
                        ImageDao.sharedManager.save(result.data!)
                        
                    }
                    
                    self.imageListLiveData.value = ImageDao.sharedManager.getImageByNewsId(newsId)
                }
            }else {
                let noAction = Resourse<[Image]>()
                noAction.status = Status.NO_ACTION
                self.imageListLiveData.value = noAction
            }
        }
       
        
    }
    
}
