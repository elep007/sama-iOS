//
//  RoomReviewListView.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/20/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

//MARK: Protocolas
protocol RoomReviewListViewDelegate : class {
    func refreshReviewData()
}


@IBDesignable
class RoomReviewListView: PSUIView {
    
    // MARK: Custom Variables
    let reviewViewModel : ReviewViewModel = ReviewViewModel()
    //var hotelData: Hotel? = nil
    var roomData: Room? = nil
    var reviewSummaryCount = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    var delegate : RoomReviewListViewDelegate? = nil
    
    // MARK: - Override Functions
    override func initVariables() {
        reviewViewModel.nibName = "RoomReviewListView"
        reviewViewModel.cellId = "ReviewCollectionViewCell"
        reviewViewModel.headerCellId = "ReviewSummaryCollectionViewCell"
    }
    
    // joining NewsListView.swift and NewsListView.xib
    override func getNibName() -> String {
        return reviewViewModel.nibName
    }
    
    override func initUIViewAndActions() {
        super.initUIViewAndActions()
        
        super.initPinterestCollectionView(collectionView: collectionView,
                                          nibName: reviewViewModel.cellId,
                                          nibHeaderName: reviewViewModel.headerCellId,
                                          numberOfColumns: 1)
        
        // Loading Monitoring
        reviewViewModel.isLoading.bind{
            if($0) {
                Common.instance.showBarLoading()
                
            }else {
                Common.instance.hideBarLoading()
                
            }
        }
        
    }
    
    override func initData() {
        reviewViewModel.getRoomReviewSummary(parentId: (roomData?.room_id)!)
        
        reviewViewModel.roomReviewSummaryLiveData.bind{ [weak self] in
            
            if let newsListResourse : Resourse<Review> = $0 {
                
                if newsListResourse.status == Status.SUCCESS
                    || newsListResourse.status == Status.LOADING {
                    
                    DispatchQueue.main.async{
                        self?.reviewSummaryCount = 1
                        
                    }
                    
                }else {
                    print("Error in loading data. Message : " + newsListResourse.message)
                }
            }else {
                print("Something Wrong")
            }
            
        }
        
        reviewViewModel.getRoomReviewDetail(parentId: (roomData?.room_id)!)
        
        reviewViewModel.roomReviewDetailLiveData.bind{ [weak self] in
            
            if let listResourse : Resourse<[ReviewDetail]> = $0 {
                
                if listResourse.status == Status.SUCCESS
                    || listResourse.status == Status.LOADING {
                    
                    DispatchQueue.main.async{
                        self?.collectionView?.reloadData()
                    }
                    
                }else if listResourse.status == Status.ERROR {
                    if let data = self?.reviewViewModel.roomReviewDetailLiveData.value?.data {
                        if data.count <= 0 {
                            self?.reviewSummaryCount = 0
                        }
                    }else {
                        self?.reviewSummaryCount = 0
                    }
                    
                    DispatchQueue.main.async{
                        self?.collectionView?.reloadData()
                    }
                    
                } else {
                    print("Error in loading data. Message : " + listResourse.message)
                }
            }else {
                print("Something Wrong")
            }
            
        }
        
    }
    
    func reviewEntryClicked() {
        print("clicked review entry")
        
        PSNavigationController.instance.navigateToReviewSubmit(roomData: roomData!, delegate: self)
        PSNavigationController.instance.updateBackButton()
    }
}




// MARK: - Collection View Datasource extension
extension RoomReviewListView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("Section : \(indexPath.section)")
        if indexPath.row == 0 {
            let cellIdentifier = reviewViewModel.headerCellId
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ReviewSummaryCollectionViewCell
            
            if let data = reviewViewModel.roomReviewSummaryLiveData.value?.data {
                
                
                cell.ratingLabel.text = "\(data.rating.rating_text) \(data.rating.final_rating)"
                
                cell.reviewLabel.text = "\(data.rating.review_count) \(language.hotel__reviews)"
                
                
                // Rating 1
                if data.review_categories.count > 0 {
                    
                    cell.rating1TitleLabel.text = data.review_categories[0].rvcat_name
                    
                    let rating1 : Float = Float(data.review_categories[0].rating.final_rating)! / 5
                    
                    cell.rating1ProgressBar.progress = rating1
                    
                    cell.rating1Label.text = "\(data.review_categories[0].rating.final_rating)"
                }else {
                    cell.rating1View.isHidden = true
                }
                
                // Rating 2
                if data.review_categories.count > 1 {
                    
                    cell.rating2TitleLabel.text = data.review_categories[1].rvcat_name
                    
                    let rating2 : Float = Float(data.review_categories[1].rating.final_rating)! / 5
                    
                    cell.rating2ProgressBar.progress = rating2
                    
                    cell.rating2Label.text = "\(data.review_categories[1].rating.final_rating)"
                }else {
                    cell.rating2View.isHidden = true
                }
                
                // Rating 3
                if data.review_categories.count > 2 {
                    
                    cell.rating3TitleLabel.text = data.review_categories[2].rvcat_name
                    
                    let rating3 : Float = Float(data.review_categories[2].rating.final_rating)! / 5
                    
                    cell.rating3ProgressBar.progress = rating3
                    
                    cell.rating3Label.text = "\(data.review_categories[2].rating.final_rating)"
                }else {
                    cell.rating3View.isHidden = true
                }
                
                // Rating 4
                if data.review_categories.count > 3 {
                    
                    cell.rating4TitleLabel.text = data.review_categories[3].rvcat_name
                    
                    let rating4 : Float = Float(data.review_categories[3].rating.final_rating)! / 5
                    
                    cell.rating4ProgressBar.progress = rating4
                    
                    cell.rating4Label.text = "\(data.review_categories[3].rating.final_rating)"
                }else {
                    cell.rating4View.isHidden = true
                }
                
                // Rating 5
                if data.review_categories.count > 4 {
                    
                    cell.rating5TitleLabel.text = data.review_categories[4].rvcat_name
                    
                    let rating5 : Float = Float(data.review_categories[4].rating.final_rating)! / 5
                    
                    cell.rating5ProgressBar.progress = rating5
                    
                    cell.rating5Label.text = "\(data.review_categories[4].rating.final_rating)"
                }else {
                    cell.rating5View.isHidden = true
                }
                
                
            }
            
            return cell
        }else {
            let cellIdentifier = reviewViewModel.cellId
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ReviewCollectionViewCell
            
            if let data = reviewViewModel.roomReviewDetailLiveData.value?.data {
                
                if data.count > indexPath.row - 1 {
                    
                    if indexPath.row >= 1 {
                        
                        let reviewDetail : ReviewDetail = data[indexPath.row-1]
                        cell.reviewLabel.text = reviewDetail.review_desc
                        cell.reviewLabel.setLineHeight(height: configs.lineSpacing)
                        cell.ratingLabel.text = "\(reviewDetail.rating.rating_text) \(reviewDetail.rating.final_rating)"
                        cell.nameLabel.text = reviewDetail.user.user_name
                        cell.nameLabel.setLineHeight(height: configs.lineSpacing)
                        cell.dateLabel.text = reviewDetail.added_date_str
                        cell.roomLabel.text = "Room : " + reviewDetail.room_name
                        let imageURL = configs.imageUrl + reviewDetail.user.user_profile_photo
                        
                        cell.profileImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "PlaceholderImage"))
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
        
        var rtnReviewCount = 0
        
        rtnReviewCount = rtnReviewCount + reviewSummaryCount
        if let data = reviewViewModel.roomReviewDetailLiveData.value?.data {
            rtnReviewCount = rtnReviewCount + data.count
        }
        
        return rtnReviewCount
        
    }
}




// MARK: - Collection View Delegate extension
extension RoomReviewListView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ps.print("Selected Index \(indexPath.row)")
        
    }
    
}


// MARK: - PinterestLayout Delegate Extension
extension RoomReviewListView : PinterestLayoutDelegate {
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath , withWidth width:CGFloat) -> CGFloat {
        
        if indexPath.row == 0 {
            return 350
        }else {
            
            if let data = reviewViewModel.roomReviewDetailLiveData.value?.data {
                
                if data.count > indexPath.row - 1 {
                    
                    if indexPath.row >= 1 {
                        
                        let data : ReviewDetail = data[indexPath.row-1]
                        
                        let topPaddingHeight: CGFloat = 16
                        let bottomPaddingHeight: CGFloat = 6.5
                        let leftPadding: CGFloat = 16
                        let rightPadding : CGFloat = 16
                        let leftRightPadding : CGFloat = leftPadding + rightPadding
                        let imageRightPadding: CGFloat = 16
                        let imageWidth : CGFloat = 60
                        let nameBottomPaddingHeight : CGFloat = 8
                        let ratingBottomPaddingHeight : CGFloat = 8
                        let reviewBottomPaddingHeight : CGFloat = 8
                        let dateBottomPaddingHeight : CGFloat = 18.5
                        let lineHeight : CGFloat = 1
                        
                        let nameHeight = Common.instance.heightOfString(for: data.user.user_name,
                                                                        with: customFont.normalBoldUIFont,
                                                                        width: Common.instance.screenSize.width - ( leftRightPadding + imageWidth + imageRightPadding ),
                                                                        lineHeight: configs.lineSpacing)
                        
                        let ratingHeight = Common.instance.heightOfString(for: "\(data.rating.rating_text) \(data.rating.final_rating)",
                            with: customFont.normalUIFont,
                            width: Common.instance.screenSize.width - ( leftRightPadding + imageWidth + imageRightPadding))
                        
                        let reviewHeight = Common.instance.heightOfString(for: data.review_desc,
                                                                          with: customFont.normalUIFont,
                                                                          width: Common.instance.screenSize.width - ( leftRightPadding + imageWidth + imageRightPadding ),
                                                                          lineHeight: configs.lineSpacing)
                        
                        let dateHeight = Common.instance.heightOfString(for: "\(data.rating.rating_text) \(data.rating.final_rating)",
                            with: customFont.tagUIFont,
                            width: Common.instance.screenSize.width - ( leftRightPadding + imageWidth + imageRightPadding))
                        
                        return topPaddingHeight
                            + nameHeight
                            + nameBottomPaddingHeight
                            + ratingHeight
                            + ratingBottomPaddingHeight
                            + reviewHeight
                            + reviewBottomPaddingHeight
                            + dateHeight
                            + dateBottomPaddingHeight
                            + lineHeight
                            + bottomPaddingHeight
                        
                    }
                }
            }
            
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        
        return 0
    }
    
}

extension RoomReviewListView : ReviewSubmitViewDelegate {
    func refreshReviewList() {
        print("**** Refresh List")
        
        reviewViewModel.hotelReviewDetailListOffset = 0
        
        reviewViewModel.getRoomReviewSummary(parentId: (roomData?.room_id)!)
        reviewViewModel.getRoomReviewDetail(parentId: (roomData?.room_id)!)
        
        if let d = self.delegate {
            d.refreshReviewData()
        }
        
    }
    
}
