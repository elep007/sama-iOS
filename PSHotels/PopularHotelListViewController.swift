//
//  PopularHotelListViewController.swift
//  PSHotels
//
//  Created by Panacea-Soft on 2/11/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation
import GoogleMobileAds

class PopularHotelListViewController: PSUIViewController {
    
    // MARK: - Custom variables
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var popularListView: PopularListView!
    @IBOutlet weak var bannerHeight: NSLayoutConstraint!
    @IBOutlet weak var admobView: UIView!
    

    
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerHeight.constant = 0.0
        
        // For Menu On/Off with Swipe
        super.initSWReveal(menuButton: menuButton)
        
        super.controllerTitle = language.menu__popularHotels
        
        popularListView.setup()
        
        setupAdmob()
    }
    
    // MARK: - Custom Functions
    func setupAdmob() {
        
    }
    
}

