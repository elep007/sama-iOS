//
//  HotelDetailView.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/24/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
import MapKit

protocol HotelDetailViewDelegate {
    func refreshHotelData(_ hotel: Hotel)
}

@IBDesignable
class HotelDetailView: PSUIView  {
    
    var hotelViewModel : HotelViewModel = HotelViewModel()
    var hotelData : Hotel? = nil
    
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var guestRatingLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var hotelDescLabel: UILabel!
    @IBOutlet weak var inquiryButton: UIButton!
    @IBOutlet weak var favImageView: UIImageView!
    @IBOutlet weak var favContainerView: UIView!
    @IBOutlet weak var priceTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var checkinoutTitleLabel: UILabel!
    @IBOutlet weak var checkinoutLabel: UILabel!
    @IBOutlet weak var contactEmailTitleLabel: UILabel!
    @IBOutlet weak var contactEmailLabel: UILabel!
    @IBOutlet weak var contactPhoneTitleLabel: UILabel!
    @IBOutlet weak var contactPhoneLabel: UILabel!
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var viewOnMapButton: UIButton!
    
    @IBOutlet weak var star1Icon: UIImageView!
    @IBOutlet weak var star2Icon: UIImageView!
    @IBOutlet weak var star3Icon: UIImageView!
    @IBOutlet weak var star4Icon: UIImageView!
    @IBOutlet weak var star5Icon: UIImageView!
    
    @IBOutlet weak var hotelFeatureHeight: NSLayoutConstraint!
    @IBOutlet weak var hotelFeaturesContainer: HotelFeaturesView!
    //var favListDelegate: FavouriteNewsListDelegate? = nil
    
    var delegate: HotelDetailViewDelegate? = nil
    
    // MARK: - Override Functions
    override func initVariables() {
        hotelViewModel.nibName = "HotelDetailView"
    }
    
    // MARK: - Override Functions
    // joining DetailView.swift and DetailView.xib
    override func getNibName() -> String {
        return hotelViewModel.nibName
    }
    
    override func initUIViewAndActions() {
        super.initUIViewAndActions()
        
        setupUI()
        
        // Loading Monitoring
        hotelViewModel.isLoading.bind{
            if($0) {
                Common.instance.showBarLoading()
            }else {
                Common.instance.hideBarLoading()
            }
        }
        
       
    }
    
    override func initData() {
        hotelViewModel.getHotelById(loginUserId: loginUserId, hotelId: (hotelData?.hotel_id)!)
        hotelViewModel.hotelByHotelIdLiveData.bind{ [weak self] in
            
            if let resourse : Resourse<Hotel> = $0 {
                
                if resourse.status == Status.SUCCESS
                    || resourse.status == Status.LOADING {
                    
                    if let hotel : Hotel = resourse.data {
                        
                        self?.bindHotelData(hotel: hotel)
                        
                        if let delegate = self?.delegate {
                            delegate.refreshHotelData(hotel)
                        }
                    }
                    
                } else if resourse.status == Status.ERROR {
                    print("Error in loading data. Message : " + resourse.message)
                }
            }else {
                print("Something Wrong")
            }
            
        }
        
        hotelViewModel.doFavHotelsLiveData.bind{ [weak self] in
            if let resourse : Resourse<Hotel> = $0 {
                
                if resourse.status == Status.SUCCESS ||
                    resourse.status == Status.LOADING {
                    
                    if let hotel : Hotel = resourse.data {
                        
                        self?.bindHotelData(hotel: hotel)
                        
                        if let delegate = self?.delegate {
                            delegate.refreshHotelData(hotel)
                        }
                        
                    }
                    
                }else {
                    print("Error in loading data. Message : " + resourse.message)
                }
            }else {
                print("Something Wrong")
            }
        }
        
        // Hotel Features
        hotelFeaturesContainer.delegate = self
        hotelFeaturesContainer.hotelData = self.hotelData
        hotelFeaturesContainer.setup()
    }
    
    func bindHotelData(hotel: Hotel) {
        // hotel name
        hotelNameLabel.text = hotel.hotel_name
        
        // hotel address
        addressLabel.text = hotel.hotel_address
        
        // guest rating
        guestRatingLabel.text = "\(hotel.rating.final_rating) \(hotel.rating.rating_text)"
        
        // review count
        reviewCountLabel.text = "\(hotel.rating.review_count) \(language.search__review)"
        
        // hotel desc
        hotelDescLabel.text = hotel.hotel_desc
        hotelDescLabel.setLineHeight(height: configs.lineSpacing)
        
        // price
        priceTitleLabel.text = language.search__pricePerNight
        priceLabel.text = "\(hotel.currency_symbol) \(hotel.hotel_min_price) \(language.search__tilde) \(hotel.currency_symbol) \(hotel.hotel_max_price)"
        
        // checkout in/out
        checkinoutTitleLabel.text = language.search__checkInOutTime
        checkinoutLabel.text = "\(hotel.hotel_check_in) \(language.search__slash) \(hotel.hotel_check_out)"
        
        if (hotel.hotel_check_in == "" )
            && (hotel.hotel_check_in == "") {
            checkinoutLabel.text = "-"
        }
        
        if hotel.is_user_favourited == "true" {
            favImageView.image = UIImage(named: "Favd")
        }else {
            favImageView.image = UIImage(named: "Fav")
        }
        
        
        // contact email
        contactEmailTitleLabel.text = language.search__contactEmail
        contactEmailLabel.text = "\(hotel.hotel_email)"
        
        // contact phone
        contactPhoneTitleLabel.text = language.search__contactPhone
        contactPhoneLabel.text = "\(hotel.hotel_phone)"
        
        // hotel rating
        showStar(Int(hotel.hotel_star_rating)!)
        
        // hotel ImageView
        let imageURL = configs.imageUrl + hotel.default_photo.img_path
        
        hotelImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "PlaceholderImage"))
    }
    
    func setupUI() {
        // hotel name
        hotelNameLabel.font = customFont.headerUIFont
        hotelNameLabel.textColor = configs.colorText
        
        // hotel address
        addressLabel.font = customFont.tagUIFont
        addressLabel.textColor = configs.colorText
        
        // guest Rating
        guestRatingLabel.font = customFont.tagUIFont
        guestRatingLabel.textColor = configs.colorReviewTitle
        
        // review count
        reviewCountLabel.font = customFont.tagUIFont
        reviewCountLabel.textColor = configs.colorTextLight
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(HotelDetailView.openReviewList))
        reviewCountLabel.addGestureRecognizer(singleTap)
        
        // hotel desc
        hotelDescLabel.font = customFont.normalUIFont
        hotelDescLabel.textColor = configs.colorText
        hotelDescLabel.setLineHeight(height: configs.lineSpacing)
        
        // price
        priceTitleLabel.font = customFont.normalBoldUIFont
        priceTitleLabel.textColor = configs.colorText
        priceLabel.font = customFont.normalBoldUIFont
        priceLabel.textColor = configs.colorPromotion
        
        // checkout in/out
        checkinoutTitleLabel.font = customFont.normalBoldUIFont
        checkinoutTitleLabel.textColor = configs.colorText
        checkinoutLabel.font = customFont.normalUIFont
        checkinoutLabel.textColor = configs.colorText
        
        // contact email
        contactEmailTitleLabel.font = customFont.normalBoldUIFont
        contactEmailTitleLabel.textColor = configs.colorText
        contactEmailLabel.font = customFont.normalUIFont
        contactEmailLabel.textColor = configs.colorText
        
        // contact phone
        contactPhoneTitleLabel.font = customFont.normalBoldUIFont
        contactPhoneTitleLabel.textColor = configs.colorText
        contactPhoneLabel.font = customFont.normalUIFont
        contactPhoneLabel.textColor = configs.colorText
        
        // fav
        let singleTap2 = UITapGestureRecognizer(target: self, action: #selector(HotelDetailView.clickedFav))
        favContainerView.addGestureRecognizer(singleTap2)
        
        // Gallery
        let singleTap3 = UITapGestureRecognizer(target: self, action: #selector(HotelDetailView.openGallery))
        hotelImageView.addGestureRecognizer(singleTap3)
        
        shareButton.setTitleColor(configs.colorTextAlt, for: .normal)
        shareButton.titleLabel?.font = customFont.normalUIFont
        shareButton.backgroundColor = configs.colorPrimary
        shareButton.borderColor = configs.colorPrimary
        
        viewOnMapButton.setTitleColor(configs.colorTextAlt, for: .normal)
        viewOnMapButton.titleLabel?.font = customFont.normalUIFont
        viewOnMapButton.backgroundColor = configs.colorPrimary
        viewOnMapButton.borderColor = configs.colorPrimary
    }
    
    @objc func clickedFav() {
        if !Connectivity.isConnected() {
            _ = SweetAlert().showAlert(language.hotelTitle, subTitle:  language.error_message__no_internet_connection, style: AlertStyle.error)
            return
        }
        
        if super.loginUserId == configs.default_user {
            // User Havn't Login
            PSNavigationController.instance.navigateToUserLogin(delegate: self)
            PSNavigationController.instance.updateBackButton()
        }else {
            
            hotelViewModel.doFavHotel(hotelId: (hotelData?.hotel_id)!, loginUserId: super.loginUserId)
        }
    }
    
    @objc func openReviewList() {
        print("Clicked openReviewList")
        PSNavigationController.instance.navigateToReviewList(hotelData: hotelData!, delegate: self)
        PSNavigationController.instance.updateBackButton()
    }
    
    @objc func openGallery() {
        print("Clicked open Gallery")
        PSNavigationController.instance.navigateToGallery((self.hotelData?.hotel_id)!)
        PSNavigationController.instance.updateBackButton()
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
    
    @IBAction func inquiryClicked(_ sender: Any) {
        PSNavigationController.instance.navigateToInquiry(hotelId: (hotelData?.hotel_id)!, roomId: "")
        PSNavigationController.instance.updateBackButton()
    }
    
    @IBAction func shareClicked(_ sender: Any) {
        if !Connectivity.isConnected() {
            _ = SweetAlert().showAlert(language.hotelTitle, subTitle:  language.error_message__no_internet_connection, style: AlertStyle.error)
            return
        }
        
        ps.print("Clicked Share Button")
        PSNavigationController.instance.navigateToShare(language.message__shareMessage, url: language.message__shareURL, sender: (sender as? UIView)!)
    }
    
    @IBAction func viewOnMapClicked(_ sender: Any) {
        
        let itemLat : String = (hotelData?.hotel_lat)!
        let itemLng : String = (hotelData?.hotel_lng)!
        
        if itemLat != "" && itemLng != "" {
            let latitude: CLLocationDegrees = Double(itemLat)!
            let longitude: CLLocationDegrees = Double(itemLng)!
            
            let regionDistance:CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = hotelData?.hotel_name
            mapItem.openInMaps(launchOptions: options)
        }
    }
    
}


extension HotelDetailView : HotelFeaturesViewDelegate {
    func resizeHotelFeaturesContainer(_ height: CGFloat) {
        hotelFeatureHeight.constant = height
    }
    
    
}

extension HotelDetailView : LoginViewDelegate {
    func refreshProfileData() {
        super.refreshUserLogin()
    }
    
}

extension HotelDetailView : ReviewListViewDelegate {
    func refreshReviewData() {
        hotelViewModel.getHotelById(loginUserId: loginUserId, hotelId: (hotelData?.hotel_id)!)
    }
    
    
}






