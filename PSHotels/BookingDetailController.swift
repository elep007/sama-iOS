//
//  BookingDetailController.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 5/4/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class BookingDetailController: PSUIViewController {
    
    
    // MARK: IBOutlets
    @IBOutlet weak var bookingDetailView: BookingDetailView!
    var booking : Booking? = nil
    
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        super.controllerTitle = language.bookingTitle
        
        PSNavigationController.instance.updateBackButton()

        bookingDetailView.bookingData = booking
        bookingDetailView.setup()
        
    }
}
