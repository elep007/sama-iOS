//
//  ReviewSummaryCollectionViewCell.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/8/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import UIKit

class ReviewSummaryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    
    @IBOutlet weak var rating1TitleLabel: UILabel!
    @IBOutlet weak var rating1Label: UILabel!
    @IBOutlet weak var rating1ProgressBar: UIProgressView!
    @IBOutlet weak var rating1View: UIView!
    
    @IBOutlet weak var rating2TitleLabel: UILabel!
    @IBOutlet weak var rating2Label: UILabel!
    @IBOutlet weak var rating2ProgressBar: UIProgressView!
    @IBOutlet weak var rating2View: UIView!
    
    @IBOutlet weak var rating3TitleLabel: UILabel!
    @IBOutlet weak var rating3Label: UILabel!
    @IBOutlet weak var rating3ProgressBar: UIProgressView!
    @IBOutlet weak var rating3View: UIView!
    
    @IBOutlet weak var rating4TitleLabel: UILabel!
    @IBOutlet weak var rating4Label: UILabel!
    @IBOutlet weak var rating4ProgressBar: UIProgressView!
    @IBOutlet weak var rating4View: UIView!
    
    @IBOutlet weak var rating5TitleLabel: UILabel!
    @IBOutlet weak var rating5Label: UILabel!
    @IBOutlet weak var rating5ProgressBar: UIProgressView!
    @IBOutlet weak var rating5View: UIView!
    
    
    @IBOutlet weak var cellWidth: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }
    
    func setupUI() {
        
        // Rating
        ratingLabel.font = customFont.normalBoldUIFont
        ratingLabel.textColor = configs.colorPrimary
        
        // Review
        reviewLabel.font = customFont.tagUIFont
        reviewLabel.textColor = configs.colorText
        
        // Rating 1
        rating1TitleLabel.font = customFont.normalUIFont
        rating1Label.font = customFont.normalBoldUIFont
        rating1TitleLabel.textColor = configs.colorText
        rating1Label.textColor = configs.colorPrimary
        
        // Rating 2
        rating2TitleLabel.font = customFont.normalUIFont
        rating2Label.font = customFont.normalBoldUIFont
        rating2TitleLabel.textColor = configs.colorText
        rating2Label.textColor = configs.colorPrimary
        
        // Rating 3
        rating3TitleLabel.font = customFont.normalUIFont
        rating3Label.font = customFont.normalBoldUIFont
        rating3TitleLabel.textColor = configs.colorText
        rating3Label.textColor = configs.colorPrimary
        
        // Rating 4
        rating4TitleLabel.font = customFont.normalUIFont
        rating4Label.font = customFont.normalBoldUIFont
        rating4TitleLabel.textColor = configs.colorText
        rating4Label.textColor = configs.colorPrimary
        
        // Rating 5
        rating5TitleLabel.font = customFont.normalUIFont
        rating5Label.font = customFont.normalBoldUIFont
        rating5TitleLabel.textColor = configs.colorText
        rating5Label.textColor = configs.colorPrimary
        
        
    }

}
