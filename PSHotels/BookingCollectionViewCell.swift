//
//  BookingCollectionViewCell.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 5/4/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import UIKit

class BookingCollectionViewCell: UICollectionViewCell {

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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
        
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
        statusLabel.font = customFont.subHeaderUIFont
        statusLabel.textColor = configs.colorTextLight
        
    }
        
        
}

