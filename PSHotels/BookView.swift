//
//  BookView.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 5/2/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

@IBDesignable
class BookView: PSUIView {
    
    // MARK: Custom Variables
    var bookingViewModel = BookingViewModel()
    
    @IBOutlet weak var contactNameTitleLabel: UILabel!
    @IBOutlet weak var contactEmailTitleLabel: UILabel!
    @IBOutlet weak var contactPhoneTitleLabel: UILabel!
    @IBOutlet weak var guestTitleLabel: UILabel!
    @IBOutlet weak var adultCountTitleLabel: UILabel!
    @IBOutlet weak var kidTitleLabel: UILabel!
    @IBOutlet weak var extraBedTitleLabel: UILabel!
    @IBOutlet weak var startDateTitleLabel: UILabel!
    @IBOutlet weak var endDateTitleLabel: UILabel!
    @IBOutlet weak var remarkTitleLabel: UILabel!
    
    
    @IBOutlet weak var contactName: UITextField!
    @IBOutlet weak var contactEmail: UITextField!
    @IBOutlet weak var contactPhone: UITextField!
    @IBOutlet weak var adultCountTextField: UITextField!
    @IBOutlet weak var kidCountTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var extraBedCountTextField: UITextField!
    @IBOutlet weak var remarkTextView: UITextView!
    
    var isStartDateisEditing = false
    var isEndDateisEditing = false
    let todayDate : Date = NSDate() as Date
    var startDate : Date = NSDate() as Date
    var endDate : Date = NSDate() as Date
    
    let prefs = UserDefaults.standard
    
    @IBOutlet weak var submitButton: UIButton!
    var hotelId: String = ""
    var roomId: String = ""
    var parentView: UIViewController? = nil
    let timePicker = UIDatePicker()
    
    // MARK: - Override Functions
    override func initVariables() {
        bookingViewModel.nibName = "BookView"
    }
    
    // MARK: - Override Functions
    // joining InquiryView.swift and InquiryView.xib
    override func getNibName() -> String {
        return bookingViewModel.nibName
    }
    
    override func initUIViewAndActions() {
        super.initUIViewAndActions()
        
        startDateTextField.delegate = self
        endDateTextField.delegate = self
        adultCountTextField.delegate = self
        kidCountTextField.delegate = self
        extraBedCountTextField.delegate = self
        remarkTextView.delegate = self
        
        
        setupUI()
        
        initPicker()
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.startDateClicked))
        contactPhoneTitleLabel.addGestureRecognizer(singleTap)
        
        let extraBedTap = UITapGestureRecognizer(target: self, action: #selector(self.needExtraBedClicked))
        extraBedTitleLabel.addGestureRecognizer(extraBedTap)
        
        // Loading Monitoring
        bookingViewModel.isLoading.bind{
            if($0) {
                Common.instance.showBarLoading()
            }else {
                Common.instance.hideBarLoading()
            }
        }
        
    }
    
    override func initData() {
        
        //reloadHistoryOfContact()
        
        bookingViewModel.postBookingLiveData.bind{ [weak self] in
            
            if let resourse : Resourse<Booking> = $0 {
                
                Common.instance.hideLoading()
                
                if resourse.status == Status.SUCCESS {
                    
                    _ = SweetAlert().showAlert(language.bookingTitle, subTitle:  language.message__booking_success, style: AlertStyle.success)
                    
                    self?.closeView()
                    
                }else if resourse.status == Status.ERROR {
                    print("Error in loading data. Message : " + resourse.message)
                    
                    _ = SweetAlert().showAlert(language.bookingTitle, subTitle:  resourse.message, style: AlertStyle.error)
                }
            }else {
                print("Something Wrong")
            }
        }
        
        let userInfo = Common.instance.getBasicUserInfo()
        
        contactName.text = userInfo.userName
        contactEmail.text = userInfo.email
        contactPhone.text = userInfo.phone
    
    }
   
    @IBOutlet weak var checkButton: UIButton!
    @IBAction func checkButtonClicked(_ sender: Any) {
        //checkButton.isSelected = !checkButton.isSelected
        updateExtraBedStatus()
    }
    
    @objc func needExtraBedClicked() {
        updateExtraBedStatus()
    }
    
    func updateExtraBedStatus() {
        checkButton.isSelected = !checkButton.isSelected
        extraBedCountTextField.isEnabled = checkButton.isSelected
    }
    
    
    @IBAction func submitClicked(_ sender: Any) {
        
        if !Connectivity.isConnected() {
            _ = SweetAlert().showAlert(language.bookingTitle, subTitle:  language.error_message__no_internet_connection, style: AlertStyle.error)
            return
        }
        
        if self.contactName.text == "" {
            _ = SweetAlert().showAlert(language.bookingTitle, subTitle:  language.error_message__blank_contact_name, style: AlertStyle.error)
            return
        }
        
        if self.contactEmail.text == "" {
            _ = SweetAlert().showAlert(language.bookingTitle, subTitle:  language.error_message__blank_contact_email, style: AlertStyle.error)
            return
        }
        
        if self.startDateTextField.text == "" {
            _ = SweetAlert().showAlert(language.bookingTitle, subTitle:  language.error_message__blank_start_date, style: AlertStyle.error)
            return
        }
        
        if self.endDateTextField.text == "" {
            _ = SweetAlert().showAlert(language.bookingTitle, subTitle:  language.error_message__blank_end_date, style: AlertStyle.error)
            return
        }
        
        if self.adultCountTextField.text != "" &&
            !(self.adultCountTextField.text?.isNumber)! {
            _ = SweetAlert().showAlert(language.bookingTitle, subTitle:  language.error_message__not_number, style: AlertStyle.error)
            return
        }
        
        if self.kidCountTextField.text != "" &&
            !(self.kidCountTextField.text?.isNumber)! {
            _ = SweetAlert().showAlert(language.bookingTitle, subTitle:  language.error_message__not_number, style: AlertStyle.error)
            return
        }
        
        if self.extraBedCountTextField.text != "" &&
            !(self.extraBedCountTextField.text?.isNumber)! {
            _ = SweetAlert().showAlert(language.bookingTitle, subTitle:  language.error_message__not_number, style: AlertStyle.error)
            return
        }
        
        if self.adultCountTextField.text == "" {
            self.adultCountTextField.text = "0"
        }
        
        if self.kidCountTextField.text == "" {
            self.kidCountTextField.text = "0"
        }
        
        if self.extraBedCountTextField.text == "" {
            self.extraBedCountTextField.text = "0"
        }
        
        Common.instance.saveUserContact(name: self.contactName.text!, email: self.contactEmail.text!, phone: self.contactPhone.text!)
        
        Common.instance.showLoading()
        
        let contactName = self.contactName.text!
        let contactEmail = self.contactEmail.text!
        let contactPhone = self.contactPhone.text!
        let startDate = self.startDateTextField.text!
        let endDate = self.endDateTextField.text!
        let adultCount = self.adultCountTextField.text!
        let kidCount = self.kidCountTextField.text!
        let extraBedCount = self.extraBedCountTextField.text!
        let remark = self.remarkTextView.text!
        
        bookingViewModel.postBooking(loginUserId: self.loginUserId,
                                       userName: contactName,
                                       userEmail: contactEmail,
                                       userPhone : contactPhone,
                                       hotelId : self.hotelId,
                                       roomId : self.roomId,
                                       adultCount : adultCount,
                                       kidCount : kidCount,
                                       startDate : startDate,
                                       endDate : endDate,
                                       extraBed : extraBedCount,
                                       remark : remark)
        
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
        contactNameTitleLabel.text = language.booking__name
        
        contactEmailTitleLabel.font = customFont.normalBoldUIFont
        contactEmailTitleLabel.textColor = configs.colorText
        contactEmailTitleLabel.text = language.booking__email
        
        contactPhoneTitleLabel.font = customFont.normalBoldUIFont
        contactPhoneTitleLabel.textColor = configs.colorText
        contactPhoneTitleLabel.text = language.booking__phone
        
        guestTitleLabel.font = customFont.normalBoldUIFont
        guestTitleLabel.textColor = configs.colorText
        guestTitleLabel.text = language.booking__guestCount
        
        adultCountTitleLabel.font = customFont.normalBoldUIFont
        adultCountTitleLabel.textColor = configs.colorText
        adultCountTitleLabel.text = language.booking__adultCount
        
        kidTitleLabel.font = customFont.normalBoldUIFont
        kidTitleLabel.textColor = configs.colorText
        kidTitleLabel.text = language.booking__kidCount
        
        extraBedTitleLabel.font = customFont.normalBoldUIFont
        extraBedTitleLabel.textColor = configs.colorText
        extraBedTitleLabel.text = language.booking__extraBeds
        
        startDateTitleLabel.font = customFont.normalBoldUIFont
        startDateTitleLabel.textColor = configs.colorText
        startDateTitleLabel.text = language.booking__startDate
        
        endDateTitleLabel.font = customFont.normalBoldUIFont
        endDateTitleLabel.textColor = configs.colorText
        endDateTitleLabel.text = language.booking__endDate
        
        remarkTitleLabel.font = customFont.normalBoldUIFont
        remarkTitleLabel.textColor = configs.colorText
        remarkTitleLabel.text = language.booking__remark
        
        submitButton.setTitleColor(configs.colorTextAlt, for: .normal)
        submitButton.titleLabel?.font = customFont.normalUIFont
        submitButton.backgroundColor = configs.colorPrimary
        submitButton.setTitle(language.booking__submit, for: .normal)
        
        contactName.font = customFont.normalUIFont
        contactName.textColor = configs.colorText
        contactName.placeholder = language.booking__name
        
        contactEmail.font = customFont.normalUIFont
        contactEmail.textColor = configs.colorText
        contactEmail.placeholder = language.booking__email
        
        contactPhone.font = customFont.normalUIFont
        contactPhone.textColor = configs.colorText
        contactPhone.placeholder = language.booking__phone
     
        adultCountTextField.font = customFont.normalUIFont
        adultCountTextField.textColor = configs.colorText
        adultCountTextField.placeholder = language.booking__0Count
        
        kidCountTextField.font = customFont.normalUIFont
        kidCountTextField.textColor = configs.colorText
        kidCountTextField.placeholder = language.booking__0Count
        
        startDateTextField.font = customFont.normalUIFont
        startDateTextField.textColor = configs.colorText
        
        endDateTextField.font = customFont.normalUIFont
        endDateTextField.textColor = configs.colorText
        
        extraBedCountTextField.font = customFont.normalUIFont
        extraBedCountTextField.textColor = configs.colorText
        extraBedCountTextField.placeholder = language.booking__0Count
        
        remarkTextView.font = customFont.normalUIFont
        remarkTextView.textColor = configs.colorText
        
    }
    
    @objc func startDateClicked() {
        openTimePicker()
    }
    
    
    
    
    func openTimePicker()  {
        timePicker.datePickerMode = UIDatePicker.Mode.date
        timePicker.frame = CGRect(x: 0.0, y: (self.view.frame.height/2 + 60), width: self.view.frame.width, height: 150.0)
        timePicker.backgroundColor = UIColor.white
        self.view.addSubview(timePicker)
        timePicker.addTarget(self, action: #selector(startTimeDiveChanged), for: UIControl.Event.valueChanged)
    }
    
    @objc func startTimeDiveChanged(sender: UIDatePicker) {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .short
//        contactPhoneTitleLabel.text = formatter.string(from: sender.date)
        
//        let dateFormatterPrint = NSDateFormatter()
//        dateFormatterPrint.dateFormat = "yyyy-mm-dd"
//        contactPhoneTitleLabel.text = dateFormatterPrint.stringFromDate(date!)
        timePicker.removeFromSuperview() // if you want to remove time picker
    }
    
    func initPicker() {
        
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = UIDatePicker.Mode.date
        
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        
        startDateTextField.inputView = datePicker
        endDateTextField.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        
        toolbar.barStyle = UIBarStyle.blackTranslucent
        
        toolbar.tintColor = UIColor.white
        
        let todayButton = UIBarButtonItem(title: "Today", style: UIBarButtonItem.Style.plain, target: self, action: #selector(todayPressed(sender:)))
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(donePressed(sender:)))
        
        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/3, height: 40))
        
        label.font = UIFont.systemFont(ofSize: 14)
        
        label.textColor = UIColor.yellow
        
        label.textAlignment = NSTextAlignment.center
        
        label.text = "Select a Date"
        
        let labelButton = UIBarButtonItem(customView: label)
        
        toolbar.setItems([todayButton, flexButton, labelButton, flexButton, doneButton], animated: true)
        
        startDateTextField.inputAccessoryView = toolbar
        endDateTextField.inputAccessoryView = toolbar
    }
    
    
    @objc func donePressed(sender: UIBarButtonItem) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if(isStartDateisEditing) {
            
            if todayDate <= startDate  {
                startDateTextField.text = formatter.string(from: startDate)
                endDateTextField.text = ""
            }else {
                startDateTextField.text = ""
                endDateTextField.text = ""
                print("Start date error")
                _ = SweetAlert().showAlert(language.bookingTitle, subTitle:  language.error_message__invalid_date, style: AlertStyle.error)
            }
            
            startDateTextField.resignFirstResponder()
        }else {
            
            if startDate <= endDate {
                endDateTextField.text = formatter.string(from: endDate)
            }else {
                endDateTextField.text = ""
                print("End date error")
                _ = SweetAlert().showAlert(language.bookingTitle, subTitle:  language.error_message__invalid_date, style: AlertStyle.error)
            }
            
            endDateTextField.resignFirstResponder()
        }
        
    }
    
    @objc func todayPressed(sender: UIBarButtonItem) {
        
        let formatter = DateFormatter()
        
        //formatter.dateStyle = DateFormatter.Style.medium
        
        //formatter.timeStyle = DateFormatter.Style.none
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        if(isStartDateisEditing) {
        
        startDateTextField.text = formatter.string(from: NSDate() as Date)
        
        startDateTextField.resignFirstResponder()
        }else {
            endDateTextField.text = formatter.string(from: NSDate() as Date)
            
            endDateTextField.resignFirstResponder()
        }
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        
//        formatter.dateStyle = DateFormatter.Style.medium
//
//        formatter.timeStyle = DateFormatter.Style.none
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        if(isStartDateisEditing) {
            startDateTextField.text = formatter.string(from: sender.date)
            startDate = sender.date
            
            
        }else {
            endDateTextField.text = formatter.string(from: sender.date)
            endDate = sender.date
            
            
        }
        
        
        
    }
    
}

extension BookView : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.view.frame.origin.y -= 280
        print("TextView -280")
        
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView)  {
        self.view.frame.origin.y += 280
        print("TextView +280")
        
    }
}

extension BookView : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.view.frame.origin.y -= 165
        print("TextField -165")
        
        if startDateTextField.isEditing {
            print("Start Date TextField is Editing")
            
        }else if endDateTextField.isEditing {
            print("End Date TextField is Editing")
        }
        
        isStartDateisEditing = startDateTextField.isEditing
        isEndDateisEditing = endDateTextField.isEditing
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.view.frame.origin.y += 165
        print("TextField +165")
        
        if startDateTextField.isEditing {
            print("Start Date TextField is End Editing")
        }else if endDateTextField.isEditing {
            print("End Date TextField is End Editing")
        }
        
        isStartDateisEditing = startDateTextField.isEditing
        isEndDateisEditing = endDateTextField.isEditing
        
        return true
    }
}

