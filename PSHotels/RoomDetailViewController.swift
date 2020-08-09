//
//  RoomDetailViewController.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/11/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
import GoogleMobileAds

class RoomDetailViewController: PSUIViewController {
    
    // MARK: - Custom variables

    
    @IBOutlet weak var admobView: UIView!
    @IBOutlet weak var bannerHeight: NSLayoutConstraint!
    var roomData: Room? = nil
    var delegate : RoomDetailViewDelegate? = nil
    @IBOutlet weak var roomDetailView: RoomDetailView!
    
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controllerTitle = (roomData?.room_name)!
        
        roomDetailView.roomData = roomData
        roomDetailView.delegate = delegate
        roomDetailView.setup()
        
        PSNavigationController.instance.updateBackButton()
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        setupAdmob()
    }
    
    // MARK: - Custom Functions
    func setupAdmob() {
        
    }
}


