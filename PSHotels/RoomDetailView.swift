//
//  RoomDetailView.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/11/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

protocol RoomDetailViewDelegate {
    func refreshHotelData()
}


@IBDesignable
class RoomDetailView: PSUIView  {
    
    var roomViewModel : RoomViewModel = RoomViewModel()
    var roomData : Room? = nil
    var delegate : RoomDetailViewDelegate? = nil
    
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var guestRatingLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var hotelDescLabel: UILabel!
    @IBOutlet weak var inquiryButton: UIButton!
    @IBOutlet weak var favImageView: UIImageView!
    @IBOutlet weak var priceTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var guestLimitTitleLabel: UILabel!
    @IBOutlet weak var guestLimitLabel: UILabel!
    @IBOutlet weak var bedsTitleLabel: UILabel!
    @IBOutlet weak var bedsLabel: UILabel!
    @IBOutlet weak var roomSizeTitleLabel: UILabel!
    @IBOutlet weak var roomSizeLabel: UILabel!
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var roomFeatureHeight: NSLayoutConstraint!
    @IBOutlet weak var roomFeaturesContainer: RoomFeaturesView!
    @IBOutlet weak var bookingButton: UIButton!
    @IBOutlet weak var discountPriceLabel: UILabel!
    
    // MARK: - Override Functions
    override func initVariables() {
        roomViewModel.nibName = "RoomDetailView"
    }
    
    // MARK: - Override Functions
    // joining DetailView.swift and DetailView.xib
    override func getNibName() -> String {
        return roomViewModel.nibName
    }
    
    override func initUIViewAndActions() {
        super.initUIViewAndActions()
        
        setupUI()
        
        // Loading Monitoring
        roomViewModel.isLoading.bind{
            if($0) {
                Common.instance.showBarLoading()
            }else {
                Common.instance.hideBarLoading()
            }
        }
    }
    
    override func initData() {
        roomViewModel.getRoomById(loginUserId: loginUserId, roomId: (roomData?.room_id)!)
        roomViewModel.roomByRoomIdLiveData.bind{ [weak self] in
            
            if let resourse : Resourse<Room> = $0 {
                
                if resourse.status == Status.SUCCESS
                    || resourse.status == Status.LOADING {
                    
                    if let room : Room = resourse.data {
                        
                        self?.bindRoomData(room: room)
                        
                    }
                    
                } else if resourse.status == Status.ERROR {
                    print("Error in loading data. Message : " + resourse.message)
                }
            }else {
                print("Something Wrong")
            }
            
        }
        
        roomFeaturesContainer.delegate = self
        roomFeaturesContainer.roomData = self.roomData
        roomFeaturesContainer.setup()
        
        roomViewModel.doPostRoomTouchCount(roomId: (roomData?.room_id)!, loginUserId: super.loginUserId)
        
        roomViewModel.postRoomTouchCountLiveData.bind{
            if let resourse : Resourse<ApiStatus> = $0 {
                
                if resourse.status == Status.SUCCESS ||
                    resourse.status == Status.LOADING {
                    
                    print("Post Count Success.")
                    
                }else {
                    print("Error in loading data. Message : " + resourse.message)
                }
            }else {
                print("Something Wrong")
            }
        }
    }
    
    func bindRoomData(room: Room) {
        // hotel name
        hotelNameLabel.text = room.room_name
        
        // guest rating
        guestRatingLabel.text = "\(room.rating.final_rating) \(room.rating.rating_text)"
        
        // review count
        reviewCountLabel.text = "\(room.rating.review_count) \(language.search__review)"
        
        // hotel desc
        hotelDescLabel.text = room.room_desc
        hotelDescLabel.setLineHeight(height: configs.lineSpacing)
        
        // price
        priceTitleLabel.text = language.hotel__pricePerNight
        priceLabel.text = "\(room.currency_symbol) \(room.room_price)"
        
        //discount price
        
        if (room.promotion.promo_id == "") {
            discountPriceLabel.isHidden = true
            priceLabel.text = "\(room.currency_symbol) \(room.room_price)"
        } else {
            priceLabel.isHidden = false
            discountPriceLabel.isHidden = false
            //Need to update discount price
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(room.currency_symbol) \(room.room_price)")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            
            priceLabel.attributedText = attributeString
            
            let discountPrice = Int((Double(room.promotion.promo_percent)! / 100) * Double(room.room_price)!)
            
            discountPriceLabel.text = "\(room.currency_symbol) \(discountPrice)"
            
            priceLabel.font = customFont.normalBoldUIFont
            priceLabel.textColor = configs.colorText
            
        }
        
        
        
        ///
        
        // Guest Limit
        guestLimitTitleLabel.text = language.hotel__guestLimit
        guestLimitLabel.text = "\(room.room_adult_limit) \(language.hotel__adults) \(room.room_kid_limit) \(language.hotel__kids)"
        
       
        // beds
        bedsTitleLabel.text = language.hotel__bedsCount
        bedsLabel.text = "\(room.room_no_of_beds) \(language.hotel__beds) "
        
        if room.room_extra_bed_price != "" {
            bedsLabel.text = bedsLabel.text! + " ( \(language.hotel__extraBeds) \(room.currency_symbol) \(room.room_extra_bed_price) )"
        }
        
        // Room Size
        roomSizeTitleLabel.text = language.hotel__roomSize
        roomSizeLabel.text = "\(room.room_size)"
        
        // hotel ImageView
        let imageURL = configs.imageUrl + room.default_photo.img_path
        
        hotelImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "PlaceholderImage"))
        
        //need to check for room available
        if(Int(room.is_available) == 1) {
            bookingButton.isUserInteractionEnabled = true
            bookingButton.isEnabled = true
            bookingButton.setTitle(language.booking__available , for: .normal)
            bookingButton.backgroundColor = configs.colorPrimary
            bookingButton.setTitleColor(configs.colorTextAlt, for: .normal)
        } else {
            bookingButton.isUserInteractionEnabled = false
            bookingButton.isEnabled = false
            bookingButton.setTitle(language.booking__not__available, for: .normal)
            
            bookingButton.setTitleColor(configs.colorDisableText, for: .normal)
            
            bookingButton.backgroundColor = configs.colorDisable
        }
        
    }
    
    @IBAction func bookingClicked(_ sender: Any) {
        
        if !Connectivity.isConnected() {
            _ = SweetAlert().showAlert(language.hotelTitle, subTitle:  language.error_message__no_internet_connection, style: AlertStyle.error)
            return
        }
        
        if super.loginUserId == configs.default_user {
            // User Havn't Login
            PSNavigationController.instance.navigateToUserLogin(delegate: self)
            PSNavigationController.instance.updateBackButton()
        }else {
            
            PSNavigationController.instance.navigateToBookView(hotelId: (roomData?.hotel_id)!, roomId: (roomData?.room_id)!)
            PSNavigationController.instance.updateBackButton()
            
        }
        
    }
    
    
    @IBAction func inquiryClicked(_ sender: Any) {
        PSNavigationController.instance.navigateToInquiry(hotelId: (roomData?.hotel_id)!, roomId: (roomData?.room_id)!)
        PSNavigationController.instance.updateBackButton()
    }
    
    func setupUI() {
        // hotel name
        hotelNameLabel.font = customFont.headerUIFont
        hotelNameLabel.textColor = configs.colorText
        
        // guest Rating
        guestRatingLabel.font = customFont.tagUIFont
        guestRatingLabel.textColor = configs.colorReviewTitle
        
        // review count
        reviewCountLabel.font = customFont.tagUIFont
        reviewCountLabel.textColor = configs.colorTextLight
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(RoomDetailView.openReviewList))
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
        guestLimitTitleLabel.font = customFont.normalBoldUIFont
        guestLimitTitleLabel.textColor = configs.colorText
        guestLimitLabel.font = customFont.normalUIFont
        guestLimitLabel.textColor = configs.colorText
        
        // contact email
        bedsTitleLabel.font = customFont.normalBoldUIFont
        bedsTitleLabel.textColor = configs.colorText
        bedsLabel.font = customFont.normalUIFont
        bedsLabel.textColor = configs.colorText
        
        // contact phone
        roomSizeTitleLabel.font = customFont.normalBoldUIFont
        roomSizeTitleLabel.textColor = configs.colorText
        roomSizeLabel.font = customFont.normalUIFont
        roomSizeLabel.textColor = configs.colorText
        
        // Gallery
        let singleTap2 = UITapGestureRecognizer(target: self, action: #selector(HotelDetailView.openGallery))
        hotelImageView.addGestureRecognizer(singleTap2)
        
        // Book Button
        bookingButton.setTitleColor(configs.colorTextAlt, for: .normal)
        bookingButton.titleLabel?.font = customFont.normalUIFont
        bookingButton.backgroundColor = configs.colorPrimary
        bookingButton.borderColor = configs.colorPrimary
    }
    
    @objc func openGallery() {
        print("Clicked open Gallery")
        PSNavigationController.instance.navigateToGallery((self.roomData?.room_id)!)
        PSNavigationController.instance.updateBackButton()
    }
    
    @objc func openReviewList() {
        print("Clicked openReviewList")
        PSNavigationController.instance.navigateToRoomReviewList(roomData: roomData!, delegate: self)
        PSNavigationController.instance.updateBackButton()
    }
}


extension RoomDetailView : RoomFeaturesViewDelegate {
    func resizeRoomFeaturesContainer(_ height: CGFloat) {
        roomFeatureHeight.constant = height
    }

}

extension RoomDetailView : RoomReviewListViewDelegate {
    func refreshReviewData() {
        roomViewModel.getRoomById(loginUserId: loginUserId, roomId: (roomData?.room_id)!)
        
        delegate?.refreshHotelData()
    }
    
}

extension RoomDetailView : LoginViewDelegate {
    func refreshProfileData() {
        super.refreshUserLogin()
    }
    
}


