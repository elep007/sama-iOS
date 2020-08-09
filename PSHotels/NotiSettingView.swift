//
//  NotiSettingView.swift
//  PSHotels
//
//  Created by Panacea-Soft on 10/26/17.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import UIKit

@IBDesignable
class NotiSettingView: PSUIView {
    
    
    // MARK: Custom Variables
    // NibName of View. This variable will use later in getNibName()
    var notiViewModel = NotificationViewModel()
    
    @IBOutlet weak var notiSettingTitleLabel: UILabel!
    @IBOutlet weak var messageTitleLabel: UILabel!
    @IBOutlet weak var notiSwitch: UISwitch!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    // MARK: - Override Functions
    override func initVariables() {
        notiViewModel.nibName = "NotiSettingView"
    }
    
    
    // MARK: - Override Functions
    // joining DetailView.swift and DetailView.xib
    override func getNibName() -> String {
        return notiViewModel.nibName
    }
    
    override func initUIViewAndActions() {
        super.initUIViewAndActions()
        
        setupUI()
    }
    
    override func initData() {
        let prefs = UserDefaults.standard
        
        let isRegister = prefs.string(forKey: notiKey.isRegister)
        
        if(isRegister == notiKey.registered){
            notiSwitch.isOn = true
        }else {
            notiSwitch.isOn = false
        }
        
        let message = prefs.string(forKey: notiKey.notiLatestMessage)
        if message == nil || message == ""{
            messageLabel.text = "-"
        }else {
            messageLabel.text = message
            messageLabel.setLineHeight(height: configs.lineSpacing)
        }
        
        notiViewModel.postNotificationLiveData.bind{ [weak self] in
            
            if let resourse : Resourse<ApiStatus> = $0 {
                
                Common.instance.hideLoading()
                
                if resourse.status == Status.SUCCESS {
                    
                    let prefs = UserDefaults.standard
                    
                    if (self?.notiSwitch.isOn)! {
                        _ = SweetAlert().showAlert(language.notiSettingTitle, subTitle:  language.noti__registerSuccess, style: AlertStyle.success)
                        prefs.set(notiKey.registered, forKey: notiKey.isRegister)
                    }else {
                        _ = SweetAlert().showAlert(language.notiSettingTitle, subTitle:  language.noti__unregisterSuccess, style: AlertStyle.success)
                        prefs.set(notiKey.unRegister, forKey: notiKey.isRegister)
                    }
                    
                    
                }else if resourse.status == Status.ERROR {
                    print("Error in loading data. Message : " + resourse.message)
                    
                }
            }else {
                print("Something Wrong")
            }
            
        }
    }
    
    var isResetSwitch = false
    
    @IBAction func notiSwtichValueChanged(_ sender: Any) {
        
        if !isResetSwitch {
            let devicePlatform = "IOS"
            let prefs = UserDefaults.standard
            
            let deviceTokenKey = prefs.string(forKey: notiKey.deviceTokenKey)
            
            if deviceTokenKey != nil && deviceTokenKey != "" {
                
                if notiSwitch.isOn {
                    // register notification
                    notiViewModel.postNotification(token: deviceTokenKey!, platform: devicePlatform, isRegister: true)
                }else {
                    
                    // unregister notification
                    notiViewModel.postNotification(token: deviceTokenKey!, platform: devicePlatform, isRegister: false)
                }
            }else {
                print("Error in getting device token id")
                _ = SweetAlert().showAlert(language.notiSettingTitle, subTitle: language.noti__noToken , style: AlertStyle.error)
                
                isResetSwitch = true
                notiSwitch.isOn = !notiSwitch.isOn
            }
        }else {
            isResetSwitch = false
        }
    }
    
    // MARK: Custom Functions
    func setupUI() {
        
        notiSettingTitleLabel.font = customFont.normalUIFont
        notiSettingTitleLabel.textColor = configs.colorText
        notiSettingTitleLabel.text = language.noti__title
        
        messageTitleLabel.font = customFont.normalBoldUIFont
        messageTitleLabel.textColor = configs.colorText
        messageTitleLabel.text = language.noti__messageTitle
        
        messageLabel.font = customFont.normalUIFont
        messageLabel.textColor = configs.colorText
        
        
    }
    
}
