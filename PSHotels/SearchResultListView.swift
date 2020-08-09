//
//  SearchResultListView.swift
//  PSHotels
//
//  Created by Panacea-Soft on 2/13/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation

class SearchResultListView: PSUIView {
    
    // MARK: Custom Variables
    // NibName of View. This variable will use later in getNibName()
    var hotelViewModel : HotelViewModel = HotelViewModel()
    var hotelFeatureViewModel : HotelFeatureViewModel = HotelFeatureViewModel()
    var uiRefresher : UIRefreshControl?
    var cityId: String = ""
    var hotelName : String = ""
    var starRating : String = ""
    var lowerPrice : String = ""
    var upperPrice : String = ""
    var guestRating : String = ""
    var infoType : String = ""
    var maxPrice : Price? = nil
    
    @IBOutlet weak var newsListCollectionView: UICollectionView!
    @IBOutlet weak var nodataView: UIView!
    @IBOutlet weak var nodataLabel: UILabel!
    @IBOutlet weak var reloadButton: UIButton!
    
    
    // MARK: - Override Functions
    override func initVariables() {
        hotelViewModel.nibName = "SearchResultListView"
        hotelViewModel.cellId = "HotelCollectionViewCell"
    }
    
    // joining NewsListView.swift and NewsListView.xib
    override func getNibName() -> String {
        return hotelViewModel.nibName
    }
    
    override func initUIViewAndActions() {
        super.initUIViewAndActions()
        
        setupUI()
        
        super.initPinterestCollectionView(collectionView: newsListCollectionView, nibName: hotelViewModel.cellId, numberOfColumns: 1)

        uiRefresher = UIRefreshControl()
        uiRefresher?.attributedTitle = NSAttributedString(string: "Pull To Refresh")
        uiRefresher?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        newsListCollectionView.addSubview(uiRefresher!)
        
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
    
    func getGuestRatingStr(ratingText: String, finalRating: String ) -> String {
        return "\(ratingText) | \(finalRating)"
    }
    
    func getGuestRatingCountStr(count: String) -> String {
        return "\(count) \(language.hotel__reviews)"
    }
    
    func getPriceStr(minPrice: String, maxPrice: String, currencySymbol: String) -> String {
        return "\(currencySymbol) \(minPrice) ~ \(currencySymbol) \(maxPrice)"
    }
    
    @objc private func refresh() {
        // Load data from PS Server
        hotelViewModel.postSearchHotelListOffset = 0
        hotelViewModel.postSearchHotels(cityId: cityId,
                                        loginUserId: loginUserId,
                                        hotelName: hotelName,
                                        starRating: starRating,
                                        lowerPrice: lowerPrice,
                                        upperPrice: upperPrice,
                                        infoType: infoType,
                                        guestRating: guestRating)
        
        uiRefresher?.endRefreshing()
        
    }
    
    func filterHotelClicked() {
        PSNavigationController.instance.navigateToHotelFilter(self,
                                                              hotelStarStr: starRating ,
                                                              lowerPrice: lowerPrice,
                                                              upperPrice: upperPrice,
                                                              guestRating: guestRating,
                                                              maxPrice: maxPrice!,
                                                              cityId: cityId,
                                                              infoType: infoType)
        PSNavigationController.instance.updateBackButton()
    }
    
    @IBAction func reloadClicked(_ sender: Any) {
        
        nodataView.isHidden = true
        
        hotelViewModel.postSearchHotelListOffset = 0
        hotelViewModel.postSearchHotels(cityId: cityId,
                                        loginUserId: loginUserId,
                                        hotelName: hotelName,
                                        starRating: starRating,
                                        lowerPrice: lowerPrice,
                                        upperPrice: upperPrice,
                                        infoType: infoType,
                                        guestRating: guestRating)
        
        uiRefresher?.endRefreshing()
        
    }
    
    override func initData() {
        
        hotelViewModel.postSearchHotels(cityId: cityId,
                                        loginUserId: loginUserId,
                                        hotelName: hotelName,
                                        starRating: starRating,
                                        lowerPrice: lowerPrice,
                                        upperPrice: upperPrice,
                                        infoType: infoType,
                                        guestRating: guestRating)
        
        hotelViewModel.postSearchHotelLiveData.bind{ [weak self] in
            
            if let newsListResourse : Resourse<[Hotel]> = $0 {
                
                if newsListResourse.status == Status.SUCCESS
                    || newsListResourse.status == Status.LOADING {
                    self?.nodataView.isHidden = true
                    DispatchQueue.main.async{
                        
                        self?.newsListCollectionView?.reloadData()
                  
                    }
                    
                }else if newsListResourse.status == Status.ERROR {
                    self?.reloadButton.isHidden = true
                    if let data = self?.hotelViewModel.postSearchHotelLiveData.value?.data {
                        if data.count <= 0 {
                            self?.newsListCollectionView?.reloadData()
                            self?.nodataView.isHidden = false
                            self?.nodataLabel.text = newsListResourse.message
                        }
                    }else {
                        self?.newsListCollectionView?.reloadData()
                        self?.nodataView.isHidden = false
                        self?.nodataLabel.text = newsListResourse.message
                    }
                    self?.nodataLabel.setLineHeight(height: configs.lineSpacing, aligment: .center)
                    
                    
                    
                }else if newsListResourse.status == Status.NETWORK_ERROR {
                    self?.reloadButton.isHidden = false
                    if let data = self?.hotelViewModel.postSearchHotelLiveData.value?.data {
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
        
        
        hotelFeatureViewModel.getHotelFeatures(cityId: cityId)
        hotelFeatureViewModel.hotelFeatureListByCityIdLiveData.bind{
            
            if let resourseList : Resourse<[HotelFeature]> = $0 {
                
                if resourseList.status == Status.SUCCESS ||
                    resourseList.status == Status.LOADING {
                    
                    print(resourseList)
                    
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
    
}


// MARK: - Collection View Datasource extension
extension SearchResultListView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = hotelViewModel.cellId
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! HotelCollectionViewCell
        
        print("Section \(indexPath.section)")
        
        if let data = hotelViewModel.postSearchHotelLiveData.value?.data {
            
            if data.count > indexPath.row {
                
                print( data[indexPath.row].hotel_star_rating + " " + data[indexPath.row].hotel_name)
                
                cell.hotelNameLabel.text = data[indexPath.row].hotel_name
                cell.hotelNameLabel.setLineHeight(height: configs.lineSpacing)
                
                cell.addressLabel.text = data[indexPath.row].hotel_address
                cell.addressLabel.setLineHeight(height: configs.lineSpacing)
                cell.priceRangeLabel.text = data[indexPath.row].hotel_min_price + " ~ " + data[indexPath.row].hotel_max_price
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let data = hotelViewModel.postSearchHotelLiveData.value?.data {
            print("data count \(data.count)")
            return data.count
        }else {
            return 0
        }
        
    }
}




// MARK: - Collection View Delegate extension
extension SearchResultListView : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ps.print("Selected Index \(indexPath.row)")
        
        if let data = self.hotelViewModel.postSearchHotelLiveData.value?.data {
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
                    print("start loading")
                    hotelViewModel.postSearchHotels(cityId: cityId,
                                                    loginUserId: loginUserId,
                                                    hotelName: hotelName,
                                                    starRating: starRating,
                                                    lowerPrice: lowerPrice,
                                                    upperPrice: upperPrice,
                                                    infoType: infoType,
                                                    guestRating: guestRating)
                }
            }
        }
    }
    
}


extension SearchResultListView : HotelFilterProtocol {
    func selectFilter(hotelStars: String, lowerPrice: String, upperPrice: String, guestRating: String, features: String) {
        
        self.starRating = hotelStars
        self.lowerPrice = lowerPrice
        self.upperPrice = upperPrice
        self.guestRating = guestRating
        self.infoType = features

        hotelViewModel.postSearchHotelListOffset = 0
        hotelViewModel.postSearchHotels(cityId: cityId,
                                        loginUserId: loginUserId,
                                        hotelName: hotelName,
                                        starRating: starRating,
                                        lowerPrice: lowerPrice,
                                        upperPrice: upperPrice,
                                        infoType: infoType,
                                        guestRating: guestRating)
    }
    
    
}


// MARK: - PinterestLayout Delegate Extension
extension SearchResultListView : PinterestLayoutDelegate {
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath , withWidth width:CGFloat) -> CGFloat {
        
        if let data : Hotel = self.hotelViewModel.postSearchHotelLiveData.value?.data![indexPath.row] {
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

extension SearchResultListView : HotelViewDelegate {
    func refreshHotelData() {
        hotelViewModel.postSearchHotels(cityId: cityId,
                                        loginUserId: loginUserId,
                                        hotelName: hotelName,
                                        starRating: starRating,
                                        lowerPrice: lowerPrice,
                                        upperPrice: upperPrice,
                                        infoType: infoType,
                                        guestRating: guestRating,
                                        isLoadFromServer: false)
    }
}


