//
//  PasswordChangeView.swift
//  PSHotels
//
//  Created by Panacea-Soft on 2/8/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import UIKit

@IBDesignable
class PasswordChangeView: PSUIView {

    // MARK: Custom Variables
    var userViewModel = UserViewModel()
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: - Override Functions
    override func initVariables() {
        userViewModel.nibName = "PasswordChangeView"
    }
    
    // MARK: - Override Functions
    // joining DetailView.swift and DetailView.xib
    override func getNibName() -> String {
        return userViewModel.nibName
    }
    
    override func initUIViewAndActions() {
        super.initUIViewAndActions()
        
        setupUI()
    }
    
    override func initData() {

        // Loading Monitoring
        userViewModel.isLoading.bind{
            if($0) {
                
                //Start Animation
                Common.instance.showBarLoading()
                
            }else {
                //Stop Animation
                Common.instance.hideBarLoading()
                
            }
        }
        
        userViewModel.updatePasswordLiveData.bind{
            
            if let resourse : Resourse<ApiStatus> = $0 {
                
                Common.instance.hideLoading()
                
                if resourse.status == Status.SUCCESS
                    || resourse.status == Status.LOADING {
                    
                    if let status : ApiStatus = resourse.data {
                        
                        if status.status == "success" {
                            _ = SweetAlert().showAlert(language.passwordChangeTitle, subTitle:  language.message__profile_edit_successful, style: AlertStyle.success)
                        }else {
                            _ = SweetAlert().showAlert(language.passwordChangeTitle, subTitle:  status.message, style: AlertStyle.error)
                        }
                        
                    }
                    
                } else if resourse.status == Status.ERROR {
                    print("Error in loading data. Message : " + resourse.message)
                }
            }else {
                print("Something Wrong")
            }
            
        }
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        if passwordTextField.text == "" {
            _ = SweetAlert().showAlert(language.passwordChangeTitle, subTitle:  language.error_message__blank_password, style: AlertStyle.error)
            return
        }
        
        if confirmPasswordTextField.text == "" {
            _ = SweetAlert().showAlert(language.passwordChangeTitle, subTitle:  language.error_message__blank_confirm_password, style: AlertStyle.error)
            return
        }
        
        if passwordTextField.text != confirmPasswordTextField.text {
            _ = SweetAlert().showAlert(language.passwordChangeTitle, subTitle:  language.error_message__not_same_confirm_password, style: AlertStyle.error)
            return
        }
        
        Common.instance.showLoading()
        
        userViewModel.updatePassword(loginUserId: super.loginUserId, password: passwordTextField.text!)
    }
    
    func setupUI() {
        passwordLabel.font = customFont.normalBoldUIFont
        passwordLabel.textColor = configs.colorText
        passwordLabel.text = language.passwordChange__password
        
        confirmPasswordLabel.font = customFont.normalBoldUIFont
        confirmPasswordLabel.textColor = configs.colorText
        confirmPasswordLabel.text = language.passwordChange__confirmPassword
        
        submitButton.setTitleColor(configs.colorTextAlt, for: .normal)
        submitButton.titleLabel?.font = customFont.normalUIFont
        submitButton.backgroundColor = configs.colorPrimary
        submitButton.setTitle(language.passwordChange__submit, for: .normal)
        
        passwordTextField.font = customFont.normalUIFont
        passwordTextField.textColor = configs.colorText
        passwordTextField.placeholder = language.passwordChange__password
        
        confirmPasswordTextField.font = customFont.normalUIFont
        confirmPasswordTextField.textColor = configs.colorText
        confirmPasswordTextField.placeholder = language.passwordChange__confirmPassword
    }
    
}

