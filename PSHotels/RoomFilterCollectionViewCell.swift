//
//  RoomFilterCollectionViewCell.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/9/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import UIKit

class RoomFilterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var roomNameLabel: UILabel!
    
    @IBOutlet weak var hotelNameLabel: UILabel!
    
    @IBOutlet weak var roomImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    func setupUI() {
        
        roomNameLabel.font = customFont.normalUIFont
        roomNameLabel.textColor = configs.colorText
        
        hotelNameLabel.font = customFont.tagUIFont
        hotelNameLabel.textColor = configs.colorTextLight
        
    }

}
