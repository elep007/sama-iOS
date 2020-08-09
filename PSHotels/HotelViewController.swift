//
//  HotelViewController.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/24/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
import GoogleMobileAds

class HotelViewController: PSUIViewController {
    
    // MARK: - Custom variables
    

    var hotelData : Hotel? = nil
    
    @IBOutlet weak var hotelView: HotelView!
    @IBOutlet weak var admobView: UIView!
    @IBOutlet weak var bannerHeight: NSLayoutConstraint!
    var delegate: HotelViewDelegate? = nil
    
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        controllerTitle = (hotelData?.hotel_name)!
        
        hotelView.hotelData = hotelData
        hotelView.delegate = delegate
        hotelView.setup()
        
        PSNavigationController.instance.updateBackButton()
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        setupAdmob()
    }
    
    // MARK: - Custom Functions
    func setupAdmob() {
       
    }
}

