//
//  InquiryView.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/14/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

@IBDesignable
class InquiryView: PSUIView {
    
    // MARK: Custom Variables
    var contactUsViewModel = InquiryViewModel()
    
    @IBOutlet weak var contactName: UITextField!
    @IBOutlet weak var contactEmail: UITextField!
    @IBOutlet weak var contactPhone: UITextField!
    @IBOutlet weak var inquiryMessageTextView: UITextView!
    @IBOutlet weak var inquiryTitleTextField: UITextField!
    @IBOutlet weak var contactNameTitleLabel: UILabel!
    @IBOutlet weak var contactEmailTitleLabel: UILabel!
    @IBOutlet weak var contactPhoneTitleLabel: UILabel!
    @IBOutlet weak var inquiryMessageTitleLabel: UILabel!
    @IBOutlet weak var inquiryTitleLabel: UILabel!
    
    let prefs = UserDefaults.standard
    
    @IBOutlet weak var submitButton: UIButton!
    var hotelId: String = ""
    var roomId: String = ""
    var parentView: UIViewController? = nil
    
    // MARK: - Override Functions
    override func initVariables() {
        contactUsViewModel.nibName = "InquiryView"
    }
    
    // MARK: - Override Functions
    // joining InquiryView.swift and InquiryView.xib
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
        
        reloadHistoryOfContact()
        
        contactUsViewModel.postInquiryLiveData.bind{ [weak self] in
            
            if let resourse : Resourse<ApiStatus> = $0 {
                
                Common.instance.hideLoading()
                
                if resourse.status == Status.SUCCESS {
                    
                    _ = SweetAlert().showAlert(language.inquiryTitle, subTitle:  language.message__inquirySuccess, style: AlertStyle.success)
                    
                    self?.closeView()
                    
                }else if resourse.status == Status.ERROR {
                    print("Error in loading data. Message : " + resourse.message)
                    
                    _ = SweetAlert().showAlert(language.inquiryTitle, subTitle:  resourse.message, style: AlertStyle.error)
                }
            }else {
                print("Something Wrong")
            }
            
        }
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        
        if !Connectivity.isConnected() {
            _ = SweetAlert().showAlert(language.inquiryTitle, subTitle:  language.error_message__no_internet_connection, style: AlertStyle.error)
            return
        }
        
        
        if self.contactName.text == "" {
            _ = SweetAlert().showAlert(language.inquiryTitle, subTitle:  language.error_message__blank_contact_name, style: AlertStyle.error)
            return
        }
        
        if self.contactEmail.text == "" {
            _ = SweetAlert().showAlert(language.inquiryTitle, subTitle:  language.error_message__blank_contact_email, style: AlertStyle.error)
            return
        }
        
        if self.contactPhone.text == "" {
            _ = SweetAlert().showAlert(language.inquiryTitle, subTitle:  language.error_message__blank_contact_phone, style: AlertStyle.error)
            return
        }
        
        if self.inquiryTitleTextField.text == "" {
            _ = SweetAlert().showAlert(language.inquiryTitle, subTitle:  language.error_message__blank_title, style: AlertStyle.error)
            return
        }
        
        if self.inquiryMessageTextView.text == "" {
            _ = SweetAlert().showAlert(language.inquiryTitle, subTitle:  language.error_message__blank_message, style: AlertStyle.error)
            return
        }
        
        Common.instance.saveUserContact(name: self.contactName.text!, email: self.contactEmail.text!, phone: self.contactPhone.text!)
        
        Common.instance.showLoading()
        
        let contactName = self.contactName.text!
        let contactEmail = self.contactEmail.text!
        let contactPhone = self.contactPhone.text!
        let title = self.inquiryTitleTextField.text!
        let message = self.inquiryMessageTextView.text!
        
        contactUsViewModel.postInquiry(hotelId: hotelId,
                                       roomId: roomId,
                                       userId: loginUserId,
                                       contactName: contactName,
                                       contactEmail: contactEmail,
                                       contactPhone: contactPhone,
                                       inquiryTitle: title,
                                       inquiryMessage: message)
        
    }
    
    func closeView() {
        parentView?.navigationController?.popViewController(animated: true)
        parentView?.dismiss(animated: true, completion: nil)
    }
    
    func reloadHistoryOfContact() {
        contactName.text = prefs.string(forKey: UserContact.UC_name)
        contactEmail.text = prefs.string(forKey: UserContact.UC_email)
        contactPhone.text = prefs.string(forKey: UserContact.UC_phone)
    }
    
    func setupUI() {
        
        contactNameTitleLabel.font = customFont.normalBoldUIFont
        contactNameTitleLabel.textColor = configs.colorText
        contactNameTitleLabel.text = language.inquiry__name
        
        contactEmailTitleLabel.font = customFont.normalBoldUIFont
        contactEmailTitleLabel.textColor = configs.colorText
        contactEmailTitleLabel.text = language.inquiry__email
        
        contactPhoneTitleLabel.font = customFont.normalBoldUIFont
        contactPhoneTitleLabel.textColor = configs.colorText
        contactPhoneTitleLabel.text = language.inquiry__phone
        
        inquiryTitleLabel.font = customFont.normalBoldUIFont
        inquiryTitleLabel.textColor = configs.colorText
        inquiryTitleLabel.text = language.inquiry__title
        
        inquiryMessageTitleLabel.font = customFont.normalBoldUIFont
        inquiryMessageTitleLabel.textColor = configs.colorText
        inquiryMessageTitleLabel.text = language.inquiry__message
        
        submitButton.setTitleColor(configs.colorTextAlt, for: .normal)
        submitButton.titleLabel?.font = customFont.normalUIFont
        submitButton.backgroundColor = configs.colorPrimary
        submitButton.setTitle(language.inquiry__submit, for: .normal)
        
        contactName.font = customFont.normalUIFont
        contactName.textColor = configs.colorText
        contactName.placeholder = language.inquiry__name
        
        contactEmail.font = customFont.normalUIFont
        contactEmail.textColor = configs.colorText
        contactEmail.placeholder = language.inquiry__email
        
        contactPhone.font = customFont.normalUIFont
        contactPhone.textColor = configs.colorText
        contactPhone.placeholder = language.inquiry__phone
        
        inquiryTitleTextField.font = customFont.normalUIFont
        inquiryTitleTextField.textColor = configs.colorText
        inquiryTitleTextField.placeholder = language.inquiry__title
        
        inquiryMessageTextView.font = customFont.normalUIFont
        inquiryMessageTextView.textColor = configs.colorText
        
        
    }
    
}
