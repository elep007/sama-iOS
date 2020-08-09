//
//  HotelView.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/24/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

protocol HotelViewDelegate {
    func refreshHotelData()
}

@IBDesignable
class HotelView: PSUIView {

    // MARK: Custom Variables
    
    @IBOutlet weak var collectionView: UICollectionView!
    var hotelViewModel : HotelViewModel = HotelViewModel()
    var roomViewModel : RoomViewModel = RoomViewModel()
    let reviewViewModel : ReviewViewModel = ReviewViewModel()
    var uiRefresher : UIRefreshControl?
    var hotelData : Hotel? = nil
    var favImageView : UIImageView? = nil
    var delegate: HotelViewDelegate? = nil
    
    // MARK: - Override Functions
    override func initVariables() {
        roomViewModel.nibName = "HotelView"
        roomViewModel.cellId = "RoomCollectionViewCell"
        roomViewModel.headerCellId = "HotelHeaderCollectionViewCell"
    }
    
    // joining NewsListView.swift and NewsListView.xib
    override func getNibName() -> String {
        return roomViewModel.nibName
    }
    
    override func initUIViewAndActions() {
        super.initUIViewAndActions()
        
        self.collectionView.backgroundColor = UIColor.clear
        
        super.initPinterestCollectionView(collectionView: collectionView, nibName: roomViewModel.cellId, nibHeaderName: roomViewModel.headerCellId, numberOfColumns: 1)
        
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
        roomViewModel.getRoomListByHotelId(hotelId: (hotelData?.hotel_id)!)
        
        roomViewModel.roomListByHotelIdLiveData.bind{ [weak self] in
            
            if let newsListResourse : Resourse<[Room]> = $0 {
                
                if newsListResourse.status == Status.SUCCESS
                    || newsListResourse.status == Status.LOADING {
                    
                    DispatchQueue.main.async{
                        
                        self?.collectionView?.reloadData()
                        
                        if let layout = self?.collectionView.collectionViewLayout as? PinterestLayout {
                            layout.reset()
                            
                        }
                    }
                    
                }else {
                    print("Error in loading data. Message : " + newsListResourse.message)
                }
            }else {
                print("Something Wrong")
            }
            
        }
        
        
        reviewViewModel.getHotelReviewSummary(parentId: (hotelData?.hotel_id)!)
        
        reviewViewModel.hotelReviewSummaryLiveData.bind{
            
            if let resourse : Resourse<Review> = $0 {
                
                if resourse.status == Status.SUCCESS
                    || resourse.status == Status.LOADING {
                    
                    print("Reviews")
                    print(resourse)
                    
                }else {
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
                        
                        self?.hotelData = hotel
                        
                        if hotel.is_user_favourited == "true" {
                            self?.favImageView?.image = UIImage(named: "Favd")
                        }else {
                            self?.favImageView?.image = UIImage(named: "Fav")
                        }
                        
                        if let delegate = self?.delegate {
                            delegate.refreshHotelData()
                        }
                        
                    }
                    
                }else {
                    print("Error in loading data. Message : " + resourse.message)
                }
            }else {
                print("Something Wrong")
            }
        }
        
        hotelViewModel.hotelByHotelIdLiveData.bind{ [weak self] in
            
            if let resourse : Resourse<Hotel> = $0 {
                
                if resourse.status == Status.SUCCESS
                    || resourse.status == Status.LOADING {
                    
                    if let hotel : Hotel = resourse.data {
                        
                        self?.hotelData = hotel
                        
                        DispatchQueue.main.async{
                            
                            self?.collectionView?.reloadData()
                            
                            if let layout = self?.collectionView.collectionViewLayout as? PinterestLayout {
                                layout.reset()
                                
                            }
                            
                            if let delegate = self?.delegate {
                                delegate.refreshHotelData()
                            }
                            
                        }
                    }
                    
                } else if resourse.status == Status.ERROR {
                    print("Error in loading data. Message : " + resourse.message)
                }
            }else {
                print("Something Wrong")
            }
            
        }
        
        
        hotelViewModel.doPostHotelTouchCount(hotelId: (hotelData?.hotel_id)!, loginUserId: super.loginUserId)
        
        hotelViewModel.postHotelTouchCountLiveData.bind{
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
    
    @objc func viewHotelDetail() {
        
        PSNavigationController.instance.navigateToHotelDetail(hotelData: hotelData!, delegate: self)
        PSNavigationController.instance.updateBackButton()

    }
    
    
}


// MARK: - Collection View Datasource extension
extension HotelView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("Section : \(indexPath.section)")
        if indexPath.row == 0 {
            let cellIdentifier = roomViewModel.headerCellId
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! HotelHeaderCollectionViewCell
            
            cell.viewDetailButton.addTarget(self, action: #selector(self.viewHotelDetail), for: .touchUpInside)
            
            if let data = roomViewModel.roomListByHotelIdLiveData.value?.data {
                
                if data.count > indexPath.row {
                    
                    if let hotel = hotelData {
                    
                        cell.hotelData = hotel
                        cell.hotelNameLabel.text = hotel.hotel_name
                        cell.addressLabel.text = hotel.hotel_address
                        cell.guestRatingLabel.text = "\(hotel.rating.final_rating) \(hotel.rating.rating_text)"
                        
                        cell.reviewCountLabel.text = "\(hotel.rating.review_count) \(language.hotel__reviews)"
                        let reviewTap = UITapGestureRecognizer(target: self, action: #selector(HotelView.openReviewList))
                        cell.reviewCountLabel.addGestureRecognizer(reviewTap)
                        
                        cell.showStar(Int(hotel.hotel_star_rating)!)
                        let imageURL = configs.imageUrl + hotel.default_photo.img_path
                        
                        cell.hotelImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "PlaceholderImage"))
                        
                        if hotel.is_user_favourited == "true" {
                            cell.favImageView.image = UIImage(named: "Favd")
                        }else {
                            cell.favImageView.image = UIImage(named: "Fav")
                        }
                        
                        favImageView = cell.favImageView
                        
                        // fav
                        let singleTap2 = UITapGestureRecognizer(target: self, action: #selector(HotelView.clickedFav))
                        cell.favContainerView.addGestureRecognizer(singleTap2)
                        
                        // Gallery
                        let singleTap3 = UITapGestureRecognizer(target: self, action: #selector(HotelView.openGallery))
                        cell.hotelImageView.addGestureRecognizer(singleTap3)
                    }
                    
                }
                
            }
            
            return cell
        }else {
        let cellIdentifier = roomViewModel.cellId
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! RoomCollectionViewCell
        
        if let data = roomViewModel.roomListByHotelIdLiveData.value?.data {
            
            if data.count > indexPath.row - 1 {
                
                if indexPath.row >= 1 {
                
                    let room : Room = data[indexPath.row-1]
                    cell.roomNameLabel.text = room.room_name
                    cell.roomNameLabel.setLineHeight(height: configs.lineSpacing)
                    cell.adultsCountLabel.text = "\(room.room_adult_limit) \(language.hotel__adults)"
                                                + " \(room.room_kid_limit) \(language.hotel__kids)"
                    cell.adultsCountLabel.setLineHeight(height: configs.lineSpacing)
                    
                    cell.bedCountLabel.text = "\(room.room_no_of_beds) \(language.hotel__beds)"
                    cell.bedCountLabel.setLineHeight(height: configs.lineSpacing)
                    
                    cell.areaLabel.text = room.room_size
                    cell.areaLabel.setLineHeight(height: configs.lineSpacing)
                    
                    
                    cell.priceLabel.text = "\(room.currency_symbol) \(room.room_price)"
                    cell.priceLabel.setLineHeight(height: configs.lineSpacing, aligment: .right)
                
                    
                    
                    if (room.promotion.promo_id == "") {
                        cell.promotionView.isHidden = true
                        cell.priceLabel.isHidden = true
                        cell.discountPriceLabel.text = "\(room.currency_symbol) \(room.room_price)"
                        
                    }else {
                        cell.priceLabel.isHidden = false
                        cell.discountPriceLabel.isHidden = false
                        
                        cell.promotionView.isHidden = false
                        cell.promotionPercentLabel.text = "\(room.promotion.promo_percent) \(language.percent)"
                        
                        
                        //Need to update discount price
                        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(room.currency_symbol) \(room.room_price)")
                        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                        
                        cell.priceLabel.attributedText = attributeString
                        
                        
                        
                        let discountPrice = Int((Double(room.promotion.promo_percent)! / 100) * Double(room.room_price)!)
                        
                        cell.discountPriceLabel.text = "\(room.currency_symbol) \(discountPrice)"
                        
                        
                    }
                    
                    //need to check for room available
                    if(Int(room.is_available) == 1) {
                        cell.bookButton.isUserInteractionEnabled = true
                        cell.bookButton.isEnabled = true
                        cell.bookButton.setTitle(language.booking__available , for: .normal)
                        cell.bookButton.backgroundColor = configs.colorPrimary
                        cell.bookButton.setTitleColor(configs.colorTextAlt, for: .normal)
                    } else {
                        cell.bookButton.isUserInteractionEnabled = false
                        cell.bookButton.isEnabled = false
                        cell.bookButton.setTitle(language.booking__not__available, for: .normal)
                        
                        cell.bookButton.setTitleColor(configs.colorDisableText, for: .normal)
                        
                        cell.bookButton.backgroundColor = configs.colorDisable
                    }
                    
                    let imageURL = configs.imageUrl + room.default_photo.img_path
                    
                    cell.roomImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "PlaceholderImage"))
                    cell.bookButton.tag = indexPath.row - 1
                    cell.bookButton.addTarget(self, action: #selector(bookButtonTapped(sender:)), for: UIControl.Event.touchUpInside)
                    
                }
                
            }
            
        }
        
        return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let data = roomViewModel.roomListByHotelIdLiveData.value?.data {
            print("data count \(data.count)")
            return data.count + 1
        }else {
            return 0
        }
        
    }
    
    @objc func openGallery() {
        print("Clicked open Gallery")
        PSNavigationController.instance.navigateToGallery((self.hotelData?.hotel_id)!)
        PSNavigationController.instance.updateBackButton()
    }
    
    @objc func openReviewList() {
        print("Clicked openReviewList")
        PSNavigationController.instance.navigateToReviewList(hotelData: hotelData!, delegate: self)
        PSNavigationController.instance.updateBackButton()
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
    
    @objc func bookButtonTapped(sender: UIButton) {
        print("Clicked Book This Room \(sender.tag)")
        
        if !Connectivity.isConnected() {
            _ = SweetAlert().showAlert(language.hotelTitle, subTitle:  language.error_message__no_internet_connection, style: AlertStyle.error)
            return
        }
        
        if super.loginUserId == configs.default_user {
            // User Havn't Login
            PSNavigationController.instance.navigateToUserLogin(delegate: self)
            PSNavigationController.instance.updateBackButton()
        }else {
            
            if let data = self.roomViewModel.roomListByHotelIdLiveData.value?.data {
                print(data[sender.tag].room_id)
                PSNavigationController.instance.navigateToBookView(hotelId: (hotelData?.hotel_id)!, roomId: data[sender.tag].room_id)
                PSNavigationController.instance.updateBackButton()
            }
            
        }
        
    }
}




// MARK: - Collection View Delegate extension
extension HotelView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ps.print("Selected Index \(indexPath.row)")
        
        if indexPath.row > 0 {
        
            if let data = self.roomViewModel.roomListByHotelIdLiveData.value?.data {
                
                PSNavigationController.instance.navigateToRoomDetail(roomData: data[indexPath.row - 1], delegate: self)
                PSNavigationController.instance.updateBackButton()
            }
            
        }
        
    }
    
}


extension HotelView : LoginViewDelegate {
    func refreshProfileData() {
        super.refreshUserLogin()
    }
    
}

extension HotelView: HotelDetailViewDelegate {
    func refreshHotelData(_ hotel: Hotel) {
        if let imageView = favImageView {
            self.hotelData = hotel
            
            if hotel.is_user_favourited == "true" {
                imageView.image = UIImage(named: "Favd")
            }else {
                imageView.image = UIImage(named: "Fav")
            }
            
            if let delegate = self.delegate {
                delegate.refreshHotelData()
            }
            
            DispatchQueue.main.async{
                
                self.collectionView?.reloadData()
                
                if let layout = self.collectionView.collectionViewLayout as? PinterestLayout {
                    layout.reset()
                    
                }
            }
        }
    }
}

extension HotelView : ReviewListViewDelegate {
    func refreshReviewData() {
        hotelViewModel.getHotelById(loginUserId: loginUserId, hotelId: (hotelData?.hotel_id)!)
    }
    
}

extension HotelView : RoomDetailViewDelegate {
    func refreshHotelData() {
        hotelViewModel.getHotelById(loginUserId: loginUserId, hotelId: (hotelData?.hotel_id)!)
    }
    
}


// MARK: - PinterestLayout Delegate Extension
extension HotelView : PinterestLayoutDelegate {
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath , withWidth width:CGFloat) -> CGFloat {
        
       
            if indexPath.row == 0 {
                // Hotel Summary View
                
                if let data : Hotel = hotelData {
                    let defaultHeight : CGFloat = 494 - 20 - 20
                    let leftRightPadding : CGFloat = 40
                    
                    let hotelNameHeight = Common.instance.heightOfString(for: data.hotel_name , with: customFont.headerUIFont, width: Common.instance.screenSize.width - leftRightPadding, lineHeight: configs.lineSpacing)
                    
                    let hotelAddressHeight = Common.instance.heightOfString(for: data.hotel_address , with: customFont.tagUIFont, width: Common.instance.screenSize.width - leftRightPadding, lineHeight: configs.lineSpacing)
                
                    return defaultHeight
                        + hotelNameHeight
                        + hotelAddressHeight
                    
                }
                
                return 0
            }else {
                
                
                if let dataList = self.roomViewModel.roomListByHotelIdLiveData.value?.data {
                    
                    let data : Room = dataList[indexPath.row - 1]
                    let topBottomPadding : CGFloat = 16
                    let roomNameTop : CGFloat = 16
                    let roomLimitTop : CGFloat = 16
                    let bedTop : CGFloat = 8
                    let areaTop : CGFloat = 8
                    let priceTop : CGFloat = 24
                    let lineAndLineTop : CGFloat = 21
                    
                    let generalHeight = topBottomPadding
                                        + roomNameTop
                                        + roomLimitTop
                                        + bedTop
                                        + areaTop
                                        + priceTop
                                        + lineAndLineTop
                    
                    
                    let leftRightPadding : CGFloat = 40
                    let imageWidth : CGFloat = 118
                    let iconWidthAndRightPadding : CGFloat = 15 + 6
                    let textAreaPadding : CGFloat = 8 + 8
                    let bookHeight : CGFloat = 31
                    
                    let roomNameHeight = Common.instance.heightOfString(for: data.room_name , with: customFont.subHeaderBoldUIFont, width: Common.instance.screenSize.width - (leftRightPadding + imageWidth + textAreaPadding), lineHeight: configs.lineSpacing)
                    
                    let roomLimitHeight = Common.instance.heightOfString(for: "\(data.room_adult_limit) \(language.hotel__adults)"
                        + " \(data.room_kid_limit) \(language.hotel__kids)" , with: customFont.normalUIFont, width: Common.instance.screenSize.width - (leftRightPadding + imageWidth + textAreaPadding + iconWidthAndRightPadding), lineHeight: configs.lineSpacing)
                    
                    let bedCountHeight = Common.instance.heightOfString(for: "\(data.room_no_of_beds) \(language.hotel__beds)" , with: customFont.normalUIFont, width: Common.instance.screenSize.width - (leftRightPadding + imageWidth + textAreaPadding + iconWidthAndRightPadding), lineHeight: configs.lineSpacing)
                    
                    let areaHeight = Common.instance.heightOfString(for: data.room_size , with: customFont.normalUIFont, width: Common.instance.screenSize.width - (leftRightPadding + imageWidth + textAreaPadding + iconWidthAndRightPadding), lineHeight: configs.lineSpacing)
                    
                     let priceHeight = Common.instance.heightOfString(for: "\(data.currency_symbol) \(data.room_price)" , with: customFont.subHeaderBoldUIFont, width: Common.instance.screenSize.width - (leftRightPadding + imageWidth + textAreaPadding ), lineHeight: configs.lineSpacing)
                    
                    return generalHeight
                        + roomNameHeight
                        + roomLimitHeight
                        + bedCountHeight
                        + areaHeight
                        + priceHeight
                        + bookHeight
                    
                }
                
                return 0
            }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if contentHeight >= Common.instance.screenSize.height {
            if offsetY > contentHeight - scrollView.frame.size.height {
                print("going to load")
                if(!roomViewModel.isLoading.value) {
                    print("start loading")
                    roomViewModel.getRoomListByHotelId(hotelId: (hotelData?.hotel_id)!)
                }
            }
        }
    }
}


