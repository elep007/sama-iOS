//
//  BookingListView.swift
//  PSBookings
//
//  Created by Thet Paing Soe on 5/3/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
class BookingListView: PSUIView {
    
    // MARK: Custom Variables
    // NibName of View. This variable will use later in getNibName()
    var bookingViewModel : BookingViewModel = BookingViewModel()
    var uiRefresher : UIRefreshControl?
    
    @IBOutlet weak var bookingListCollectionView: UICollectionView!
    @IBOutlet weak var nodataView: UIView!
    @IBOutlet weak var nodataLabel: UILabel!
    @IBOutlet weak var reloadButton: UIButton!
    
    // MARK: - Override Functions
    override func initVariables() {
        bookingViewModel.nibName = "BookingListView"
        bookingViewModel.cellId = "BookingCollectionViewCell"
    }
    
    override func getNibName() -> String {
        return bookingViewModel.nibName
    }
    
    override func initUIViewAndActions() {
        super.initUIViewAndActions()
        
        setupUI()
        
        
        super.initPinterestCollectionView(collectionView: bookingListCollectionView, nibName: bookingViewModel.cellId, numberOfColumns: 1)
        
        uiRefresher = UIRefreshControl()
        uiRefresher?.attributedTitle = NSAttributedString(string: "Pull To Refresh")
        uiRefresher?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        bookingListCollectionView.addSubview(uiRefresher!)
        
        // Loading Monitoring
        bookingViewModel.isLoading.bind{
            if($0) {
                Common.instance.showBarLoading()
            }else {
                Common.instance.hideBarLoading()
            }
        }
        
    }
    
    func setupUI() {
        nodataLabel.font = customFont.subHeaderUIFont
        nodataLabel.textColor = configs.colorText
    }
    
    
    
    @objc private func refresh() {
        
        if let layout = bookingListCollectionView.collectionViewLayout as? PinterestLayout {
            layout.reset()
        }
        
        bookingViewModel.bookingListOffset = 0
        bookingViewModel.getBookingList(loginUserId: loginUserId)
        uiRefresher?.endRefreshing()
        
    }
    
    @IBAction func reloadClicked(_ sender: Any) {
        
        nodataView.isHidden = true
        bookingViewModel.bookingListOffset = 0
        bookingViewModel.getBookingList(loginUserId: loginUserId)
        uiRefresher?.endRefreshing()
        
    }
    var yy : CGFloat = 0.0
    override func initData() {
        
        bookingViewModel.getBookingList(loginUserId: loginUserId)
        
        bookingViewModel.bookingListLiveData.bind{ [weak self] in
            
            if let newsListResourse : Resourse<[Booking]> = $0 {
                
                if newsListResourse.status == Status.SUCCESS
                    || newsListResourse.status == Status.LOADING {
                    self?.nodataView.isHidden = true
                    DispatchQueue.main.async{
                        let contentOffset = self?.bookingListCollectionView.contentOffset
                        print("Content offset \(String(describing: contentOffset))")
                        self?.bookingListCollectionView?.reloadData()
                    }
                }else if newsListResourse.status == Status.ERROR {
                    self?.reloadButton.isHidden = true
                    if let data = self?.bookingViewModel.bookingListLiveData.value?.data {
                        if data.count <= 0 {
                            self?.bookingListCollectionView?.reloadData()
                            self?.nodataView.isHidden = false
                            self?.nodataLabel.text = newsListResourse.message
                        }
                    }else {
                        self?.bookingListCollectionView?.reloadData()
                        self?.nodataView.isHidden = false
                        self?.nodataLabel.text = newsListResourse.message
                    }
                    self?.nodataLabel.setLineHeight(height: configs.lineSpacing, aligment: .center)
                    
                    
                }else if newsListResourse.status == Status.NETWORK_ERROR {
                    self?.reloadButton.isHidden = false
                    if let data = self?.bookingViewModel.bookingListLiveData.value?.data {
                        if data.count <= 0 {
                            self?.nodataView.isHidden = false
                            self?.nodataLabel.text = newsListResourse.message
                        }
                    }else {
                        self?.nodataView.isHidden = false
                        self?.nodataLabel.text = newsListResourse.message
                    }
                    self?.nodataLabel.setLineHeight(height: configs.lineSpacing, aligment: .center)
                    
                }else {
                    print("Error in loading data. Message : " + newsListResourse.message)
                }
            }else {
                print("Something Wrong")
            }
            
        }
        
        
    }
    
}


// MARK: - Collection View Datasource extension
extension BookingListView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = bookingViewModel.cellId
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! BookingCollectionViewCell
        
        if let data = bookingViewModel.bookingListLiveData.value?.data {
            
            if data.count > indexPath.row {
                
                cell.hotelNameLabel.text = data[indexPath.row].hotel.hotel_name
                cell.hotelNameLabel.setLineHeight(height: configs.lineSpacing)
                
                cell.roomNameLabel.text = data[indexPath.row].room.room_name
                cell.roomNameLabel.setLineHeight(height: configs.lineSpacing)
                
                let startDateAndTime = data[indexPath.row].booking_start_date
                let endDateAndTime = data[indexPath.row].booking_end_date
                
                let startDate = convertDate(dateAndTime: startDateAndTime)
                let endDate = convertDate(dateAndTime: endDateAndTime)
                
                cell.startDayLabel.text = startDate.day
                cell.startMonthLabel.text = startDate.month
                cell.startYearLabel.text = startDate.year
                
                cell.endDayLabel.text = endDate.day
                cell.endMonthLabel.text = endDate.month
                cell.endYearLabel.text = endDate.year
                
                let imageURL = configs.imageUrl + data[indexPath.row].hotel.default_photo.img_path
                
                cell.hotelImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "PlaceholderImage"))
                
                cell.statusLabel.text = data[indexPath.row].booking_status
                
                if(data[indexPath.row].booking_status == "CANCELLED") {
                    cell.statusLabel.textColor = configs.colorCancel
                }else if(data[indexPath.row].booking_status == "CONFIRMED") {
                    cell.statusLabel.textColor = configs.colorConfirm
                }else {
                    cell.statusLabel.textColor = configs.colorTextLight
                }
            }
            
        }
        
        return cell
    }
    
    func convertDate(dateAndTime : String) -> (day: String, month: String, year: String) {
        var date : [String.SubSequence] = []
        if(dateAndTime != "") {
            date = dateAndTime.split(separator: " ")
        }
        
        var dateArr : [String.SubSequence]=[]
        var day = "00"
        var month = "00"
        var year = "0000"
        
        if date.count > 0 {
            
            if(String(date[0]) != "" ) {
                print(String(date[0]))
                dateArr = String(date[0]).split(separator: "-")
            }
            
            if(dateArr.count > 2) {
                day = String(dateArr[2])
            }
            
            if(dateArr.count > 1 ) {
                month = String(dateArr[1])
            }
            
            if(dateArr.count > 0 ) {
                year = String(dateArr[0])
            }
            
        }
        
        return (day, month, year)
    }
    
    func getGuestRatingStr(ratingText: String, finalRating: String ) -> String {
        return "\(ratingText) | \(finalRating)"
    }
    
    func getGuestRatingCountStr(count: String) -> String {
        return "\(count) \(language.hotel__reviews)"
    }
    
    func getPriceStr(minPrice: String, maxPrice: String, currencySymbol: String) -> String {
        return "\(currencySymbol) \(minPrice) ~ \(currencySymbol) \(maxPrice)"
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let data = bookingViewModel.bookingListLiveData.value?.data {
            print("data count \(data.count)")
            return data.count
        }else {
            return 0
        }
        
    }
}




// MARK: - Collection View Delegate extension
extension BookingListView : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ps.print("Selected Index \(indexPath.row)")
        
        if let data = self.bookingViewModel.bookingListLiveData.value?.data {
            PSNavigationController.instance.navigateToBookingDetail(booking: data[indexPath.row])
            PSNavigationController.instance.updateBackButton()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if contentHeight >= Common.instance.screenSize.height {
            if offsetY > contentHeight - scrollView.frame.size.height {
                print("going to load")

                if(!bookingViewModel.isLoading.value) {

                    if contentHeight > 80 {
                        self.yy = contentHeight
                    }
                    bookingViewModel.getBookingList(loginUserId: loginUserId)
                }
            }
        }
    }
    
}


// MARK: - PinterestLayout Delegate Extension
extension BookingListView : PinterestLayoutDelegate {
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath , withWidth width:CGFloat) -> CGFloat {
        
        if let data : Booking = self.bookingViewModel.bookingListLiveData.value?.data![indexPath.row] {
            
            let defaultHeight : CGFloat = 246
            
            let topPaddingHeight: CGFloat = 8
            let bottomPaddingHeight : CGFloat = 2
            let hotelImageHeight : CGFloat = 70
            let hotelNameTopHeight : CGFloat = 12
            let roomNameTopHeight : CGFloat = 8
            let dateTopHeight : CGFloat = 8
            let statusTopHeight : CGFloat = 20
            let statusBottomHieght : CGFloat = 16
            
            let leftAndRightPadding : CGFloat = 16 + 16
            
            let hotelNameHeight = Common.instance.heightOfString(for: data.hotel.hotel_name , with: customFont.headerUIFont, width: Common.instance.screenSize.width - (leftAndRightPadding + 2), lineHeight: configs.lineSpacing)
            print("Hotel Name Height \(hotelNameHeight)")
            let roomNameHeight = Common.instance.heightOfString(for: data.room.room_name , with: customFont.normalUIFont, width: Common.instance.screenSize.width - (leftAndRightPadding + 2), lineHeight: configs.lineSpacing)
            
            print("Room Name Height \(roomNameHeight)")
            let dateHeight = Common.instance.heightOfString(for: "00", with: customFont.bookingDayUIFont, width: Common.instance.screenSize.width - (leftAndRightPadding + 2))
            
            let totalHeight = topPaddingHeight +
                bottomPaddingHeight +
                hotelImageHeight +
                hotelNameTopHeight +
                roomNameTopHeight +
                dateTopHeight +
                statusTopHeight +
                statusBottomHieght +
                hotelNameHeight +
                roomNameHeight +
                dateHeight
            
                
            print("Booking : \(data.hotel.hotel_name)")
            print("Total Height : \(totalHeight) \n\n")
            if totalHeight > defaultHeight {
                return totalHeight
            }
            
            return defaultHeight
            
            // return 246
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        
        return 0
    }
    
}


//extension BookingListView : BookingViewDelegate {
//    func refreshBookingData() {
//        bookingViewModel.favouriteBookingListOffset = 0
//        bookingViewModel.getFavouriteBookingList(loginUserId: loginUserId,
//                                             isLoadFromServer: false)
//    }
//}

