//
//  InquiryViewController.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/15/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class InquiryViewController: PSUIViewController {
    
    // MARK: - Custom variables
    @IBOutlet weak var inquiryView: InquiryView!
    
    var hotelId: String = ""
    var roomId: String = ""
    
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.controllerTitle = language.inquiryTitle
        
        inquiryView.parentView = self
        inquiryView.hotelId = hotelId
        inquiryView.roomId = roomId
        inquiryView.setup()
    }
    
}

