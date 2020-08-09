//
//  ForgotPasswordView.swift
//  PSHotels
//
//  Created by Panacea-Soft on 10/25/17.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import UIKit

@IBDesignable
class ForgotPasswordView: PSUIView {

    // NibName of View. This variable will use later in getNibName()
    var parent: UserForgotPasswordViewController?
    var userViewModel = UserViewModel()
    
    @IBOutlet weak var emailTextView: UITextField!
    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Override Functions
    override func initVariables() {
        userViewModel.nibName = "ForgotPasswordView"
    }
    
    override func initUIViewAndActions() {
        super.initUIViewAndActions()
        
        setupUI()
    }
    
    // joining DetailView.swift and DetailView.xib
    override func getNibName() -> String {
        return userViewModel.nibName
    }
    
    override func initData() {
        // Loading Monitoring
        userViewModel.isLoading.bind{
            if($0) {
                _ = Common.instance.showBarLoading()
            }else {
                _ = Common.instance.hideBarLoading()
            }
        }
        
        userViewModel.postForgotPasswordLiveData.bind{
            
            if let resourse : Resourse<ApiStatus> = $0 {
                
                Common.instance.hideLoading()
                
                if resourse.status == Status.SUCCESS {
                    
                    _ = SweetAlert().showAlert(language.forgotPasswordTitle, subTitle:  resourse.data?.message, style: AlertStyle.success)
                    
                    
                }else if resourse.status == Status.ERROR {
                    print("Error in loading data. Message : " + resourse.message)
                    
                    _ = SweetAlert().showAlert(language.forgotPasswordTitle, subTitle:  resourse.message, style: AlertStyle.error)
                }
            }else {
                print("Something Wrong")
            }
            
        }
        
    }
    @IBAction func submitClicked(_ sender: Any) {
        
        if !Connectivity.isConnected() {
            _ = SweetAlert().showAlert(language.forgotPasswordTitle, subTitle:  language.error_message__no_internet_connection, style: AlertStyle.error)
            
            return
        }
        
        if emailTextView.text != "" {
            
            Common.instance.showLoading()
            
            userViewModel.postForgotPassword(email: emailTextView.text!)
        } else {
            _ = SweetAlert().showAlert(language.forgotPasswordTitle, subTitle:  language.error_message__blank_email, style: AlertStyle.error)
        }
    }
    
    
    @IBAction func loginClicked(_ sender: Any) {
        ps.print("Login Clicked")
        parent?.navigationController?.popViewController(animated: true)
        parent?.dismiss(animated: true, completion: nil)
    }
    
    func setupUI() {
        
        
        guideLabel.font = customFont.normalUIFont
        guideLabel.textColor = configs.colorText
        guideLabel.text = language.forgot__guide
        guideLabel.setLineHeight(height: configs.lineSpacing)
        
        emailLabel.font = customFont.normalBoldUIFont
        emailLabel.textColor = configs.colorText
        emailLabel.text = language.forgot__email
        
        submitButton.setTitleColor(configs.colorTextAlt, for: .normal)
        submitButton.titleLabel?.font = customFont.normalUIFont
        submitButton.backgroundColor = configs.colorPrimary
        submitButton.setTitle(language.forgot__submit, for: .normal)
        
        loginButton.setTitleColor(configs.colorTextAlt, for: .normal)
        loginButton.titleLabel?.font = customFont.tagUIFont
        loginButton.backgroundColor = configs.colorButtonBg
        loginButton.setTitle(language.forgot__login, for: .normal)
        
        emailTextView.font = customFont.normalUIFont
        emailTextView.textColor = configs.colorText
        emailTextView.placeholder = language.forgot__email
        
    }
    
}
