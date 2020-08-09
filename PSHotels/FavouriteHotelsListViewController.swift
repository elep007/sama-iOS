//
//  FavouriteNewsListViewController.swift
//  PSHotels
//
//  Created by Panacea-Soft on 2/11/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation
import GoogleMobileAds

class FavouriteHotelsListViewController: PSUIViewController {
    
    // MARK: - Custom variables
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var admobView: UIView!
    @IBOutlet weak var bannerHeight: NSLayoutConstraint!
    @IBOutlet weak var favouriteListView: FavouriteListView!
    

    
    // MARK: Override FuncFavouriteListViewtions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerHeight.constant = 0.0
        
        // For Menu On/Off with Swipe
        super.initSWReveal(menuButton: menuButton)
        
        super.controllerTitle = language.myFavTitle
        
        favouriteListView.setup()
        
        setupAdmob()
        
    }
    
    // MARK: - Custom Functions
    func setupAdmob() {
        
    }
    
}

