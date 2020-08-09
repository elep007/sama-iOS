//
//  GalleryViewController.swift
//  PSHotels
//
//  Created by Panacea-Soft on 2/14/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation


class GalleryViewController: PSUIViewController {
    
    // MARK: - Custom variables
    @IBOutlet weak var galleryView: GalleryView!
    
    var newsId: String = ""
    
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.controllerTitle = language.galleryTitle
        
        galleryView.newsId = newsId
        galleryView.parent = self
        galleryView.setup()
        
    }
    
    
}
