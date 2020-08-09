//
//  PSNavigationViewController.swift
//  PSHotels
//
//  Created by Panacea-Soft on 1/18/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation

open class PSNavigationController {
    
    static let instance : PSNavigationController = PSNavigationController()
    
    var storyboard: UIStoryboard!
    var navigationController: UINavigationController!
    var navigationItem : UINavigationItem!
    
    private init() {}
    
    func setInit(storyboard : UIStoryboard, navigationController : UINavigationController, navigationItem : UINavigationItem) {
            self.storyboard = storyboard
            self.navigationController = navigationController
            self.navigationItem = navigationItem

    }

    func navigateToSearchResultList(cityId: String,
                                    hotelName: String,
                                    starRating: String,
                                    lowerPrice : String,
                                    upperPrice : String,
                                    guestRating : String,
                                    maxPrice : Price) {
        
        print("Navigating to Search Result ")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let searchResultListViewController = storyboard.instantiateViewController(withIdentifier: "SearchResultListViewController") as! SearchResultListViewController
        
        PSNavigationController.instance.navigationController?.pushViewController(searchResultListViewController, animated: true)
        
        searchResultListViewController.cityId = cityId
        searchResultListViewController.hotelName = hotelName
        searchResultListViewController.starRating = starRating
        searchResultListViewController.lowerPrice = lowerPrice
        searchResultListViewController.upperPrice = upperPrice
        searchResultListViewController.guestRating = guestRating
        searchResultListViewController.maxPrice = maxPrice
        
    }
    
    func navigateToSearchFilter(_ delegate: SearchFilterProtocol,
                                hotelStarStr: String,
                                lowerPrice : String,
                                upperPrice : String,
                                guestRating : String,
                                maxPrice : Price) {
        
        print("Navigating to Search Filter")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let searchFilterViewController = storyboard.instantiateViewController(withIdentifier: "SearchFilterViewController") as! SearchFilterViewController
        PSNavigationController.instance.navigationController?.pushViewController(searchFilterViewController, animated: true)
        
        searchFilterViewController.delegate = delegate
        searchFilterViewController.hotelStarStr = hotelStarStr
        searchFilterViewController.lowerPrice = lowerPrice
        searchFilterViewController.upperPrice = upperPrice
        searchFilterViewController.guestRating = guestRating
        searchFilterViewController.maxPrice = maxPrice
        
    }
    
    func navigateToSearchLocation(_ delegate: SearchLocationProtocol) {
        
        print("Navigating to Search Location")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let searchLocationViewController = storyboard.instantiateViewController(withIdentifier: "SearchLocationViewController") as! SearchLocationViewController
        PSNavigationController.instance.navigationController?.pushViewController(searchLocationViewController, animated: true)
        
        searchLocationViewController.delegate = delegate
        
    }
    
    func navigateToHotel(hotelData : Hotel, delegate: HotelViewDelegate) {
        
        print("Navigating to HotelViewController")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let hotelViewController = storyboard.instantiateViewController(withIdentifier: "HotelViewController") as! HotelViewController
        
        PSNavigationController.instance.navigationController?.pushViewController(hotelViewController, animated: true)
        
        hotelViewController.delegate = delegate
        hotelViewController.hotelData = hotelData
        
    }
    
    func navigateToHotelFilter(_ delegate: HotelFilterProtocol,
                               hotelStarStr: String,
                               lowerPrice : String,
                               upperPrice : String,
                               guestRating : String,
                               maxPrice : Price,
                               cityId: String,
                               infoType: String) {
        
        print("Navigating to Search Filter")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let hotelFilterViewController = storyboard.instantiateViewController(withIdentifier: "HotelFilterViewController") as! HotelFilterViewController
        PSNavigationController.instance.navigationController?.pushViewController(hotelFilterViewController, animated: true)
        
        hotelFilterViewController.delegate = delegate
        hotelFilterViewController.hotelStarStr = hotelStarStr
        hotelFilterViewController.lowerPrice = lowerPrice
        hotelFilterViewController.upperPrice = upperPrice
        hotelFilterViewController.guestRating = guestRating
        hotelFilterViewController.maxPrice = maxPrice
        hotelFilterViewController.cityId = cityId
        hotelFilterViewController.infoType = infoType
        
    }
    
    func navigateToHotelDetail(hotelData: Hotel, delegate: HotelDetailViewDelegate) {
        
        print("Navigating to HotelViewController")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let hotelViewController = storyboard.instantiateViewController(withIdentifier: "HotelDetailViewController") as! HotelDetailViewController
        
        PSNavigationController.instance.navigationController?.pushViewController(hotelViewController, animated: true)
        hotelViewController.delegate = delegate
        hotelViewController.hotelData = hotelData
        
    }
    
    func navigateToBookingDetail(booking: Booking) {
        
        print("Navigating to BookingDetailViewController")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let bookingDetailViewController = storyboard.instantiateViewController(withIdentifier: "BookingDetailController") as! BookingDetailController
    PSNavigationController.instance.navigationController?.pushViewController(bookingDetailViewController, animated: true)
        
        bookingDetailViewController.booking = booking
        
    }
    
    func navigateToRoomDetail(roomData: Room, delegate: RoomDetailViewDelegate) {
        
        print("Navigating to RoomViewController")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let roomDetailViewController = storyboard.instantiateViewController(withIdentifier: "RoomDetailViewController") as! RoomDetailViewController
        
        PSNavigationController.instance.navigationController?.pushViewController(roomDetailViewController, animated: true)
        roomDetailViewController.roomData = roomData
        roomDetailViewController.delegate = delegate
        
    }
    
    func navigateToInquiry(hotelId: String, roomId: String) {
        
        print("Navigating to Inquiry")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let inquiryViewController = storyboard.instantiateViewController(withIdentifier: "InquiryViewController") as! InquiryViewController
        
        PSNavigationController.instance.navigationController?.pushViewController(inquiryViewController, animated: true)
        inquiryViewController.hotelId = hotelId
        inquiryViewController.roomId = roomId
        
    }
    
    func navigateToBookView(hotelId: String, roomId: String) {
        
        print("Navigating to Inquiry")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let bookViewController = storyboard.instantiateViewController(withIdentifier: "BookViewController") as! BookViewController
        
        PSNavigationController.instance.navigationController?.pushViewController(bookViewController, animated: true)
        bookViewController.hotelId = hotelId
        bookViewController.roomId = roomId
        
    }
    
    
    func navigateToGallery(_ newsId: String) {
        
        print("Navigating to Gallery")
        
        weak var galleryViewController = PSNavigationController.instance.storyboard?.instantiateViewController(withIdentifier: "GalleryViewController") as? GalleryViewController
        PSNavigationController.instance.navigationController?.pushViewController(galleryViewController!, animated: true)
        galleryViewController?.newsId = newsId
        
        
    }
   
    
    func navigateToUserRegister(delegate: RegisterViewDelegate) {
        
        print("Navigating to Forgot Password")
        
        weak var registerViewController = PSNavigationController.instance.storyboard?.instantiateViewController(withIdentifier: "UserRegisterViewController") as? UserRegisterViewController
        PSNavigationController.instance.navigationController?.pushViewController(registerViewController!, animated: true)
        registerViewController?.delegate = delegate
        
    }
    
    func navigateToUserProfileEdit(delegate : ProfileEditViewDelegate) {
        
        print("Navigating to Profile Edit")
        
        weak var userProfileEditViewController = PSNavigationController.instance.storyboard?.instantiateViewController(withIdentifier: "UserProfileEditViewController") as? UserProfileEditViewController
        PSNavigationController.instance.navigationController?.pushViewController(userProfileEditViewController!, animated: true)
        
        userProfileEditViewController?.delegate = delegate
        
        
    }
    
    func navigateToUserLogin(delegate: LoginViewDelegate) {
        
        print("Navigating to Forgot Password")
        
        weak var userLoginViewController = PSNavigationController.instance.storyboard?.instantiateViewController(withIdentifier: "UserLoginViewController") as? UserLoginViewController
        PSNavigationController.instance.navigationController?.pushViewController(userLoginViewController!, animated: true)
        
        userLoginViewController?.loginViewDelegate = delegate
        
    }
    
    func navigateToForgotPassword() {
        
        print("Navigating to Forgot Password")
        
        weak var forgotPasswordViewController = PSNavigationController.instance.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as? UserForgotPasswordViewController
        
        PSNavigationController.instance.navigationController?.pushViewController(forgotPasswordViewController!, animated: true)
        
        
    }
    
    func navigateToPasswordUpdate() {
        
        print("Navigating to Password Update")
        
        weak var passwordUpdateViewController = PSNavigationController.instance.storyboard?.instantiateViewController(withIdentifier: "UserPasswordChangeViewController") as? UserPasswordChangeViewController
        
        PSNavigationController.instance.navigationController?.pushViewController(passwordUpdateViewController!, animated: true)
        
        
    }
    
    func navigateToProfilePage() {
        (navigationController.revealViewController().rearViewController as? MenuListController)?.openProfilePage()
    }
   
    
    func navigateToReviewRoomFilter(_ delegate: RoomFilterViewProtocol, hotelData: Hotel) {
        
        print("Navigating to ReviewRoomFilter")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let reviewRoomFilterViewController = storyboard.instantiateViewController(withIdentifier: "ReviewRoomFilterViewController") as! ReviewRoomFilterViewController
        PSNavigationController.instance.navigationController?.pushViewController(reviewRoomFilterViewController, animated: true)
        
        reviewRoomFilterViewController.hotelData = hotelData
        reviewRoomFilterViewController.delegate = delegate
        
    }
    
    func navigateToReviewSubmit(hotelData: Hotel, delegate: ReviewSubmitViewDelegate) {
        
        print("Navigating to ReviewSubmit")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let reviewSubmitViewController = storyboard.instantiateViewController(withIdentifier: "ReviewSubmitViewController") as! ReviewSubmitViewController
        
        PSNavigationController.instance.navigationController?.pushViewController(reviewSubmitViewController, animated: true)
        
        reviewSubmitViewController.hotelData = hotelData
        reviewSubmitViewController.delegate = delegate
        
    }
    
    func navigateToReviewSubmit(roomData: Room, delegate: ReviewSubmitViewDelegate) {
        
        print("Navigating to ReviewSubmit")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let reviewSubmitViewController = storyboard.instantiateViewController(withIdentifier: "ReviewSubmitViewController") as! ReviewSubmitViewController
         PSNavigationController.instance.navigationController?.pushViewController(reviewSubmitViewController, animated: true)
        
        reviewSubmitViewController.roomData = roomData
        reviewSubmitViewController.delegate = delegate
        
    }
    
    func navigateToReviewList(hotelData: Hotel, delegate: ReviewListViewDelegate) {
        
        print("Navigating to ReviewListViewController")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let reviewListViewController = storyboard.instantiateViewController(withIdentifier: "ReviewListViewController") as! ReviewListViewController
        
        PSNavigationController.instance.navigationController?.pushViewController(reviewListViewController, animated: true)
        
        reviewListViewController.hotelData = hotelData
        reviewListViewController.delegate = delegate
        
    }
    
    func navigateToRoomReviewList(roomData: Room, delegate: RoomReviewListViewDelegate) {
        
        print("Navigating to ReviewListViewController")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let reviewListViewController = storyboard.instantiateViewController(withIdentifier: "RoomReviewListViewController") as! RoomReviewListViewController
        
        PSNavigationController.instance.navigationController?.pushViewController(reviewListViewController, animated: true)
        
        reviewListViewController.roomData = roomData
        reviewListViewController.delegate = delegate
        
    }
    
    
    func navigateToShare(_ message: String, url : String, sender : UIView) {
        let vc = UIActivityViewController(activityItems: [message, NSURL(string: url)!], applicationActivities: nil)
        
        PSNavigationController.instance.navigationController.present(vc, animated: true, completion: nil)
        if let popOver = vc.popoverPresentationController {
            popOver.sourceView = sender
        }
    }
    
    
    func updateBackButton() {
        let backItem = UIBarButtonItem()
        backItem.tintColor = configs.colorTextAlt
        backItem.title = ""
        PSNavigationController.instance.navigationItem.backBarButtonItem = backItem
    }
    
}
