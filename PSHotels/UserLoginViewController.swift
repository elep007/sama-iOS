//
//  UserLoginViewController.swift
//  PSHotels
//
//  Created by Panacea-Soft on 2/14/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation

class UserLoginViewController: PSUIViewController {
    
    // MARK: - Custom variables
    @IBOutlet weak var loginView: LoginView!
    
    var loginViewDelegate : LoginViewDelegate?
    
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        super.controllerTitle = language.LoginTitle
        
        loginView.parent = self
        loginView.isHomeView = false
        loginView.loginViewDelegate = loginViewDelegate
        loginView.setup()
        
        
    }
    
    // MARK: - Custom Functions
    func updateMenu() {
        (self.revealViewController().rearViewController as? MenuListController)?.userLoggedIn = true
    }
    
}
