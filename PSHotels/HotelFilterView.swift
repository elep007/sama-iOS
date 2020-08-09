//
//  HotelFilterView.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/22/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
import SwiftRangeSlider
import HTagView

//MARK: Protocols
protocol HotelFilterProtocol: class {
    func selectFilter(hotelStars: String, lowerPrice: String, upperPrice: String, guestRating: String, features: String )
}

@IBDesignable
class HotelFilterView : PSUIView {
    
    
    @IBOutlet weak var hotelTag: HTagView!
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
    @IBOutlet weak var hotelFeatureTitleLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var tagViewHeight: NSLayoutConstraint!
    
    var hotelInfoTypeList : [HotelInfoType] = [HotelInfoType]()
    
    let nibName = "HotelFilterView"
    var delegate : HotelFilterProtocol? = nil
    var parent : UIViewController? = nil
    
    var maxPrice : Price? = nil
    //var city : City? = nil
    var cityId: String = ""
    var maxValue : Double = 5000 {
        didSet {
            priceRangeSlider.maximumValue = maxValue
            
            if upperPrice == "" {
                
                setupPriceRange(lowerPrice: 0, upperPrice: maxValue, isValueChange: true)
                
            }
        }
    }
    let priceViewModel = PriceViewModel()
    var hotelFeatureViewModel : HotelFeatureViewModel = HotelFeatureViewModel()
    
    var hotelStarStr : String = ""
    var lowerPrice : String = ""
    var upperPrice : String = ""
    var guestRating : String = ""
    var infoType : String = ""
    var infoTypeIndex : [Int]  = [Int]()
    
    var star1IsSelect : Bool = false
    var star2IsSelect : Bool = false
    var star3IsSelect : Bool = false
    var star4IsSelect : Bool = false
    var star5IsSelect : Bool = false
    
    
    // MARK: - Override Functions
    // joining DetailView.swift and DetailView.xib
    override func getNibName() -> String {
        return nibName
    }
    
    override func initUIViewAndActions() {
        let star1Tap = UITapGestureRecognizer(target: self, action: #selector(HotelFilterView.clickedStar1View))
        star1View.addGestureRecognizer(star1Tap)
        
        let star2Tap = UITapGestureRecognizer(target: self, action: #selector(HotelFilterView.clickedStar2View))
        star2View.addGestureRecognizer(star2Tap)
        
        let star3Tap = UITapGestureRecognizer(target: self, action: #selector(HotelFilterView.clickedStar3View))
        star3View.addGestureRecognizer(star3Tap)
        
        let star4Tap = UITapGestureRecognizer(target: self, action: #selector(HotelFilterView.clickedStar4View))
        star4View.addGestureRecognizer(star4Tap)
        
        let star5Tap = UITapGestureRecognizer(target: self, action: #selector(HotelFilterView.clickedStar5View))
        star5View.addGestureRecognizer(star5Tap)
        
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
        
        priceRangeSlider.addTarget(self, action: #selector(HotelFilterView.priceSliderValueChanged(_:)), for: .valueChanged)
        
        if let price = maxPrice?.max_price {
            setupPriceRange(lowerPrice: 0, upperPrice: Double(price)!, isValueChange: true)
        }
        
        okButton.setTitleColor(configs.colorTextAlt, for: .normal)
        okButton.titleLabel?.font = customFont.subHeaderUIFont
        okButton.backgroundColor = configs.colorPrimary
        okButton.borderColor = configs.colorPrimary
        
        // setup Title Labels
        hotelStarRatingLabel.font = customFont.subHeaderUIFont
        hotelStarRatingLabel.textColor = configs.colorText
        hotelStarRatingLabel.text = language.searchFilter__hotelRating
        
        priceTitleLabel.font = customFont.subHeaderUIFont
        priceTitleLabel.textColor = configs.colorText
        priceTitleLabel.text = language.searchFilter__hotelPrice
        
        hotelFeatureTitleLabel.font = customFont.subHeaderUIFont
        hotelFeatureTitleLabel.textColor = configs.colorText
        hotelFeatureTitleLabel.text = language.searchFilter__hotelFeatures
        
        guestRatingLabel.font = customFont.subHeaderUIFont
        guestRatingLabel.textColor = configs.colorText
        
        lowerPriceLabel.font = customFont.tagUIFont
        lowerPriceLabel.textColor = configs.colorText
        
        higherPriceLabel.font = customFont.tagUIFont
        higherPriceLabel.textColor = configs.colorText
        
        
    
         hotelTag.delegate = self
         hotelTag.dataSource = self
         hotelTag.marg = 16
         hotelTag.btwTags = 8
         hotelTag.btwLines = 8
         hotelTag.tagFont = customFont.normalUIFont
         hotelTag.tagMainBackColor = configs.colorHightLight
        
         hotelTag.tagSecondBackColor = configs.colorWhite
         hotelTag.tagSecondTextColor = configs.colorText
         hotelTag.tagContentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
         hotelTag.tagMaximumWidth = .HTagAutoMaximumWidth
         hotelTag.tagBorderColor = configs.colorLine.cgColor
         hotelTag.tagBorderWidth = 1
        
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
        
        hotelFeatureViewModel.getHotelFeatures(cityId: cityId)
        hotelFeatureViewModel.hotelFeatureListByCityIdLiveData.bind{ [weak self] in
            
            if let resourseList : Resourse<[HotelFeature]> = $0 {
                
                if resourseList.status == Status.SUCCESS ||
                    resourseList.status == Status.LOADING {
                    
                    
                    self?.hotelInfoTypeList = []
                    for i in 0..<resourseList.data!.count {
                        
                        
                        
                        for j in 0..<resourseList.data![i].types.count {
                            self?.hotelInfoTypeList.append(resourseList.data![i].types[j])
                        }
                        
                    }
                    self?.hotelTag.reloadData()
                    
                    self?.updateSelectionOnTag()
                    
                }else if resourseList.status == Status.ERROR {
                    
                    print("1 Error in loading data. Message : " + resourseList.message)
                    
                }else {
                    print("Error in loading data. Message : " + resourseList.message)
                }
            }else {
                print("Something Wrong")
            }
            
        }
    }
    
    @objc func priceSliderValueChanged(_ priceSlider: RangeSlider) {
        
        if(priceSlider.lowerValue *   maxValue == 0 &&  priceSlider.upperValue * maxValue == maxValue) {
            
        } else {
            
            setupPriceRange(lowerPrice: priceSlider.lowerValue, upperPrice: priceSlider.upperValue, isValueChange : false)
            
        }
    }
    
    func updateSelectionOnTag() {
        let infoTypeArr = infoType.split{ $0 == "-"}
        if infoTypeArr.count > 0 {
            for i in 0..<hotelInfoTypeList.count {
                
                for j in 0..<infoTypeArr.count {
                    
                    if hotelInfoTypeList[i].hinfo_typ_id == infoTypeArr[j] {
                        
                        infoTypeIndex.append(i)
                        
                        break
                    }
                    
                }
            }
        }
        
        for i in 0..<infoTypeIndex.count {
            hotelTag.selectTagAtIndex(infoTypeIndex[i])
        }
    }
    
    @IBOutlet weak var guestRatingSlider: UISlider!
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
        
        for i in 0..<hotelInfoTypeList.count {
            hotelTag.deselectTagAtIndex(i)
        }
        
        let hotelStarStr = getHotelStar()
        
        var str = ""
        for i in 0..<hotelTag.selectedIndices.count {
            if str != "" {
                str = str + "-"
            }
            str = str + hotelInfoTypeList[hotelTag.selectedIndices[i]].hinfo_typ_id
        }
        
        
        delegate?.selectFilter(hotelStars: hotelStarStr, lowerPrice: "\(String(format: "%.0f", priceRangeSlider.lowerValue))", upperPrice: "\(String(format: "%.0f", priceRangeSlider.upperValue))", guestRating: "\(String(format: "%.0f", guestRatingSlider.value))", features: str)
        
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
        
        var str = ""
        for i in 0..<hotelTag.selectedIndices.count {
            if str != "" {
                str = str + "-"
            }
            str = str + hotelInfoTypeList[hotelTag.selectedIndices[i]].hinfo_typ_id
        }
        
        delegate?.selectFilter(hotelStars: hotelStarStr, lowerPrice: "\(String(format: "%.0f", priceRangeSlider.lowerValue))", upperPrice: "\(String(format: "%.0f", priceRangeSlider.upperValue))", guestRating: "\(String(format: "%.0f", guestRatingSlider.value))", features: str)
        
        closeView()
        
        
    }
    
    
}



extension HotelFilterView : HTagViewDelegate, HTagViewDataSource {
    // MARK: - Data
    
    // MARK: - HTagViewDataSource
    func numberOfTags(_ tagView: HTagView) -> Int {
        switch tagView {
        
        case hotelTag:
            
            tagViewHeight.constant = hotelTag.intrinsicContentSize.height

            return hotelInfoTypeList.count
            
        default:
            return 0
        }
    }
    
    func tagView(_ tagView: HTagView, titleOfTagAtIndex index: Int) -> String {
        switch tagView {
           
        case hotelTag:
            return hotelInfoTypeList[index].hinfo_typ_name
        default:
            return "???"
        }
    }
    
    func tagView(_ tagView: HTagView, tagTypeAtIndex index: Int) -> HTagType {
        switch tagView {
            
        case hotelTag:
            return .select
        default:
            return .select
        }
    }
    
    func tagView(_ tagView: HTagView, tagWidthAtIndex index: Int) -> CGFloat {
        return .HTagAutoWidth
    }
    
    // MARK: - HTagViewDelegate
    func tagView(_ tagView: HTagView, tagSelectionDidChange selectedIndices: [Int]) {
        print("tag with indices \(selectedIndices) are selected")
        print(hotelTag.selectedIndices)
        
    }
    func tagView(_ tagView: HTagView, didCancelTagAtIndex index: Int) {
        print("tag with index: '\(index)' has to be removed from tagView")
        //hotelTag_data.remove(at: index)
        tagView.reloadData()
    }
    
}

