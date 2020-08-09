//
//  ReviewCollectionViewCell.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/8/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellWidth: NSLayoutConstraint!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }
    
    func setupUI() {
        
        // Name
        nameLabel.font = customFont.normalBoldUIFont
        nameLabel.textColor = configs.colorText
        
        // Rating
        ratingLabel.font = customFont.normalUIFont
        ratingLabel.textColor = configs.colorPrimary
        
        // Room Label
        roomLabel.font = customFont.tagUIFont
        roomLabel.textColor = configs.colorText
        
        // Review
        reviewLabel.font = customFont.normalUIFont
        reviewLabel.textColor = configs.colorText
        
        // Date
        dateLabel.font = customFont.tagUIFont
        dateLabel.textColor = configs.colorText
        
    }

}
