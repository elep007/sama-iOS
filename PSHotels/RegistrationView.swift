//
//  RegistrationView.swift
//  PSHotels
//
//  Created by Panacea-Soft on 10/25/17.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import UIKit

// MARK: Protocols
@objc protocol RegisterViewDelegate: class {
    func openProfilePage()
    func refreshProfileData()
}

@IBDesignable
class RegistrationView: PSUIView {

    
    // MARK: Custom Variables
    // NibName of View. This variable will use later in getNibName()
    var parent: UserRegisterViewController?
    var userViewModel = UserViewModel()
    var delegate: RegisterViewDelegate?
    
    @IBOutlet weak var usernameTextView: UITextField!
    @IBOutlet weak var emailTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Override Functions
    override func initVariables() {
        userViewModel.nibName = "RegistrationView"
    }
    
    override func initUIViewAndActions() {
        super.initUIViewAndActions()
        
        setupUI()
    }
    
    // MARK: - Override Functions
    // joining DetailView.swift and DetailView.xib
    override func getNibName() -> String {
        return userViewModel.nibName
    }
    
    override func initData() {
        // Load data from PS Server
        // Loading Monitoring
        userViewModel.isLoading.bind{
            if($0) {
                _ = Common.instance.showBarLoading()
            }else {
                _ = Common.instance.hideBarLoading()
            }
        }
        
        userViewModel.postRegisterUserLiveData.bind{ [weak self] in
            
            if let resourse : Resourse<User> = $0 {
                
                Common.instance.hideLoading()
                
                if resourse.status == Status.SUCCESS {
                    
                    let user : User = resourse.data!
                    
                    Common.instance.saveUserInfo(user)
                    
                    _ = SweetAlert().showAlert(language.registerTitle, subTitle:  language.message__registerSuccess, style: AlertStyle.success)
                    
                    self?.delegate?.openProfilePage()
                    self?.delegate?.refreshProfileData()
                    
                    self?.closeView()
                    
                }else if resourse.status == Status.ERROR {
                    print("Error in loading data. Message : " + resourse.message)
                    
                    _ = SweetAlert().showAlert(language.registerTitle, subTitle:  resourse.message, style: AlertStyle.error)
                }
            }else {
                print("Something Wrong")
            }
            
        }
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        ps.print("Login Clicked")
        closeView()
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        
        if !Connectivity.isConnected() {
            _ = SweetAlert().showAlert(language.registerTitle, subTitle:  language.error_message__no_internet_connection, style: AlertStyle.error)
            
            return
        }
        
        if usernameTextView.text == "" {
            _ = SweetAlert().showAlert(language.registerTitle, subTitle:  language.error_message__blank_username, style: AlertStyle.error)
            return
        }
        
        if emailTextView.text == "" {
            _ = SweetAlert().showAlert(language.registerTitle, subTitle:  language.error_message__blank_email, style: AlertStyle.error)
            return
        }
        
        if passwordTextView.text == "" {
            _ = SweetAlert().showAlert(language.registerTitle, subTitle:  language.error_message__blank_password, style: AlertStyle.error)
            return
        }
        
        Common.instance.showLoading()
        
        userViewModel.postRegisterUser(userName: usernameTextView.text!, email: emailTextView.text!, password: passwordTextView.text!)
        
    }
    
    func setupUI() {
        
        emailLabel.font = customFont.normalBoldUIFont
        emailLabel.textColor = configs.colorText
        emailLabel.text = language.register__email
        
        userNameLabel.font = customFont.normalBoldUIFont
        userNameLabel.textColor = configs.colorText
        userNameLabel.text = language.register__userName
        
        passwordLabel.font = customFont.normalBoldUIFont
        passwordLabel.textColor = configs.colorText
        passwordLabel.text = language.register__password
        
        submitButton.setTitleColor(configs.colorTextAlt, for: .normal)
        submitButton.titleLabel?.font = customFont.normalUIFont
        submitButton.backgroundColor = configs.colorPrimary
        submitButton.setTitle(language.login__submit, for: .normal)
        
        loginButton.setTitleColor(configs.colorTextAlt, for: .normal)
        loginButton.titleLabel?.font = customFont.tagUIFont
        loginButton.backgroundColor = configs.colorButtonBg
        loginButton.setTitle(language.register__login, for: .normal)
        
        usernameTextView.font = customFont.normalUIFont
        usernameTextView.textColor = configs.colorText
        usernameTextView.placeholder = language.register__userName
        
        emailTextView.font = customFont.normalUIFont
        emailTextView.textColor = configs.colorText
        emailTextView.placeholder = language.register__email
        
        passwordTextView.font = customFont.normalUIFont
        passwordTextView.textColor = configs.colorText
        passwordTextView.placeholder = language.register__password
    }
    
    func closeView() {
        parent?.navigationController?.popViewController(animated: true)
        parent?.dismiss(animated: true, completion: nil)
    }
    
    
}

