//
//  BookingListViewController.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 5/3/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation


class BookingListViewController: PSUIViewController {
    
    // MARK: - Custom variables
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var admobView: UIView!
    @IBOutlet weak var bannerHeight: NSLayoutConstraint!
    @IBOutlet weak var bookingListView: BookingListView!
    

    
    // MARK: Override FuncFavouriteListViewtions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerHeight.constant = 0.0
        
        // For Menu On/Off with Swipe
        super.initSWReveal(menuButton: menuButton)
        
        super.controllerTitle = language.myBookingTitle
        
        bookingListView.setup()
        
        setupAdmob()
        
    }
    
    // MARK: - Custom Functions
    func setupAdmob() {
        
    }
    
}


