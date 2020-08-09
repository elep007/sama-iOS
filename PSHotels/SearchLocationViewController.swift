//
//  SearchLocationViewController.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/23/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
import GoogleMobileAds

class SearchLocationViewController: PSUIViewController {
    
    // MARK: - Custom variables
    @IBOutlet weak var searchLocationView: SearchLocationView!

    
    @IBOutlet weak var admobView: UIView!
    @IBOutlet weak var bannerHeight: NSLayoutConstraint!
    var delegate : SearchLocationProtocol? = nil
    
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controllerTitle = "Select Destination"
        
        searchLocationView.delegate = self.delegate
        searchLocationView.parent = self
        searchLocationView.setup()
        
        PSNavigationController.instance.updateBackButton()
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    
        setupAdmob()
    }
    
    // MARK: - Custom Functions
    func setupAdmob() {
       
    }
}

