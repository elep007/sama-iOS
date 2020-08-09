//
//  FavouriteListView.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/16/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class FavouriteListView: PSUIView {
    
    // MARK: Custom Variables
    // NibName of View. This variable will use later in getNibName()
    var hotelViewModel : HotelViewModel = HotelViewModel()
    var uiRefresher : UIRefreshControl?
    
    @IBOutlet weak var hotelListCollectionView: UICollectionView!
    @IBOutlet weak var nodataView: UIView!
    @IBOutlet weak var nodataLabel: UILabel!
    @IBOutlet weak var reloadButton: UIButton!
    
    // MARK: - Override Functions
    override func initVariables() {
        hotelViewModel.nibName = "FavouriteListView"
        hotelViewModel.cellId = "HotelCollectionViewCell"
    }
    
    override func getNibName() -> String {
        return hotelViewModel.nibName
    }
    
    override func initUIViewAndActions() {
        super.initUIViewAndActions()
        
        setupUI()
        
        
        super.initPinterestCollectionView(collectionView: hotelListCollectionView, nibName: hotelViewModel.cellId, numberOfColumns: 1)
        
        uiRefresher = UIRefreshControl()
        uiRefresher?.attributedTitle = NSAttributedString(string: "Pull To Refresh")
        uiRefresher?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        hotelListCollectionView.addSubview(uiRefresher!)
        
        // Loading Monitoring
        hotelViewModel.isLoading.bind{
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
        
        if let layout = hotelListCollectionView.collectionViewLayout as? PinterestLayout {
            layout.reset()
        }
        
        
        hotelViewModel.favouriteHotelListOffset = 0
        hotelViewModel.getFavouriteHotelList(loginUserId: loginUserId)
        uiRefresher?.endRefreshing()
        
    }
    
    @IBAction func reloadClicked(_ sender: Any) {
        
        nodataView.isHidden = true
        hotelViewModel.favouriteHotelListOffset = 0
        hotelViewModel.getFavouriteHotelList(loginUserId: loginUserId)
        uiRefresher?.endRefreshing()
        
    }
    var yy : CGFloat = 0.0
    override func initData() {
        
        hotelViewModel.getFavouriteHotelList(loginUserId: loginUserId)
        
        hotelViewModel.favouriteHotelLiveData.bind{ [weak self] in
            
            if let newsListResourse : Resourse<[Hotel]> = $0 {
                
                if newsListResourse.status == Status.SUCCESS
                    || newsListResourse.status == Status.LOADING {
                    self?.nodataView.isHidden = true
                    DispatchQueue.main.async{
                        let contentOffset = self?.hotelListCollectionView.contentOffset
                        print("Content offset \(String(describing: contentOffset))")
                        self?.hotelListCollectionView?.reloadData()
                        
                    }
                    
                }else if newsListResourse.status == Status.ERROR {
                    self?.reloadButton.isHidden = true
                    if let data = self?.hotelViewModel.favouriteHotelLiveData.value?.data {
                        if data.count <= 0 {
                            self?.hotelListCollectionView?.reloadData()
                            self?.nodataView.isHidden = false
                            self?.nodataLabel.text = newsListResourse.message
                        }
                    }else {
                        self?.hotelListCollectionView?.reloadData()
                        self?.nodataView.isHidden = false
                        self?.nodataLabel.text = newsListResourse.message
                    }
                    self?.nodataLabel.setLineHeight(height: configs.lineSpacing, aligment: .center)
                    
                    
                    
                }else if newsListResourse.status == Status.NETWORK_ERROR {
                    self?.reloadButton.isHidden = false
                    if let data = self?.hotelViewModel.favouriteHotelLiveData.value?.data {
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
extension FavouriteListView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = hotelViewModel.cellId
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! HotelCollectionViewCell
        
        if let data = hotelViewModel.favouriteHotelLiveData.value?.data {
            
            if data.count > indexPath.row {
                
                print( data[indexPath.row].hotel_star_rating + " " + data[indexPath.row].hotel_name)
                
                cell.hotelNameLabel.text = data[indexPath.row].hotel_name
                cell.hotelNameLabel.setLineHeight(height: configs.lineSpacing)
                
                cell.addressLabel.text = data[indexPath.row].hotel_address
                cell.addressLabel.setLineHeight(height: configs.lineSpacing)
                
                cell.guestRatingLabel.text = getGuestRatingStr(ratingText: data[indexPath.row].rating.rating_text, finalRating: data[indexPath.row].rating.final_rating)
                
                cell.reviewCountLabel.text = getGuestRatingCountStr(count:  data[indexPath.row].rating.review_count )
                
                if data[indexPath.row].promotion.promo_id == "" {
                    cell.promotionView.isHidden = true
                }else {
                    cell.promotionView.isHidden = false
                    cell.percentLabel.text = data[indexPath.row].promotion.promo_percent + language.percent
                }
                
                cell.showStar(Int(data[indexPath.row].hotel_star_rating)!)
                cell.priceRangeLabel.text = getPriceStr(minPrice: data[indexPath.row].hotel_min_price, maxPrice: data[indexPath.row].hotel_max_price, currencySymbol: data[indexPath.row].currency_symbol)
                
                let imageURL = configs.imageUrl + data[indexPath.row].default_photo.img_path
                
                cell.newsImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "PlaceholderImage"))
                
            }
            
        }
        
        return cell
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
        
        if let data = hotelViewModel.favouriteHotelLiveData.value?.data {
            print("data count \(data.count)")
            return data.count
        }else {
            return 0
        }
        
    }
}




// MARK: - Collection View Delegate extension
extension FavouriteListView : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ps.print("Selected Index \(indexPath.row)")
        
        if let data = self.hotelViewModel.favouriteHotelLiveData.value?.data {
            PSNavigationController.instance.navigateToHotel(hotelData: data[indexPath.row], delegate: self)
            PSNavigationController.instance.updateBackButton()
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if contentHeight >= Common.instance.screenSize.height {
            if offsetY > contentHeight - scrollView.frame.size.height {
                print("going to load")
                
                if(!hotelViewModel.isLoading.value) {
                    
                    if contentHeight > 80 {
                        self.yy = contentHeight
                    }
                    hotelViewModel.getFavouriteHotelList(loginUserId: loginUserId)
                }
            }
        }
    }
    
}


// MARK: - PinterestLayout Delegate Extension
extension FavouriteListView : PinterestLayoutDelegate {
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath , withWidth width:CGFloat) -> CGFloat {
        
        if let data : Hotel = self.hotelViewModel.favouriteHotelLiveData.value?.data![indexPath.row] {
            
            let defaultHeight : CGFloat = 222
            
            let topPaddingHeight: CGFloat = 8
            let hotelLableTop: CGFloat = 15
            let ratingTop : CGFloat = 8
            let ratingHeight : CGFloat = 30
            let addressTop : CGFloat = 6
            let reviewTop : CGFloat = 18
            let reviewCountTop : CGFloat = 8
            let priceTop: CGFloat = 31.5
            let priceBottom : CGFloat = 7.5
            let bottomPaddingHeight : CGFloat = 2
            
            
            let leftAndRightPadding : CGFloat = 16 + 16
            let imageWidth : CGFloat = 118
            let locationIconWithPadding : CGFloat = 15 + 6
            let reviewIconWithPadding : CGFloat = 30 + 8
            
            let hotelNameHeight = Common.instance.heightOfString(for: data.hotel_name , with: customFont.headerUIFont, width: Common.instance.screenSize.width - (imageWidth + leftAndRightPadding + 1), lineHeight: configs.lineSpacing)
            print("Screen Width \(Common.instance.screenSize.width)")
            print("Hotel Height \(hotelNameHeight)")
            let hotelAddressHeight = Common.instance.heightOfString(for: data.hotel_address , with: customFont.tagUIFont, width: Common.instance.screenSize.width - (imageWidth + leftAndRightPadding + locationIconWithPadding), lineHeight: configs.lineSpacing)
            print("hotelAddressHeight \(hotelAddressHeight)")
            let reivewHeight = Common.instance.heightOfString(for: getGuestRatingStr(ratingText: data.rating.rating_text, finalRating: data.rating.final_rating), with: customFont.subHeaderUIFont, width: Common.instance.screenSize.width - (imageWidth + leftAndRightPadding + reviewIconWithPadding))
            print("reivewHeight \(reivewHeight)")
            let reviewCountHeight = Common.instance.heightOfString(for: getGuestRatingCountStr(count: data.rating.review_count), with: customFont.tagUIFont, width: Common.instance.screenSize.width - (imageWidth + leftAndRightPadding + reviewIconWithPadding))
            print("reviewCountHeight \(reviewCountHeight)")
            let priceHeight = Common.instance.heightOfString(for: getPriceStr(minPrice: data.hotel_min_price, maxPrice: data.hotel_max_price, currencySymbol: data.currency_symbol), with: customFont.subHeaderBoldUIFont, width: Common.instance.screenSize.width - (imageWidth + leftAndRightPadding))
            print("priceHeight \(priceHeight)")
            let totalHeight = topPaddingHeight +
                hotelLableTop +
                ratingTop +
                ratingHeight +
                addressTop +
                reviewTop +
                reviewCountTop +
                priceTop +
                priceBottom +
                bottomPaddingHeight +
                hotelNameHeight +
                hotelAddressHeight +
                reivewHeight +
                reviewCountHeight +
            priceHeight
            print("Hotel : \(data.hotel_name)")
            print("Total Height : \(totalHeight) \n\n")
            if totalHeight > defaultHeight {
                return totalHeight
            }
           
            return defaultHeight
            
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        
        return 0
    }
    
}


extension FavouriteListView : HotelViewDelegate {
    func refreshHotelData() {
        hotelViewModel.favouriteHotelListOffset = 0
        hotelViewModel.getFavouriteHotelList(loginUserId: loginUserId,
                                             isLoadFromServer: false)
    }
}
