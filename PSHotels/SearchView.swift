
//
//  SearchView.swift
//  PSHotels
//
//  Created by Panacea-Soft on 10/29/17.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import UIKit
import Alamofire

@IBDesignable
class SearchView: PSUIView {

    // MARK: Custom Variables
    // NibName of View. This variable will use later in getNibName()
    var parentView : UIViewController?
    var priceViewModel : PriceViewModel = PriceViewModel()
    var hotelViewModel : HotelViewModel = HotelViewModel()
    
    //var city: City? = nil
    var cityId: String = ""
    var cityName: String = ""
    var hotelStarStr : String = ""
    var lowerPrice : String = ""
    var upperPrice : String = ""
    var guestRating : String = ""
    var maxPrice : Price? = nil

    @IBOutlet weak var searchLogView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var hotelNameTextField: UITextField!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var lastSearchLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var hotelFilterLabel: UILabel!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var filterView: UIView!
    
    
    // MARK: - Override Functions
    override func initVariables() {
        hotelViewModel.nibName = "SearchView"
    }
    
    // MARK: - Override Functions
    // joining DetailView.swift and DetailView.xib
    override func getNibName() -> String {
        return hotelViewModel.nibName
        
    }
    
    override func initUIViewAndActions() {
        
        searchButton.setTitleColor(configs.colorTextAlt, for: .normal)
        searchButton.titleLabel?.font = customFont.subHeaderUIFont
        searchButton.backgroundColor = configs.colorPrimary
        searchButton.borderColor = configs.colorPrimary
        
        locationLabel.font = customFont.normalUIFont
        locationLabel.textColor = configs.colorText
        let locationLabelTap = UITapGestureRecognizer(target: self, action: #selector(SearchView.openDestination))
        locationLabel.addGestureRecognizer(locationLabelTap)
        
        let locationLabelTap2 = UITapGestureRecognizer(target: self, action: #selector(SearchView.openDestination))
        locationView.addGestureRecognizer(locationLabelTap2)
        
        hotelNameTextField.font = customFont.normalUIFont
        hotelNameTextField.textColor = configs.colorText
        
        filterLabel.font = customFont.normalUIFont
        filterLabel.textColor = configs.colorText
        filterLabel.text = language.searchFilter__filter
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(SearchView.openSearchFilter))
        filterLabel.addGestureRecognizer(singleTap)

        let singleTap2 = UITapGestureRecognizer(target: self, action: #selector(SearchView.openSearchFilter))
        filterView.addGestureRecognizer(singleTap2)
        
        lastSearchLabel.font = customFont.normalUIFont
        lastSearchLabel.textColor = configs.colorWhite
        
        cityLabel.font = customFont.tagUIFont
        cityLabel.textColor = configs.colorWhite
        
        hotelFilterLabel.font = customFont.tagUIFont
        hotelFilterLabel.textColor = configs.colorWhite
        
        
        let searchLogTap = UITapGestureRecognizer(target: self, action: #selector(SearchView.openSearchResultList))
        searchLogView.addGestureRecognizer(searchLogTap)
        
        
    }
    
    override func initData() {
        priceViewModel.getPrice()
        
        priceViewModel.pirceLiveData.bind{ [weak self] in
            
            if let resourse : Resourse<Price> = $0 {
                
                if resourse.status == Status.SUCCESS ||
                    resourse.status == Status.LOADING {
                    
                    if let data : Price = resourse.data {
                        self?.maxPrice = data
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
        
        let searchLog = Common.instance.loadSearch()
        if searchLog.cityId == "" {
            hideSearchLog()
        }else {
            showSearchLog()
            
        }
        
    }
    
    
    // MARK: Actions
    
    @objc func openSearchResultList() {
        
        let searchLog = Common.instance.loadSearch()
        
        if searchLog.cityId != "" {
            PSNavigationController.instance.navigateToSearchResultList(cityId: searchLog.cityId, hotelName: hotelNameTextField.text!, starRating: searchLog.starRating, lowerPrice: searchLog.lowerPrice, upperPrice: searchLog.upperPrice, guestRating: searchLog.guestRating, maxPrice: maxPrice!)
            PSNavigationController.instance.updateBackButton()
            
        }
    }
    
    
    @objc func openDestination() {
        print("Clicked openDestination")
        PSNavigationController.instance.navigateToSearchLocation(self)
        PSNavigationController.instance.updateBackButton()
    }
    
    @objc func openSearchFilter() {
        print("Clicked Open Search Filter")
        PSNavigationController.instance.navigateToSearchFilter(self, hotelStarStr : self.hotelStarStr, lowerPrice: lowerPrice, upperPrice: upperPrice, guestRating : guestRating, maxPrice : maxPrice!)
        PSNavigationController.instance.updateBackButton()
    }
   
    @IBAction func searchClicked(_ sender: Any) {
        
        if !Connectivity.isConnected() {
            _ = SweetAlert().showAlert(language.psTitle, subTitle:  language.error_message__no_internet_connection, style: AlertStyle.error)
            
            return
        }
        
        if cityId == "" {
            _ = SweetAlert().showAlert(language.psTitle, subTitle:  language.error_message__blank_city, style: AlertStyle.warning)
            return
        }
        
        Common.instance.saveSearch(cityId: cityId, cityName: cityName,
                                   hotelName: hotelNameTextField.text!,
                                   starRating: hotelStarStr,
                                   lowerPrice: lowerPrice,
                                   upperPrice: upperPrice,
                                   guestRating: guestRating)
        
        showSearchLog()
        
        PSNavigationController.instance.navigateToSearchResultList(cityId: cityId, hotelName: hotelNameTextField.text!, starRating: hotelStarStr, lowerPrice: lowerPrice, upperPrice: upperPrice, guestRating: guestRating, maxPrice: maxPrice!)
        PSNavigationController.instance.updateBackButton()
    }
    
    func hideSearchLog() {
        searchLogView.isHidden = true
        cityLabel.isHidden = true
        hotelFilterLabel.isHidden = true
        lastSearchLabel.isHidden = true
    }
    
    func showSearchLog() {
        
        let searchLog = Common.instance.loadSearch()
        searchLogView.isHidden = false
        cityLabel.isHidden = false
        cityLabel.text = searchLog.cityName
        hotelFilterLabel.isHidden = false
        hotelFilterLabel.text = searchLog.hotelName + " | " + searchLog.starRating + " \(language.search__stars) | " + searchLog.lowerPrice + "-" + searchLog.upperPrice + " \(language.search__price) | " + searchLog.guestRating + " \(language.search__rating)"
        lastSearchLabel.isHidden = false
    }
    
}





extension SearchView : SearchLocationProtocol {
    func selectLocation(_ city: City) {
        self.cityId = city.city_id
        self.cityName = city.city_name
        print("Selected City \(city.city_name)")
        locationLabel.text = city.city_name
    }

}


extension SearchView : SearchFilterProtocol {
    func selectFilter(hotelStars: String, lowerPrice: String, upperPrice: String, guestRating: String) {
        
        self.hotelStarStr = hotelStars
        self.lowerPrice = lowerPrice
        self.upperPrice = upperPrice
        self.guestRating = guestRating
       
        var langStar = language.search__stars
        var langReview = language.search__review
        if Common.instance.screenSize.width <= 320 {
            // iPhone SE
            langStar = language.search__starsS
            langReview = language.search__reviewR
            
        }
        
        var filterStr = ""
        
        if hotelStars == "" {
            filterStr = "\(langStar) \(language.search__all)"
        }else {
            filterStr = "\(langStar) \(hotelStars)"
        }
        
        if let symbol = maxPrice?.currency_symbol {
            filterStr += "/ \(symbol) \(lowerPrice) - \(symbol) \(upperPrice)"
        }
        
        if guestRating == "0" {
            filterStr += "/ \(langReview) \(language.search__all)"
        }else {
            filterStr += "/ \(langReview) \(guestRating) +"
        }
        filterLabel.text = filterStr

        
    }
    
    
}





