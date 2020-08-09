//
//  HotelHeaderCollectionViewCell.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/24/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import UIKit
import HTagView

class HotelHeaderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewDetailButton: UIButton!
    @IBOutlet weak var hotelTag: HTagView!
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var guestRatingLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var favImageView: UIImageView!
    @IBOutlet weak var favContainerView: UIView!
    @IBOutlet weak var inquiryButton: UIButton!
    @IBOutlet weak var viewHotelDetailButton: UIButton!
    @IBOutlet weak var star1Icon: UIImageView!
    @IBOutlet weak var star2Icon: UIImageView!
    @IBOutlet weak var star3Icon: UIImageView!
    @IBOutlet weak var star4Icon: UIImageView!
    @IBOutlet weak var star5Icon: UIImageView!
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var roomsTitleLabel: UILabel!
    @IBOutlet weak var cellWidth: NSLayoutConstraint!
    
    var hotelData: Hotel? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
      
    }
    
    func setupUI() {
        
        // hotel name
        hotelNameLabel.font = customFont.headerUIFont
        hotelNameLabel.textColor = configs.colorText
        
        // Rooms Title Label
        roomsTitleLabel.font = customFont.subHeaderUIFont
        roomsTitleLabel.textColor = configs.colorText
        roomsTitleLabel.text = language.hotel__rooms
        
        // hotel address
        addressLabel.font = customFont.tagUIFont
        addressLabel.textColor = configs.colorText
        
        // guest Rating
        guestRatingLabel.font = customFont.tagUIFont
        guestRatingLabel.textColor = configs.colorPrimary
        
        // review count
        reviewCountLabel.font = customFont.tagUIFont
        reviewCountLabel.textColor = configs.colorTextLight
        
        // inquiry
        inquiryButton.setTitle(language.hotel__inquiry, for: .normal)
        
        
        viewDetailButton.setTitleColor(configs.colorTextAlt, for: .normal)
        viewDetailButton.titleLabel?.font = customFont.normalUIFont
        viewDetailButton.backgroundColor = configs.colorPrimary
        viewDetailButton.borderColor = configs.colorPrimary
        
    }
    
    @IBAction func inquiryClicked(_ sender: Any) {
        PSNavigationController.instance.navigateToInquiry(hotelId: (hotelData?.hotel_id)!, roomId: "")
        PSNavigationController.instance.updateBackButton()
    }
    
    func showStar(_ starCount: Int ) {
        
        star1Icon.isHidden = true
        star2Icon.isHidden = true
        star3Icon.isHidden = true
        star4Icon.isHidden = true
        star5Icon.isHidden = true
        
        if starCount >= 1 {
            star1Icon.isHidden = false
        }
        
        if starCount >= 2 {
            star2Icon.isHidden = false
        }
        
        if starCount >= 3 {
            star3Icon.isHidden = false
        }
        
        if starCount >= 4 {
            star4Icon.isHidden = false
        }
        
        if starCount >= 5 {
            star5Icon.isHidden = false
        }
    }
}


