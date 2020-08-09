//
//  ForgotPasswordViewController.swift
//  PSHotels
//
//  Created by Panacea-Soft on 2/7/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation

class UserForgotPasswordViewController : PSUIViewController {
    
    // MARK: - Custom variables
    @IBOutlet weak var forgotPasswordView: ForgotPasswordView!
    
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        super.controllerTitle = language.forgotPasswordTitle
        
        forgotPasswordView.parent = self
        forgotPasswordView.setup()
    }
}
