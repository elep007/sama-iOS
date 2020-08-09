//
//  ProfileView.swift
//  PSHotels
//
//  Created by Panacea-Soft on 10/24/17.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import UIKit

@IBDesignable
class ProfileView: PSUIView {

    
    // MARK: IBOutlets
    @IBOutlet weak var profileBackgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var favCountLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var aboutMeLabel: UILabel!
    @IBOutlet weak var joinedDateLabel: UILabel!
    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var phoneTitleLabel: UILabel!
    @IBOutlet weak var aboutMeTitleLabel: UILabel!
    @IBOutlet weak var joinedDateTitleLabel: UILabel!
    
    @IBOutlet weak var commentTitleLabel: UILabel!
    @IBOutlet weak var favouriteTitleLabel: UILabel!
    
    
    // MARK: - Custom Variables
    // NibName of View. This variable will use later in getNibName()
    let userViewModel : UserViewModel = UserViewModel()
    
    // MARK: - Override Functions
    override func initVariables() {
        userViewModel.nibName = "ProfileView"
    }
    
    override func initUIViewAndActions() {
        super.initUIViewAndActions()
        
        
        commentTitleLabel.text = language.profile__commentLabel
        commentTitleLabel.textColor = configs.colorText
        commentTitleLabel.font = customFont.normalUIFont
        
        favouriteTitleLabel.text = language.profile__favouriteLabel
        favouriteTitleLabel.textColor = configs.colorText
        favouriteTitleLabel.font = customFont.normalUIFont
        
        emailTitleLabel.text = language.profile__emailTitle
        emailTitleLabel.textColor = configs.colorText
        emailTitleLabel.font = customFont.normalBoldUIFont
        
        phoneTitleLabel.text = language.profile__phoneTitle
        phoneTitleLabel.textColor = configs.colorText
        phoneTitleLabel.font = customFont.normalBoldUIFont
        
        aboutMeTitleLabel.text = language.profile__aboutMeTitle
        aboutMeTitleLabel.textColor = configs.colorText
        aboutMeTitleLabel.font = customFont.normalBoldUIFont
        
        joinedDateTitleLabel.text = language.profile__joinedDateTitle
        joinedDateTitleLabel.textColor = configs.colorText
        joinedDateTitleLabel.font = customFont.normalBoldUIFont
        
        emailLabel.textColor = configs.colorText
        emailLabel.font = customFont.normalUIFont
        
        phoneLabel.textColor = configs.colorText
        phoneLabel.font = customFont.normalUIFont
        
        aboutMeLabel.textColor = configs.colorText
        aboutMeLabel.font = customFont.normalUIFont
        
        joinedDateLabel.textColor = configs.colorText
        joinedDateLabel.font = customFont.normalUIFont
        
        
        
        // Loading Monitoring
        userViewModel.isLoading.bind{
            if($0) {
                Common.instance.showBarLoading()
            }else {
                Common.instance.hideBarLoading()
            }
        }
    }
    
    // MARK: - Override Functions
    // joining DetailView.swift and DetailView.xib
    override func getNibName() -> String {
        return userViewModel.nibName
    }
    
    override func initData() {
        
        userViewModel.getUserById(userId: super.loginUserId)
        userViewModel.userLiveData.bind{ [weak self] in
            
            if let resourse : Resourse<User> = $0 {
                
                if resourse.status == Status.SUCCESS
                    || resourse.status == Status.LOADING {
                    
                    if let user : User = resourse.data {
                        
                        self?.bindUserData(user)
                        
                    }
                    
                } else if resourse.status == Status.ERROR {
                    print("Error in loading data. Message : " + resourse.message)
                }
            }else {
                print("Something Wrong")
            }
            
        }
    }
    
    func bindUserData(_ user: User) {
        nameLabel.text = user.user_name
        
        commentCountLabel.text = user.comment_count
        favCountLabel.text = user.favourite_count
        emailLabel.text = user.user_email
        phoneLabel.text = user.user_phone
        
        aboutMeLabel.text = user.user_about_me
        aboutMeLabel.setLineHeight(height: configs.lineSpacing)
        
        joinedDateLabel.text = user.added_date
        
        let imagePath = Common.instance.fileInDocumentsDirectory("profile_.png")
        let loadedImage = Common.instance.loadImageFromPath(imagePath)
        if loadedImage != nil {
            
            let imageURL = configs.imageUrl + user.user_profile_photo
            profileImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: loadedImage)
            
            let imageURLForBg = configs.imageUrl + user.user_profile_photo
            profileBackgroundImageView.sd_setImage(with: URL(string: imageURLForBg), placeholderImage: loadedImage)
        }else {
            let imageURL = configs.imageUrl + user.user_profile_photo
            profileImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "PlaceholderProfileImage"))
            
            let imageURLForBg = configs.imageUrl + user.user_profile_photo
            profileBackgroundImageView.sd_setImage(with: URL(string: imageURLForBg), placeholderImage: UIImage(named: "PlaceholderProfileImage"))
        }
    }
    
    func openUserProfileEdit() {
        PSNavigationController.instance.navigateToUserProfileEdit(delegate: self)
        PSNavigationController.instance.updateBackButton()
    }
}


extension ProfileView : ProfileEditViewDelegate {
    func refreshUserData() {
        userViewModel.getUserById(userId: super.loginUserId)
    }
    
}











