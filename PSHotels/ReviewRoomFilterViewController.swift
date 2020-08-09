//
//  ReviewRoomFilterViewController.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/9/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
import GoogleMobileAds

class ReviewRoomFilterViewController: PSUIViewController {
    
    // MARK: - Custom variables
    

    
    @IBOutlet weak var reviewRoomFilterView: ReviewRoomFilterView!
    
    
    @IBOutlet weak var admobView: UIView!
    @IBOutlet weak var bannerHeight: NSLayoutConstraint!
    var delegate : RoomFilterViewProtocol? = nil
    var hotelData: Hotel? = nil
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controllerTitle = language.reviewRoomFilter
        
        reviewRoomFilterView.hotelData = hotelData
        reviewRoomFilterView.delegate = self.delegate
        reviewRoomFilterView.parent = self
        reviewRoomFilterView.setup()
        
        PSNavigationController.instance.updateBackButton()
       
        
        setupAdmob()
    }
    
    // MARK: - Custom Functions
    func setupAdmob() {
        
    }
}

