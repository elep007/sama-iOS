//
//  ImageDao.swift
//  PSHotels
//
//  Created by Panacea-Soft on 2/14/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation

class ImageDao {
    
    // Singleton
    class var sharedManager: ImageDao {
        struct Static {
            static let instance = ImageDao()
        }
        return Static.instance
    }
    
    // Core Image
    private let imageFile = "imageFile.json"
    private var imageList  = Resourse<[Image]>()
    
    // init
    init() {
        
        // Init
        if let imageListFromFile : [Image] = Storage.retrieve(imageFile, from: .documents, as: [Image].self) {
            imageList = Resourse<[Image]>(status: Status.SUCCESS, message: "", data: imageListFromFile)
        }
    }
    
    
    //***************************************************************
    //MARK: Core Image
    //***************************************************************
    
    // Save and Replace
    func save(_ image : Image) {
        
        if let data = self.imageList.data {
            let index = data.firstIndex{$0 == image}
            // print("\(String(describing: index))")
            
            if let i = index {
                self.imageList.data?[i] = image
            }else {
                self.imageList.data?.append(image)
            }
            
        }else {
            self.imageList.status = Status.SUCCESS
            self.imageList.data = [image]
        }
        
        Storage.store(imageList.data!, to: .documents, as: imageFile)
    }
    
    // Save and Replace All
    func save(_ imageList : [Image]) {
        if let _ = self.imageList.data {
            for image in imageList {
                
                if let data = self.imageList.data {
                    let index = data.firstIndex{$0 == image}
                    // print("\(String(describing: index))")
                    
                    if let i = index {
                        self.imageList.data?[i] = image
                    }else {
                        self.imageList.data?.append(image)
                    }
                    
                }else {
                    self.imageList.data?.append(image)
                }
            }
        }else {
            self.imageList.status = Status.SUCCESS
            self.imageList.data = imageList
        }
        
        
        Storage.store(self.imageList.data!, to: .documents, as: imageFile)
    }
    
    // get Image by Image ID
    func getImageByNewsId(_ newsId: String)  -> Resourse<[Image]> {
        
        let imageHolder : Resourse<[Image]> = Resourse<[Image]>()
        
        if let data = imageList.data {
            let imageFilter = data.filter{$0.img_parent_id == newsId}
            if imageFilter.count > 0 {
                imageHolder.data = imageFilter
                imageHolder.status = Status.SUCCESS
            }
            
        }
        
        return imageHolder
    }
    
    func deleteImageByNewsId(_ newsId: String) {
        if let data = imageList.data {
            let filteredResult = data.filter{$0.img_parent_id != newsId}
            Storage.store(filteredResult, to: .documents, as: imageFile)
            self.imageList.data = filteredResult
        }
    }
    
}

