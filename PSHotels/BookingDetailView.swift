//
//  BookingDetailView.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 5/4/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import UIKit

@IBDesignable
class BookingDetailView: PSUIView{

    // MARK: Custom Variables
    var userViewModel : UserViewModel = UserViewModel()
    var bookingData: Booking? = nil
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var startDayLabel: UILabel!
    @IBOutlet weak var startMonthLabel: UILabel!
    @IBOutlet weak var startYearLabel: UILabel!
    @IBOutlet weak var endDayLabel: UILabel!
    @IBOutlet weak var endMonthLabel: UILabel!
    @IBOutlet weak var endYearLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var hotelContactInfoLabel: UILabel!
    @IBOutlet weak var bookingInfoLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var bookingEmailLabel: UILabel!
    @IBOutlet weak var bookingPhoneLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var extraBedLabel: UILabel!
    @IBOutlet weak var remarkLabel: UILabel!
    
    
    // MARK: - Override Functions
    override func initVariables() {
        userViewModel.nibName = "BookingDetailView"
    }
    
    // MARK: - Override Functions
    // joining DetailView.swift and DetailView.xib
    override func getNibName() -> String {
        return userViewModel.nibName
    }
    
    override func initUIViewAndActions() {
        super.initUIViewAndActions()
        
        //setup ui
        setupUI()
    }
    
    override func initData() {
        
        if let booking = bookingData {
            
            hotelNameLabel.text = booking.hotel.hotel_name
            hotelNameLabel.setLineHeight(height: configs.lineSpacing)
            
            roomNameLabel.text = booking.room.room_name
            roomNameLabel.setLineHeight(height: configs.lineSpacing)
            
            let startDateAndTime = booking.booking_start_date
            let endDateAndTime = booking.booking_end_date
            
            let startDate = convertDate(dateAndTime: startDateAndTime)
            let endDate = convertDate(dateAndTime: endDateAndTime)
            
            startDayLabel.text = startDate.day
            startMonthLabel.text = startDate.month
            startYearLabel.text = startDate.year
            
            endDayLabel.text = endDate.day
            endMonthLabel.text = endDate.month
            endYearLabel.text = endDate.year
            
            let imageURL = configs.imageUrl + booking.hotel.default_photo.img_path
            
            hotelImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "PlaceholderImage"))
            
            statusLabel.text = booking.booking_status
            
            if(booking.booking_status == "CANCELLED") {
                statusLabel.textColor = configs.colorCancel
            }else if(booking.booking_status == "CONFIRMED") {
                statusLabel.textColor = configs.colorConfirm
            }else {
                statusLabel.textColor = configs.colorTextLight
            }
            
            // Hotel Info
            phoneLabel.text = booking.hotel.hotel_phone
            emailLabel.text = booking.hotel.hotel_email
            addressLabel.text = booking.hotel.hotel_address
            
            
            // Booking Info
            userNameLabel.text = booking.booking_user_name
            bookingEmailLabel.text = booking.booking_user_email
            
            if booking.booking_user_phone != "" {
                bookingPhoneLabel.text = booking.booking_user_phone
            }else {
                bookingPhoneLabel.text = " - "
            }
            
            countLabel.text = booking.booking_adult_count + " Adult" + " " + booking.booking_kid_count + " Kids "
            extraBedLabel.text = booking.booking_extra_bed + " Extra beds"
            remarkLabel.text = booking.booking_remark
            
            
            
            
        }
    }
    
    //MARK: Custom Functions
    
    func convertDate(dateAndTime : String) -> (day: String, month: String, year: String) {
        var date : [String.SubSequence] = []
        if(dateAndTime != "") {
            date = dateAndTime.split(separator: " ")
        }
        
        var dateArr : [String.SubSequence]=[]
        var day = "00"
        var month = "00"
        var year = "0000"
        
        if date.count > 0 {
            
            if(String(date[0]) != "" ) {
                print(String(date[0]))
                dateArr = String(date[0]).split(separator: "-")
            }
            
            if(dateArr.count > 2) {
                day = String(dateArr[2])
            }
            
            if(dateArr.count > 1 ) {
                month = String(dateArr[1])
            }
            
            if(dateArr.count > 0 ) {
                year = String(dateArr[0])
            }
            
        }
        
        return (day, month, year)
    }
    
    func setupUI() {
        
        // hotel name
        hotelNameLabel.font = customFont.headerUIFont
        hotelNameLabel.textColor = configs.colorText
        
        // room name
        roomNameLabel.font = customFont.normalUIFont
        roomNameLabel.textColor = configs.colorText
        
        // start date
        startDayLabel.font = customFont.bookingDayUIFont
        startDayLabel.textColor = configs.colorText
        startMonthLabel.font = customFont.tagUIFont
        startMonthLabel.textColor = configs.colorText
        startYearLabel.font = customFont.tagUIFont
        startMonthLabel.textColor = configs.colorText
        
        // end date
        endDayLabel.font = customFont.bookingDayUIFont
        endDayLabel.textColor = configs.colorText
        endMonthLabel.font = customFont.tagUIFont
        endMonthLabel.textColor = configs.colorText
        endYearLabel.font = customFont.tagUIFont
        endYearLabel.textColor = configs.colorText
        
        // status
        statusLabel.font = customFont.normalBoldUIFont
        statusLabel.textColor = configs.colorTextLight
        
        // title
        hotelContactInfoLabel.font = customFont.subHeaderUIFont
        hotelContactInfoLabel.textColor = configs.colorText
        bookingInfoLabel.font = customFont.subHeaderUIFont
        bookingInfoLabel.textColor = configs.colorText
        
        // hotel info
        phoneLabel.font = customFont.normalUIFont
        phoneLabel.textColor = configs.colorPrimary
        
        emailLabel.font = customFont.normalUIFont
        emailLabel.textColor = configs.colorText
        
        addressLabel.font = customFont.normalUIFont
        addressLabel.textColor = configs.colorText
        
        // booking info
        userNameLabel.font = customFont.normalUIFont
        userNameLabel.textColor = configs.colorText
        
        bookingEmailLabel.font = customFont.normalUIFont
        bookingEmailLabel.textColor = configs.colorText
        
        bookingPhoneLabel.font = customFont.normalUIFont
        bookingPhoneLabel.textColor = configs.colorText
        
        countLabel.font = customFont.normalUIFont
        countLabel.textColor = configs.colorText
        
        extraBedLabel.font = customFont.normalUIFont
        extraBedLabel.textColor = configs.colorText
        
        remarkLabel.font = customFont.normalUIFont
        remarkLabel.textColor = configs.colorText
        
        
    }
    
    
    //MARK: Actions
    
}













