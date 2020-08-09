//
//  AboutUsViewController.swift
//  PSHotels
//
//  Created by Panacea-Soft on 10/26/17.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import UIKit

class AboutUsViewController: PSUIViewController {
    
    // MARK: - Custom variables
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var aboutUsView: AboutUsView!
    
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For Menu On/Off with Swipe
        super.initSWReveal(menuButton: menuButton)
        
        super.controllerTitle = language.aboutAppTitle
        
        aboutUsView.setup()
    }
    
}


