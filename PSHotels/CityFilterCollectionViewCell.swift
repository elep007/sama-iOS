//
//  CityFilterCollectionViewCell.swift
//  PSHotels
//
//  Created by Panacea-Soft on 10/31/17.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import UIKit

class CityFilterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }
    
    func setupUI() {
        
        titleLabel.font = customFont.normalUIFont
        titleLabel.textColor = configs.colorText
        
        countryLabel.font = customFont.tagUIFont
        countryLabel.textColor = configs.colorTextLight
        
    }

}
