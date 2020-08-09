//
//  ReviewListViewController.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/8/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class ReviewListViewController: PSUIViewController {
    
    // MARK: - Custom variables
    
    
    var hotelData : Hotel? = nil
    
    @IBOutlet weak var reviewListView: ReviewListView!
    var delegate : ReviewListViewDelegate? = nil
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controllerTitle = language.reviewTitle
        
        reviewListView.hotelData = hotelData
        reviewListView.delegate = delegate
        reviewListView.setup()
        
        PSNavigationController.instance.updateBackButton()
        
        addNavigationMenuItem()
    
    }
    
    // MARK: Custom Functions
    func addNavigationMenuItem() {
        
        self.navigationItem.rightBarButtonItems?.removeAll()
        
        let btnNaviMap = UIButton()
        btnNaviMap.setTitle("Add", for: .normal)
        btnNaviMap.titleLabel?.textAlignment = .right
        btnNaviMap.addTarget(self, action: #selector(ReviewListViewController.reviewEntryClicked(_:)), for: .touchUpInside)
        let itemNaviMap = UIBarButtonItem()
        itemNaviMap.customView = btnNaviMap
        btnNaviMap.frame = CGRect(x: 0, y: 0, width: 70, height: 20)
        btnNaviMap.titleLabel?.font = customFont.normalUIFont
        btnNaviMap.setTitleColor(configs.colorWhite, for: .normal)
        self.navigationItem.rightBarButtonItems = [itemNaviMap]
    }


    @objc func reviewEntryClicked(_ sender: UIBarButtonItem) {
        
        reviewListView.reviewEntryClicked()
    }
}
