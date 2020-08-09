//
//  HotelFilterViewController.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/10/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
import GoogleMobileAds

class HotelFilterViewController: PSUIViewController {
    
    // MARK: - Custom variables
    @IBOutlet weak var admobView: UIView!
    @IBOutlet weak var bannerHeight: NSLayoutConstraint!

    var delegate : HotelFilterProtocol? = nil
    var hotelStarStr: String = ""
    var lowerPrice : String = ""
    var upperPrice : String = ""
    var guestRating : String = ""
    var maxPrice : Price? = nil
    
    var cityId: String = ""
    var infoType: String = ""
    @IBOutlet weak var hotelFilterView: HotelFilterView!
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controllerTitle = language.hotelFilterTitle
        
        hotelFilterView.delegate = self.delegate
        hotelFilterView.parent = self
        hotelFilterView.hotelStarStr = hotelStarStr
        hotelFilterView.lowerPrice = lowerPrice
        hotelFilterView.upperPrice = upperPrice
        hotelFilterView.guestRating = guestRating
        hotelFilterView.maxPrice = maxPrice
        hotelFilterView.cityId = cityId
        hotelFilterView.infoType = infoType
        hotelFilterView.setup()
        
        addNavigationMenuItem("")
        
        PSNavigationController.instance.updateBackButton()
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        setupAdmob()
    }
    
    // MARK: - Custom Functions
    func setupAdmob() {
        
    }
    
    func addNavigationMenuItem(_ imageName: String) {
        
        self.navigationItem.rightBarButtonItems?.removeAll()
        
        let btnNaviMap = UIButton()
        btnNaviMap.setTitle("Clear", for: .normal)
        btnNaviMap.setImage(UIImage(named: imageName), for: UIControl.State())
        btnNaviMap.frame = CGRect(x: 0, y: 0, width: 70, height: 20)
        btnNaviMap.addTarget(self, action: #selector(SearchFilterViewController.clearClicked(_:)), for: .touchUpInside)
        let itemNaviMap = UIBarButtonItem()
        itemNaviMap.customView = btnNaviMap
        
        self.navigationItem.rightBarButtonItems = [itemNaviMap]
    }
    
    
    @objc func clearClicked(_ sender: UIBarButtonItem) {
        
        hotelFilterView.clearClicked()
    }
    
}
