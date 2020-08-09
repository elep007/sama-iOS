//
//  SearchFilterView.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/22/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
import SwiftRangeSlider

//MARK: Protocols
protocol SearchFilterProtocol: class {
    func selectFilter(hotelStars: String, lowerPrice: String, upperPrice: String, guestRating: String )
}

@IBDesignable
class SearchFilterView : PSUIView {
    
    
    @IBOutlet weak var star1View: UIView!
    @IBOutlet weak var star2View: UIView!
    @IBOutlet weak var star3View: UIView!
    @IBOutlet weak var star4View: UIView!
    @IBOutlet weak var star5View: UIView!
    @IBOutlet weak var star1Label: UILabel!
    @IBOutlet weak var star1StarImage: UIImageView!
    @IBOutlet weak var star2Label: UILabel!
    @IBOutlet weak var star3Label: UILabel!
    @IBOutlet weak var star4Label: UILabel!
    @IBOutlet weak var star5Label: UILabel!
    @IBOutlet weak var star2StarImage: UIImageView!
    @IBOutlet weak var star3StarImage: UIImageView!
    @IBOutlet weak var star4StarImage: UIImageView!
    @IBOutlet weak var star5StarImage: UIImageView!
    @IBOutlet weak var priceRangeSlider: RangeSlider!
    @IBOutlet weak var lowerPriceLabel: UILabel!
    @IBOutlet weak var higherPriceLabel: UILabel!
    @IBOutlet weak var hotelStarRatingLabel: UILabel!
    @IBOutlet weak var guestRatingLabel: UILabel!
    @IBOutlet weak var priceTitleLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var guestRatingSlider: UISlider!
    
    var delegate : SearchFilterProtocol? = nil
    var parent : UIViewController? = nil
    
    var maxPrice : Price? = nil
    
    var maxValue : Double = 5000 {
        didSet {
            priceRangeSlider.maximumValue = maxValue
            
            if upperPrice == "" {
                
                setupPriceRange(lowerPrice: 0, upperPrice: maxValue, isValueChange: true)
                
            }
        }
    }
    let priceViewModel = PriceViewModel()
    
    
    var hotelStarStr : String = ""
    var lowerPrice : String = ""
    var upperPrice : String = ""
    var guestRating : String = ""
    
    
    var star1IsSelect : Bool = false
    var star2IsSelect : Bool = false
    var star3IsSelect : Bool = false
    var star4IsSelect : Bool = false
    var star5IsSelect : Bool = false
    
    
    // MARK: - Override Functions
    
    override func initVariables() {
        priceViewModel.nibName = "SearchFilterView"
    }
    
    override func getNibName() -> String {
        return priceViewModel.nibName
    }
 
    override func initUIViewAndActions() {
        let star1Tap = UITapGestureRecognizer(target: self, action: #selector(SearchFilterView.clickedStar1View))
        star1View.addGestureRecognizer(star1Tap)
        
        let star2Tap = UITapGestureRecognizer(target: self, action: #selector(SearchFilterView.clickedStar2View))
        star2View.addGestureRecognizer(star2Tap)
        
        let star3Tap = UITapGestureRecognizer(target: self, action: #selector(SearchFilterView.clickedStar3View))
        star3View.addGestureRecognizer(star3Tap)
        
        let star4Tap = UITapGestureRecognizer(target: self, action: #selector(SearchFilterView.clickedStar4View))
        star4View.addGestureRecognizer(star4Tap)
        
        let star5Tap = UITapGestureRecognizer(target: self, action: #selector(SearchFilterView.clickedStar5View))
        star5View.addGestureRecognizer(star5Tap)
        
        
        okButton.setTitleColor(configs.colorTextAlt, for: .normal)
        okButton.titleLabel?.font = customFont.subHeaderUIFont
        okButton.backgroundColor = configs.colorPrimary
        okButton.borderColor = configs.colorPrimary
        
        star1Label.font = customFont.normalUIFont
        star1Label.textColor = configs.colorText
        
        star2Label.font = customFont.normalUIFont
        star2Label.textColor = configs.colorText
        
        star3Label.font = customFont.normalUIFont
        star3Label.textColor = configs.colorText
        
        star4Label.font = customFont.normalUIFont
        star4Label.textColor = configs.colorText
        
        star5Label.font = customFont.normalUIFont
        star5Label.textColor = configs.colorText
        
        priceRangeSlider.addTarget(self, action: #selector(SearchFilterView.priceSliderValueChanged(_:)), for: .valueChanged)
        
        if let price = maxPrice?.max_price {
            setupPriceRange(lowerPrice: 0, upperPrice: Double(price)!, isValueChange: true)
        }
        
        
        // setup Title Labels
        hotelStarRatingLabel.font = customFont.subHeaderUIFont
        hotelStarRatingLabel.textColor = configs.colorText
        hotelStarRatingLabel.text = language.searchFilter__hotelRating
        
        priceTitleLabel.font = customFont.subHeaderUIFont
        priceTitleLabel.textColor = configs.colorText
        priceTitleLabel.text = language.searchFilter__hotelPrice
        
        guestRatingLabel.font = customFont.subHeaderUIFont
        guestRatingLabel.textColor = configs.colorText
        
        lowerPriceLabel.font = customFont.tagUIFont
        lowerPriceLabel.textColor = configs.colorText
        
        higherPriceLabel.font = customFont.tagUIFont
        higherPriceLabel.textColor = configs.colorText
        
    }
    
    override func initData() {
        
        priceViewModel.getPrice()
        
        priceViewModel.pirceLiveData.bind{ [weak self] in
            
            if let resourse : Resourse<Price> = $0 {
                
                if resourse.status == Status.SUCCESS ||
                    resourse.status == Status.LOADING {
                    
                    if let data : Price = resourse.data {
                        if data.max_price != "" {
                            self?.maxValue = Double(data.max_price)!
                        }
                    }
                    
                }else if resourse.status == Status.ERROR {
                    
                    print("1 Error in loading data. Message : " + resourse.message)
                    
                }else {
                    print("Error in loading data. Message : " + resourse.message)
                }
            }else {
                print("Something Wrong")
            }
            
        }
        
        let hotelStarStrArr = hotelStarStr.split{ $0 == "-"}
        if hotelStarStrArr.count > 0 {
            for hotelStarIndex in hotelStarStrArr {
                print("Hotel Star Index \(hotelStarIndex)")
                
                if hotelStarIndex == "1" {
                    clickedStar1View()
                }
                
                if hotelStarIndex == "2" {
                    clickedStar2View()
                }
                
                if hotelStarIndex == "3" {
                    clickedStar3View()
                }
                
                if hotelStarIndex == "4" {
                    clickedStar4View()
                }
                
                if hotelStarIndex == "5" {
                    clickedStar5View()
                }
            }
        }
        
        if lowerPrice != "" && upperPrice != "" {
            setupPriceRange(lowerPrice: Double(lowerPrice)!, upperPrice: Double(upperPrice)!, isValueChange: true)
        }
        
        if guestRating != "" {
            
            setupGuestRating(Float(guestRating)!, isValueChange: true)
            
        }
    }
    
    @objc func priceSliderValueChanged(_ priceSlider: RangeSlider) {
        
        if(priceSlider.lowerValue *   maxValue == 0 &&  priceSlider.upperValue * maxValue == maxValue) {
            
        } else {
            
            setupPriceRange(lowerPrice: priceSlider.lowerValue, upperPrice: priceSlider.upperValue, isValueChange : false)
            
        }
    }
    
    
    @IBAction func guestRatingValueChanged(_ sender: Any) {
        
        print("Guest Rating Change")
        setupGuestRating(guestRatingSlider.value, isValueChange : true)
        
    }
    
    func selectStar(starView : UIView, starLabel : UILabel, starImage : UIImageView ) {
        starView.backgroundColor = configs.colorHightLight
        starLabel.textColor = configs.colorWhite
        starImage.image = UIImage(named: "StarWhite-Icon")
    }
    
    func unselectStar(starView : UIView, starLabel : UILabel, starImage : UIImageView ) {
        starView.backgroundColor = configs.colorWhite
        starLabel.textColor = configs.colorText
        starImage.image = UIImage(named: "Star-Icon")
    }
    
    @objc func clickedStar1View() {
        if star1IsSelect {
            unselectStar(starView: star1View, starLabel: star1Label, starImage: star1StarImage)
            star1IsSelect = false
        }else {
            selectStar(starView: star1View, starLabel: star1Label, starImage: star1StarImage)
            star1IsSelect = true
        }
    }
    
    
    @objc func clickedStar2View() {
        if star2IsSelect {
            unselectStar(starView: star2View, starLabel: star2Label, starImage: star2StarImage)
            star2IsSelect = false
        }else {
            selectStar(starView: star2View, starLabel: star2Label, starImage: star2StarImage)
            star2IsSelect = true
        }
    }
    
    @objc func clickedStar3View() {
        if star3IsSelect {
            unselectStar(starView: star3View, starLabel: star3Label, starImage: star3StarImage)
            star3IsSelect = false
        }else {
            selectStar(starView: star3View, starLabel: star3Label, starImage: star3StarImage)
            star3IsSelect = true
        }
    }
    
    @objc func clickedStar4View() {
        if star4IsSelect {
            unselectStar(starView: star4View, starLabel: star4Label, starImage: star4StarImage)
            star4IsSelect = false
        }else {
            selectStar(starView: star4View, starLabel: star4Label, starImage: star4StarImage)
            star4IsSelect = true
        }
    }
    
    @objc func clickedStar5View() {
        if star5IsSelect {
            unselectStar(starView: star5View, starLabel: star5Label, starImage: star5StarImage)
            star5IsSelect = false
        }else {
            selectStar(starView: star5View, starLabel: star5Label, starImage: star5StarImage)
            star5IsSelect = true
        }
    }
    
    func clearClicked() {
        
        setupPriceRange(lowerPrice: 0, upperPrice: priceRangeSlider.maximumValue, isValueChange: true)
        
        setupGuestRating(0, isValueChange: true)
        
        unselectStar(starView: star1View, starLabel: star1Label, starImage: star1StarImage)
        star1IsSelect = false
        unselectStar(starView: star2View, starLabel: star2Label, starImage: star2StarImage)
        star2IsSelect = false
        unselectStar(starView: star3View, starLabel: star3Label, starImage: star3StarImage)
        star3IsSelect = false
        unselectStar(starView: star4View, starLabel: star4Label, starImage: star4StarImage)
        star4IsSelect = false
        unselectStar(starView: star5View, starLabel: star5Label, starImage: star5StarImage)
        star5IsSelect = false
        
        let hotelStarStr = getHotelStar()
        
        delegate?.selectFilter(hotelStars: hotelStarStr, lowerPrice: "\(String(format: "%.0f", priceRangeSlider.lowerValue))", upperPrice: "\(String(format: "%.0f", priceRangeSlider.upperValue))", guestRating: "\(String(format: "%.0f", guestRatingSlider.value))")
        
    }
    
    func closeView() {
        parent?.navigationController?.popViewController(animated: true)
        parent?.dismiss(animated: true, completion: nil)
    }
    
    func getHotelStar() -> String {
        var hotelStarStr = ""
        if star1IsSelect {
            hotelStarStr = "1"
        }
        
        if star2IsSelect {
            
            if hotelStarStr != "" { hotelStarStr = hotelStarStr + "-" }
            
            hotelStarStr = hotelStarStr + "2"
        }
        
        if star3IsSelect {
            
            if hotelStarStr != "" { hotelStarStr = hotelStarStr + "-" }
            
            hotelStarStr = hotelStarStr + "3"
        }
        
        if star4IsSelect {
            
            if hotelStarStr != "" { hotelStarStr = hotelStarStr + "-" }
            
            hotelStarStr = hotelStarStr + "4"
        }
        
        if star5IsSelect {
            
            if hotelStarStr != "" { hotelStarStr = hotelStarStr + "-" }
            
            hotelStarStr = hotelStarStr + "5"
        }
        
        return hotelStarStr
    }
    
    func setupPriceRange(lowerPrice : Double, upperPrice : Double, isValueChange : Bool) {
        
        if isValueChange {
            priceRangeSlider.lowerValue = lowerPrice
            priceRangeSlider.upperValue = upperPrice
        }
        
        if let symbol = maxPrice?.currency_symbol {
            lowerPriceLabel.text = "\(symbol) \(String(format: "%.0f", lowerPrice))"
            higherPriceLabel.text = "\(symbol) \(String(format: "%.0f", upperPrice))"
        }else {
            lowerPriceLabel.text = "\(String(format: "%.0f", lowerPrice))"
            higherPriceLabel.text = "\(String(format: "%.0f", upperPrice))"
        }
        
    }
    
    func setupGuestRating(_  rating : Float, isValueChange : Bool ) {
        
        print("setup Guest Rating")
        if isValueChange {
            guestRatingSlider.value = ceil(rating)
        }
        
        guestRatingLabel.text = language.searchFilter__guestRating
            + "\(ceil(rating))"
            + language.searchFilter__orHigher
        
        if rating == 0 {
            guestRatingLabel.text = language.searchFilter__guestRatingAll
        }
    }
    
    @IBAction func okClicked(_ sender: Any) {
        
        let hotelStarStr = getHotelStar()
        
        delegate?.selectFilter(hotelStars: hotelStarStr, lowerPrice: "\(String(format: "%.0f", priceRangeSlider.lowerValue))", upperPrice: "\(String(format: "%.0f", priceRangeSlider.upperValue))", guestRating: "\(String(format: "%.0f", guestRatingSlider.value))")
        
        closeView()
    }
    
}
