//
//  HotelDetailViewController.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/24/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
import GoogleMobileAds

class HotelDetailViewController: PSUIViewController {
    
    // MARK: - Custom variables

    
    
    @IBOutlet weak var admobView: UIView!
    @IBOutlet weak var bannerHeight: NSLayoutConstraint!
    var hotelData: Hotel? = nil
    @IBOutlet weak var hotelDetailView: HotelDetailView!
    var delegate : HotelDetailViewDelegate? = nil
    var isLoadedSubView = 0
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controllerTitle = (hotelData?.hotel_name)!
        hotelDetailView.hotelData = hotelData
        hotelDetailView.delegate = delegate
        hotelDetailView.setup()
        isLoadedSubView = isLoadedSubView + 1
        
        PSNavigationController.instance.updateBackButton()
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        setupAdmob()
    }
    
    override func viewDidLayoutSubviews() {
        
        
    }
 
    override func viewWillLayoutSubviews() {
        if( isLoadedSubView < 2) {
            
        }
    }
    
    // MARK: - Custom Functions
    func setupAdmob() {
       
    }
}

