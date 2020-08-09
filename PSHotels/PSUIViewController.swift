//
//  PSUIViewController.swift
//  PSHotels
//
//  Created by Panacea-Soft on 1/19/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation

class PSUIViewController : UIViewController {
    
    // MARK: Variables
    var controllerTitle : String = ""
    var isLogin : Bool = false
    var loginUserId : String = ""
    
    // MARK: Ovrride Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshUserLogin()
        
        // Init PSNavigationController
        let _ = PSNavigationController.instance.setInit(storyboard: self.storyboard!, navigationController: self.navigationController!, navigationItem: navigationItem)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateNavigationStuff()
    }
    
    func updateNavigationStuff() {
        
        if self.controllerTitle == "" {
            self.navigationController?.navigationBar.topItem?.title = language.psTitle
        }else {
            self.navigationController?.navigationBar.topItem?.title = self.controllerTitle
        }
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: customFont.menuUIFont,  NSAttributedString.Key.foregroundColor:  configs.colorTextAlt]
        self.navigationController!.navigationBar.barTintColor = configs.colorPrimary
        self.navigationController!.navigationBar.tintColor = configs.colorTextAlt
    }
    
    func initSWReveal(menuButton : UIBarButtonItem) {
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        menuButton.tintColor = configs.colorTextAlt 
    }
    
    func refreshUserLogin() {
        // Checking user is login or not
        let userInfo = Common.instance.isUserLogin()
        self.isLogin = userInfo.isLogin
        self.loginUserId = userInfo.loginUserId
    }
}
