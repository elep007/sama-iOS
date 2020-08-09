//
//  FeatureHeaderCollectionReusableView.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/7/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import UIKit

class FeatureHeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var featureHeaderLabel: UILabel!
    @IBOutlet weak var featureHeaderImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }
    
    func setupUI() {
        
        // feature header
        featureHeaderLabel.font = customFont.normalBoldUIFont
        featureHeaderLabel.textColor = configs.colorText
    }
    
}
