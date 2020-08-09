//
//  SearchViewController.swift
//
//  Created by Panacea-soft on 11/23/15.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import UIKit

class SearchViewController: PSUIViewController {
    
    // MARK: - Custom variables
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var searchViewContainer: SearchView!
    
    let reviewViewModel = ReviewViewModel()
    
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For Menu On/Off with Swipe
        super.initSWReveal(menuButton: menuButton)
        
        super.controllerTitle = language.psTitle
         searchViewContainer.parentView = self
        searchViewContainer.setup()
       
    }
        
}


