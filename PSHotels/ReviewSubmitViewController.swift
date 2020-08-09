//
//  ReviewSubmitViewController.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/9/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
class ReviewSubmitViewController: PSUIViewController {
    
    // MARK: - Custom variables
    
    
    var hotelData : Hotel? = nil
    var roomData : Room? = nil
    
    @IBOutlet weak var reviewSubmitView: ReviewSubmitView!
    var delegate : ReviewSubmitViewDelegate? = nil
    
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        controllerTitle = language.reviewSubmitTitle
        
        reviewSubmitView.parentView = self
        reviewSubmitView.delegate = delegate
        reviewSubmitView.hotelData = hotelData
        reviewSubmitView.roomData = roomData
        reviewSubmitView.setup()
        
        PSNavigationController.instance.updateBackButton()
        
    }
    
}
