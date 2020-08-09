//
//  ContactUsView.swift
//  PSHotels
//
//  Created by Panacea-Soft on 10/26/17.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import UIKit

@IBDesignable
class ContactUsView: PSUIView {
    
    // MARK: Custom Variables
    var contactUsViewModel = ContactUsViewModel()
    
    @IBOutlet weak var contactName: UITextField!
    @IBOutlet weak var contactEmail: UITextField!
    @IBOutlet weak var contactPhone: UITextField!
    @IBOutlet weak var contactMessage: UITextView!
    @IBOutlet weak var contactNameTitleLabel: UILabel!
    @IBOutlet weak var contactEmailTitleLabel: UILabel!
    @IBOutlet weak var contactPhoneTitleLabel: UILabel!
    @IBOutlet weak var contactMessageTitleLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    
    
    // MARK: - Override Functions
    override func initVariables() {
        contactUsViewModel.nibName = "ContactUsView"
    }
    
    // MARK: - Override Functions
    // joining ContactUsView.swift and ContactUsView.xib
    override func getNibName() -> String {
        return contactUsViewModel.nibName
    }
    
    override func initUIViewAndActions() {
        super.initUIViewAndActions()
        
        setupUI()
        
        // Loading Monitoring
        contactUsViewModel.isLoading.bind{
            if($0) {
                Common.instance.showBarLoading()
            }else {
                Common.instance.hideBarLoading()
            }
        }
        
    }
    
    override func initData() {
        
        
        contactUsViewModel.postContactUsLiveData.bind{ [weak self] in
            
            if let resourse : Resourse<ApiStatus> = $0 {
                
                Common.instance.hideLoading()
                
                if resourse.status == Status.SUCCESS {
                    
                    _ = SweetAlert().showAlert(language.contactUsTitle, subTitle:  resourse.data?.message, style: AlertStyle.success)
                    
                    self?.contactMessage.text = ""
                    
                    
                }else if resourse.status == Status.ERROR {
                    print("Error in loading data. Message : " + resourse.message)
                    
                    _ = SweetAlert().showAlert(language.contactUsTitle, subTitle:  resourse.message, style: AlertStyle.error)
                }
            }else {
                print("Something Wrong")
            }
            
        }
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        
        if !Connectivity.isConnected() {
            _ = SweetAlert().showAlert(language.contactUsTitle, subTitle:  language.error_message__no_internet_connection, style: AlertStyle.error)
            return
        }
        
        
        if self.contactName.text == "" {
            _ = SweetAlert().showAlert(language.contactUsTitle, subTitle:  language.error_message__blank_contact_name, style: AlertStyle.error)
            return
        }
        
        if self.contactEmail.text == "" {
            _ = SweetAlert().showAlert(language.contactUsTitle, subTitle:  language.error_message__blank_contact_email, style: AlertStyle.error)
            return
        }
        
        if self.contactMessage.text == "" {
            _ = SweetAlert().showAlert(language.contactUsTitle, subTitle:  language.error_message__blank_message, style: AlertStyle.error)
            return
        }
        
        
        Common.instance.showLoading()
        
        let contactName = self.contactName.text
        let contactEmail = self.contactEmail.text
        let contactPhone = self.contactPhone.text
        let contactMessage = self.contactMessage.text
        
        contactUsViewModel.postContactUs(contactName: contactName!, contactEmail: contactEmail!, contactPhone: contactPhone!, contactMessage: contactMessage!)
        
    }
    
    
    func setupUI() {
        
        contactNameTitleLabel.font = customFont.normalBoldUIFont
        contactNameTitleLabel.textColor = configs.colorText
        contactNameTitleLabel.text = language.contactUs__name
        
        contactEmailTitleLabel.font = customFont.normalBoldUIFont
        contactEmailTitleLabel.textColor = configs.colorText
        contactEmailTitleLabel.text = language.contactUs__email
        
        contactPhoneTitleLabel.font = customFont.normalBoldUIFont
        contactPhoneTitleLabel.textColor = configs.colorText
        contactPhoneTitleLabel.text = language.contactUs__phone
        
        contactMessageTitleLabel.font = customFont.normalBoldUIFont
        contactMessageTitleLabel.textColor = configs.colorText
        contactMessageTitleLabel.text = language.contactUs__message
        
        submitButton.setTitleColor(configs.colorTextAlt, for: .normal)
        submitButton.titleLabel?.font = customFont.normalUIFont
        submitButton.backgroundColor = configs.colorPrimary
        submitButton.setTitle(language.contactUs__submit, for: .normal)
        
        contactName.font = customFont.normalUIFont
        contactName.textColor = configs.colorText
        contactName.placeholder = language.contactUs__name
        
        contactEmail.font = customFont.normalUIFont
        contactEmail.textColor = configs.colorText
        contactEmail.placeholder = language.contactUs__email
        
        contactPhone.font = customFont.normalUIFont
        contactPhone.textColor = configs.colorText
        contactPhone.placeholder = language.contactUs__phone
        
        contactMessage.font = customFont.normalUIFont
        contactMessage.textColor = configs.colorText
        
        
    }
    
    
    
    
}
