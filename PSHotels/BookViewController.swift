//
//  BookViewController.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 5/2/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class BookViewController: PSUIViewController {
    
    // MARK: - Custom variables
    @IBOutlet weak var bookView: BookView!
    
    
    var hotelId: String = ""
    var roomId: String = ""
    
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        super.controllerTitle = language.bookingTitle
        
        bookView.parentView = self
        bookView.hotelId = hotelId
        bookView.roomId = roomId
        bookView.setup()
    }
    
}
