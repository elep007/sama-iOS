//
//  RoomReviewListViewController.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/21/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class RoomReviewListViewController: PSUIViewController {
    
    // MARK: - Custom variables
    
    
    var roomData : Room? = nil
    
    @IBOutlet weak var roomReviewListView: RoomReviewListView!
    
    var delegate : RoomReviewListViewDelegate? = nil
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controllerTitle = language.reviewTitle
        
        roomReviewListView.roomData = roomData
        roomReviewListView.delegate = delegate
        roomReviewListView.setup()
        
        PSNavigationController.instance.updateBackButton()
        
        addNavigationMenuItem()
        
    }
    
    // MARK: Custom Functions
    func addNavigationMenuItem() {
        
        self.navigationItem.rightBarButtonItems?.removeAll()
        
        let btnNaviMap = UIButton()
        btnNaviMap.setTitle("Add", for: .normal)
        
        btnNaviMap.addTarget(self, action: #selector(RoomReviewListViewController.reviewEntryClicked(_:)), for: .touchUpInside)
        let itemNaviMap = UIBarButtonItem()
        itemNaviMap.customView = btnNaviMap
        btnNaviMap.titleLabel?.font = customFont.normalUIFont
        btnNaviMap.setTitleColor(configs.colorWhite, for: .normal)
        self.navigationItem.rightBarButtonItems = [itemNaviMap]
    }
    
    
    @objc func reviewEntryClicked(_ sender: UIBarButtonItem) {
        
        roomReviewListView.reviewEntryClicked()
    }
}
