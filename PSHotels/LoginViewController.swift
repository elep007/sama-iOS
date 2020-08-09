//
//  LoginViewController.swift
//  PSHotels
//
//  Created by Panacea-Soft on 1/27/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation

class LoginViewController: PSUIViewController {
    
    // MARK: - Custom variables
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var loginView: LoginView!
    
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        super.controllerTitle = language.LoginTitle
        
        // For Menu On/Off with Swipe
        super.initSWReveal(menuButton: menuButton)
        
        loginView.setup()
    }
    
    // MARK: - Custom Functions
    
}
