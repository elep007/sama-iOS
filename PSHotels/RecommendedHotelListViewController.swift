//
//  RecommendedHotelListViewController.swift
//  PSHotels
//
//  Created by Panacea-Soft on 2/11/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation
import GoogleMobileAds

class RecommendedHotelListViewController: PSUIViewController {
    
    // MARK: - Custom variables
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var admobView: UIView!
    @IBOutlet weak var bannerHeight: NSLayoutConstraint!
    @IBOutlet weak var recommendedListView: RecommendedListView!
    

  
    
    //var adBannerView: GADBannerView?
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerHeight.constant = 0.0
        
        // For Menu On/Off with Swipe
        super.initSWReveal(menuButton: menuButton)
        
        super.controllerTitle = language.menu__recommendedHotel
        
        recommendedListView.setup()
        
        setupAdmob()
        
    }
    
    // MARK: - Custom Functions
    func setupAdmob() {
        
    }
    
}
