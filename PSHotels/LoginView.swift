//
//  LoginView.swift
//  PSHotels
//
//  Created by Panacea-Soft on 10/24/17.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import UIKit

protocol LoginViewDelegate {
    func refreshProfileData()
}

@IBDesignable
class LoginView: PSUIView {

    // MARK: Custom Variables
    var userViewModel : UserViewModel = UserViewModel()
    
    var isHomeView : Bool = true
    var loginViewDelegate : LoginViewDelegate?
    var parent : UserLoginViewController?
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    
    // MARK: - Override Functions
    override func initVariables() {
        userViewModel.nibName = "LoginView"
    }
    
    // joining DetailView.swift and DetailView.xib
    override func getNibName() -> String {
        return userViewModel.nibName
    }
    
    override func initUIViewAndActions() {
        super.initUIViewAndActions()
        
        setupUI()
        
        submitButton.addTarget(self, action: #selector(self.submitLogin), for: .touchUpInside)
        
        // Loading Monitoring
        userViewModel.isLoading.bind{
            if($0) {
                Common.instance.showBarLoading()
                
            }else {
                Common.instance.hideBarLoading()
            }
        }
    }
    
    override func initData() {
        // Load data from PS Server
        userViewModel.postUserLoginLiveData.bind{ [weak self] in
            
            if let userResourse = $0 {
                
                Common.instance.hideLoading()
                
                if userResourse.status == Status.SUCCESS {
                    
                    let user : User = userResourse.data!
                    
                    Common.instance.saveUserInfo(user)
                    
                    print("Login Success" + user.user_name + " " + user.user_id)
                    
                    if (self?.isHomeView)! {
                        PSNavigationController.instance.navigateToProfilePage()
                    }else {
                        self?.refreshProfileData()
                    }
                    
                }else {
                    print("Error in login. Message : " + userResourse.message)
                }
                
            }else {
                print("Submit Login : Something Wrong")
            }
            
        }
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        PSNavigationController.instance.navigateToUserRegister(delegate: self)
        PSNavigationController.instance.updateBackButton()
    }
    
    
    @IBAction func forgotPasswordClicked(_ sender: Any) {
    
        PSNavigationController.instance.navigateToForgotPassword()
        PSNavigationController.instance.updateBackButton()
    
    }
    
    @objc func submitLogin() {
        
        if !Connectivity.isConnected() {
            _ = SweetAlert().showAlert(language.LoginTitle, subTitle:  language.error_message__no_internet_connection, style: AlertStyle.error)
            
            return
        }
        
        if emailTextField.text == "" {
            
            _ = SweetAlert().showAlert(language.LoginTitle, subTitle: language.error_message__blank_username, style: AlertStyle.warning)
            return
        }
        
        if passwordTextField.text == "" {
            _ = SweetAlert().showAlert(language.LoginTitle, subTitle: language.error_message__blank_password, style: AlertStyle.warning)
            return
            
        }
            
        if(Common.instance.isValidEmail(emailTextField.text!)) {
            
            Common.instance.showLoading()
            
            userViewModel.postUserLogin(email: emailTextField.text!, password: passwordTextField.text!)
            
        }
        
        
    }
    
    func setupUI() {
        
        emailLabel.font = customFont.normalBoldUIFont
        emailLabel.textColor = configs.colorText
        emailLabel.text = language.login__email
        
        passwordLabel.font = customFont.normalBoldUIFont
        passwordLabel.textColor = configs.colorText
        passwordLabel.text = language.login__password
        
        submitButton.setTitleColor(configs.colorTextAlt, for: .normal)
        submitButton.titleLabel?.font = customFont.normalUIFont
        submitButton.backgroundColor = configs.colorPrimary
        submitButton.setTitle(language.login__submit, for: .normal)
        
        registerButton.setTitleColor(configs.colorTextAlt, for: .normal)
        registerButton.titleLabel?.font = customFont.tagUIFont
        registerButton.backgroundColor = configs.colorButtonBg
        registerButton.setTitle(language.login__register, for: .normal)
        
        forgotPasswordButton.setTitleColor(configs.colorTextAlt, for: .normal)
        forgotPasswordButton.titleLabel?.font = customFont.tagUIFont
        forgotPasswordButton.backgroundColor = configs.colorButtonBg
        forgotPasswordButton.setTitle(language.login__forgot, for: .normal)
        
        emailTextField.font = customFont.normalUIFont
        emailTextField.textColor = configs.colorText
        emailTextField.placeholder = language.login__email
        
        passwordTextField.font = customFont.normalUIFont
        passwordTextField.textColor = configs.colorText
        passwordTextField.placeholder = language.login__password
    }
    
    func closeView() {
        parent?.navigationController?.popViewController(animated: true)
        parent?.dismiss(animated: true, completion: nil)
    }
}

extension LoginView : RegisterViewDelegate {
    
    func refreshProfileData() {
        if !isHomeView {
            if let delegate = loginViewDelegate {
                parent?.updateMenu()
                self.closeView()
                delegate.refreshProfileData()
            }
        }
    }
    
    
    func openProfilePage() {
        if isHomeView {
            PSNavigationController.instance.navigateToProfilePage()
        }
    }
    
    
    
}
