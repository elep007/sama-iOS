//
//  UserProfileEditViewController.swift
//  PSHotels
//
//  Created by Panacea-Soft on 2/7/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation

class UserProfileEditViewController: PSUIViewController {
    
    
    // MARK: IBOutlets
    @IBOutlet weak var profileEditView: ProfileEditView!
    var delegate : ProfileEditViewDelegate? = nil
    
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        super.controllerTitle = language.profileEditTitle
        
        PSNavigationController.instance.updateBackButton()
        
        profileEditView.parent = self
        profileEditView.delegate = delegate
        profileEditView.setup()
        
    }
}
