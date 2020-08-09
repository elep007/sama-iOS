//
//  HotelCollectionViewCell.swift
//  PSHotels
//
//  Created by Panacea-Soft on 10/22/17.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import UIKit

class HotelCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var priceRangeLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var guestRatingLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var promotionView: UIView!
    @IBOutlet weak var star1Icon: UIImageView!
    @IBOutlet weak var star2Icon: UIImageView!
    @IBOutlet weak var star3Icon: UIImageView!
    @IBOutlet weak var star4Icon: UIImageView!
    @IBOutlet weak var star5Icon: UIImageView!
    @IBOutlet weak var cellWidth: NSLayoutConstraint!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cellHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }
    
    func setupUI() {
       
        // hotel name
        hotelNameLabel.font = customFont.headerUIFont
        hotelNameLabel.textColor = configs.colorText
        
        // hotel address
        addressLabel.font = customFont.tagUIFont
        addressLabel.textColor = configs.colorText
        
        // guest Rating
        guestRatingLabel.font = customFont.subHeaderUIFont
        guestRatingLabel.textColor = configs.colorPrimary
        
        // review count
        reviewCountLabel.font = customFont.tagUIFont
        reviewCountLabel.textColor = configs.colorTextLight
        
        // price range
        priceRangeLabel.font = customFont.subHeaderBoldUIFont
        priceRangeLabel.textColor = configs.colorPromotion
        
        // percent
        percentLabel.font = customFont.subHeaderBoldUIFont
        percentLabel.textColor = configs.colorWhite
        
        // percent view
        promotionView.backgroundColor = configs.colorPromotion
        
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
