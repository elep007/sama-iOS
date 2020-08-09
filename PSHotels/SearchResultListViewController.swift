//
//  SearchResultListViewController.swift
//  PSHotels
//
//  Created by Panacea-Soft on 2/13/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import UIKit
import GoogleMobileAds

class SearchResultListViewController: PSUIViewController {
    
    // MARK: - Custom variables
    @IBOutlet weak var searchResultListView: SearchResultListView!
    @IBOutlet weak var bannerHeight: NSLayoutConstraint!
    @IBOutlet weak var admobView: UIView!
        
    var cityId: String = ""
    var hotelName : String = ""
    var starRating : String = ""
    var lowerPrice : String = ""
    var upperPrice : String = ""
    var guestRating : String = ""
    var maxPrice : Price? = nil
    
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerHeight.constant = 0.0
        
        super.controllerTitle = language.searchResultTitle
        
        searchResultListView.cityId = cityId
        searchResultListView.hotelName = hotelName
        searchResultListView.starRating = starRating
        searchResultListView.lowerPrice = lowerPrice
        searchResultListView.upperPrice = upperPrice
        searchResultListView.maxPrice = maxPrice
        searchResultListView.guestRating = guestRating
        searchResultListView.setup()
        
        setupAdmob()
        
        addNavigationMenuItem()
        
    }
    
    // MARK: - Custom Functions
    func setupAdmob() {
        
    }
    
    // MARK: Custom Functions
    func addNavigationMenuItem() {
        
        self.navigationItem.rightBarButtonItems?.removeAll()
        
        let btnNaviMap = UIButton()
        btnNaviMap.setTitle("Filter", for: .normal)
        
        btnNaviMap.addTarget(self, action: #selector(SearchResultListViewController.filterHotelClicked(_:)), for: .touchUpInside)
        let itemNaviMap = UIBarButtonItem()
        itemNaviMap.customView = btnNaviMap
        btnNaviMap.frame = CGRect(x: 0, y: 0, width: 70, height: 20)
        btnNaviMap.titleLabel?.font = customFont.normalUIFont
        btnNaviMap.setTitleColor(configs.colorWhite, for: .normal)
        self.navigationItem.rightBarButtonItems = [itemNaviMap]
    }
    
    @objc func filterHotelClicked(_ sender: UIBarButtonItem) {
        
        searchResultListView.filterHotelClicked()
    }
    
}


