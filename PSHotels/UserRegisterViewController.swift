//
//  UserRegisterViewController.swift
//  PSHotels
//
//  Created by Panacea-Soft on 2/7/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation

class UserRegisterViewController : PSUIViewController {
    
    // MARK: - Custom variables
    @IBOutlet weak var registerView: RegistrationView!
    var delegate: RegisterViewDelegate?
    
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        super.controllerTitle = language.registerTitle
        
        registerView.parent = self
        registerView.delegate = self.delegate!
        registerView.setup()
    }
}
