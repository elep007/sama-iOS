//
//  FeatureCollectionViewCell.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/7/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import UIKit

class FeatureCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellWidth: NSLayoutConstraint!
    @IBOutlet weak var featureLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
        
    }

    func setupUI() {
        cellWidth.constant = Common.instance.screenSize.width - 40
        
        // feature
        featureLabel.font = customFont.normalUIFont
        featureLabel.textColor = configs.colorText
        
    }
}
