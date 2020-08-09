//
//  SearchFilterViewController.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/22/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
import GoogleMobileAds

class SearchFilterViewController: PSUIViewController {

    // MARK: - Custom variables
    @IBOutlet weak var searchFilterView: SearchFilterView!
    @IBOutlet weak var admobView: UIView!
    @IBOutlet weak var bannerHeight: NSLayoutConstraint!

    var delegate : SearchFilterProtocol? = nil
    var hotelStarStr: String = ""
    var lowerPrice : String = ""
    var upperPrice : String = ""
    var guestRating : String = ""
    var maxPrice : Price? = nil
    
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
     
        controllerTitle = language.searchFilterTitle
        
        searchFilterView.delegate = self.delegate
        searchFilterView.parent = self
        searchFilterView.hotelStarStr = hotelStarStr
        searchFilterView.lowerPrice = lowerPrice
        searchFilterView.upperPrice = upperPrice
        searchFilterView.guestRating = guestRating
        searchFilterView.maxPrice = maxPrice
        searchFilterView.setup()
        
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
        btnNaviMap.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        btnNaviMap.addTarget(self, action: #selector(SearchFilterViewController.clearClicked(_:)), for: .touchUpInside)
        let itemNaviMap = UIBarButtonItem()
        itemNaviMap.customView = btnNaviMap
        
        self.navigationItem.rightBarButtonItems = [itemNaviMap]
    }
    
    
    @objc func clearClicked(_ sender: UIBarButtonItem) {
        
        searchFilterView.clearClicked()
    }
    
}
