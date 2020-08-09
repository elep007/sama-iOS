//
//  ReviewSubmitView.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/9/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

//MARK: Protocolas
protocol ReviewSubmitViewDelegate : class {
    func refreshReviewList()
}

@IBDesignable
class ReviewSubmitView: PSUIView {

    // MARK: Custom Variables
    let reviewViewModel : ReviewViewModel = ReviewViewModel()
    let reviewCategoryViewModel : ReviewCategoryViewModel = ReviewCategoryViewModel()
    
    var hotelData: Hotel? = nil
    var roomData: Room? = nil
    var selectedRoom : Room? = nil
    var delegate: ReviewSubmitViewDelegate? = nil
    var parentView: UIViewController? = nil
    var localData : [ReviewCategory]? = nil
    
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var roomNameLabel: UILabel!
    
    @IBOutlet weak var rating1TitleLabel: UILabel!
    @IBOutlet weak var rating1Label: UILabel!
    @IBOutlet weak var rating1Slider: UISlider!
    
    @IBOutlet weak var rating2TitleLabel: UILabel!
    @IBOutlet weak var rating2Label: UILabel!
    @IBOutlet weak var rating2Slider: UISlider!
    
    @IBOutlet weak var rating3TitleLabel: UILabel!
    @IBOutlet weak var rating3Label: UILabel!
    @IBOutlet weak var rating3Slider: UISlider!
    
    @IBOutlet weak var rating4TitleLabel: UILabel!
    @IBOutlet weak var rating4Label: UILabel!
    @IBOutlet weak var rating4Slider: UISlider!
    
    @IBOutlet weak var rating5TitleLabel: UILabel!
    @IBOutlet weak var rating5Label: UILabel!
    @IBOutlet weak var rating5Slider: UISlider!
    
    @IBOutlet weak var messageTitleLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    
    @IBOutlet weak var submitButton: UIButton!
    
    
    // MARK: - Override Functions
    override func initVariables() {
        reviewViewModel.nibName = "ReviewSubmitView"
    }
    
    // joining NewsListView.swift and NewsListView.xib
    override func getNibName() -> String {
        return reviewViewModel.nibName
    }
    
    override func initUIViewAndActions() {
        super.initUIViewAndActions()
        
        setupUI()
        
        if let room : Room = roomData {
            roomLabel.text = room.room_name
            self.selectedRoom = room
        }else {
        
            let singleTap = UITapGestureRecognizer(target: self, action: #selector(ReviewSubmitView.openRoomFilter))
            roomLabel.addGestureRecognizer(singleTap)
        }
    }
    
    override func initData() {
        reviewViewModel.postReviewLiveData.bind{ [weak self] in
            
            if let resourseList : Resourse<ApiStatus> = $0 {
                
                if resourseList.status == Status.SUCCESS ||
                    resourseList.status == Status.LOADING {
                    
                    self?.delegate?.refreshReviewList()
                    self?.closeView()
                    
                }else if resourseList.status == Status.ERROR {
                    
                    print("1 Error in loading data. Message : " + resourseList.message)
                    
                }else {
                    print("Error in loading data. Message : " + resourseList.message)
                }
            }else {
                print("Something Wrong")
            }
            
        }
        
        reviewCategoryViewModel.getReviewCategoryList()
        
        reviewCategoryViewModel.reviewCategoryLiveData.bind{ [weak self] in
            
            if let newsListResourse : Resourse<[ReviewCategory]> = $0 {
                
                if newsListResourse.status == Status.SUCCESS
                    || newsListResourse.status == Status.LOADING {
                    
                    self?.bindData(newsListResourse.data!)
                    
                }else {
                    print("Error in loading data. Message : " + newsListResourse.message)
                }
            }else {
                print("Something Wrong")
            }
            
        }
    }
    
    func closeView() {
        parentView?.navigationController?.popViewController(animated: true)
        parentView?.dismiss(animated: true, completion: nil)
    }
    
    @objc func openRoomFilter() {
        PSNavigationController.instance.navigateToReviewRoomFilter(self, hotelData: hotelData!)
        PSNavigationController.instance.updateBackButton()
    }
    
    @IBAction func rating1ValueChanged(_ sender: Any) {
        rating1Label.text = "\(ceil(rating1Slider.value))"
    }
    
    @IBAction func rating2ValueChanged(_ sender: Any) {
        rating2Label.text = "\(ceil(rating2Slider.value))"
    }
    
    @IBAction func rating3ValueChanged(_ sender: Any) {
        rating3Label.text = "\(ceil(rating3Slider.value))"
    }
    
    @IBAction func rating4ValueChanged(_ sender: Any) {
        rating4Label.text = "\(ceil(rating4Slider.value))"
    }
    
    @IBAction func rating5ValueChanged(_ sender: Any) {
        rating5Label.text = "\(ceil(rating5Slider.value))"
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        
        if super.loginUserId == configs.default_user {
            // User Havn't Login
            PSNavigationController.instance.navigateToUserLogin(delegate: self)
            PSNavigationController.instance.updateBackButton()
        }else {
            
            // check room id
            if selectedRoom?.room_id == nil || selectedRoom?.room_id == "" {
                _ = SweetAlert().showAlert(language.psTitle, subTitle:  language.error_message__blank_room, style: AlertStyle.warning)
                return
            }
            
            // check all rating
            if rating1Label.text == "0.0" {
                
                _ = SweetAlert().showAlert(language.psTitle, subTitle:  "\(language.error_message__blank_input) \(rating1TitleLabel.text!)" , style: AlertStyle.warning)
                return
            }
            
            if rating2Label.text == "0.0" {
                
                _ = SweetAlert().showAlert(language.psTitle, subTitle:  "\(language.error_message__blank_input) \(rating2TitleLabel.text!)", style: AlertStyle.warning)
                return
            }
            
            if rating3Label.text == "0.0" {
                
                _ = SweetAlert().showAlert(language.psTitle, subTitle:  "\(language.error_message__blank_input) \(rating3TitleLabel.text!)", style: AlertStyle.warning)
                return
            }
            
            if rating4Label.text == "0.0" {
                
                _ = SweetAlert().showAlert(language.psTitle, subTitle:  "\(language.error_message__blank_input) \(rating4TitleLabel.text!)", style: AlertStyle.warning)
                return
            }
            
            if rating5Label.text == "0.0" {
                
                _ = SweetAlert().showAlert(language.psTitle, subTitle:  "\(language.error_message__blank_input) \(rating5TitleLabel.text!)", style: AlertStyle.warning)
                return
            }
            
            // check desc
            if messageTextView.text == "" {
                _ = SweetAlert().showAlert(language.psTitle, subTitle:  language.error_message__blank_message, style: AlertStyle.warning)
                return
            }
            
            
            // prepare rating
            let ratingJSON = prepareRatingJson()
            print(ratingJSON)
            
            // submit to server
            reviewViewModel.doPostReview(roomId: (selectedRoom?.room_id)!, loginUserId: loginUserId, desc: messageTextView.text, ratingObjArr: ratingJSON)
        
            
        }
    }
    
    func prepareRatingJson() -> [RatingPostObject] {
        var prarmObject : [RatingPostObject] = []
        
        let r1 = RatingPostObject(rvcatId: localData![0].rvcat_id , rvratingRate: rating1Label.text!)
        let r2 = RatingPostObject(rvcatId: localData![1].rvcat_id, rvratingRate: rating2Label.text!)
        let r3 = RatingPostObject(rvcatId: localData![2].rvcat_id, rvratingRate: rating3Label.text!)
        let r4 = RatingPostObject(rvcatId: localData![3].rvcat_id, rvratingRate: rating4Label.text!)
        let r5 = RatingPostObject(rvcatId: localData![4].rvcat_id, rvratingRate: rating5Label.text!)
        
        prarmObject.append(r1)
        prarmObject.append(r2)
        prarmObject.append(r3)
        prarmObject.append(r4)
        prarmObject.append(r5)
        
        return prarmObject
    }
    
    func bindData(_ data : [ReviewCategory]) {
        
        localData = data
        // Rating 1
        if data.count > 0 {
            rating1TitleLabel.text = data[0].rvcat_name
        }
        
        // Rating 2
        if data.count > 1 {
            rating2TitleLabel.text = data[1].rvcat_name
        }
        
        // Rating 3
        if data.count > 2 {
            rating3TitleLabel.text = data[2].rvcat_name
        }
        
        // Rating 4
        if data.count > 3 {
            rating4TitleLabel.text = data[3].rvcat_name
        }
        
        // Rating 5
        if data.count > 4 {
            rating5TitleLabel.text = data[4].rvcat_name
        }
    }
    
    func setupUI() {
        
        // your reviews title
        titleLabel.font = customFont.subHeaderUIFont
        titleLabel.textColor = configs.colorText
        
        // room
        roomNameLabel.font = customFont.normalUIFont
        roomNameLabel.textColor = configs.colorText
        roomLabel.font = customFont.normalUIFont
        roomLabel.textColor = configs.colorText
        
        // rating 1
        rating1Label.font = customFont.normalUIFont
        rating1Label.textColor = configs.colorText
        rating1TitleLabel.font = customFont.normalUIFont
        rating1TitleLabel.textColor = configs.colorText
        
        // rating 2
        rating2Label.font = customFont.normalUIFont
        rating2Label.textColor = configs.colorText
        rating2TitleLabel.font = customFont.normalUIFont
        rating2TitleLabel.textColor = configs.colorText
        
        // rating 3
        rating3Label.font = customFont.normalUIFont
        rating3Label.textColor = configs.colorText
        rating3TitleLabel.font = customFont.normalUIFont
        rating3TitleLabel.textColor = configs.colorText
        
        // rating 4
        rating4Label.font = customFont.normalUIFont
        rating4Label.textColor = configs.colorText
        rating4TitleLabel.font = customFont.normalUIFont
        rating4TitleLabel.textColor = configs.colorText
        
        // rating 5
        rating5Label.font = customFont.normalUIFont
        rating5Label.textColor = configs.colorText
        rating5TitleLabel.font = customFont.normalUIFont
        rating5TitleLabel.textColor = configs.colorText
        
        // message
        messageTitleLabel.textColor = configs.colorText
        messageTitleLabel.font = customFont.normalUIFont
        
        // Submit Button
        submitButton.setTitleColor(configs.colorTextAlt, for: .normal)
        submitButton.titleLabel?.font = customFont.subHeaderUIFont
        submitButton.backgroundColor = configs.colorPrimary
        submitButton.borderColor = configs.colorPrimary
    }
}

extension ReviewSubmitView: RoomFilterViewProtocol {
    func selectRoom(_ room: Room) {
        print("Selected Room.")
        roomLabel.text = room.room_name
        self.selectedRoom = room
    }
}

extension ReviewSubmitView : LoginViewDelegate {
    func refreshProfileData() {
        super.refreshUserLogin()
    }
    
}
