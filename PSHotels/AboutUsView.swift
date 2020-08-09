//
//  AboutUsView.swift
//  PSHotels
//
//  Created by Panacea-Soft on 10/26/17.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import UIKit

@IBDesignable
class AboutUsView: PSUIView {

    // MARK: Custom Variables
    let aboutUsViewModel = AboutUsViewModel()
    
    @IBOutlet weak var aboutUsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var websiteTitleLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneTitleLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var facebookTitleLabel: UILabel!
    @IBOutlet weak var facebookLabel: UILabel!
    @IBOutlet weak var gplusTitleLabel: UILabel!
    @IBOutlet weak var gplusLabel: UILabel!
    @IBOutlet weak var twitterTitleLabel: UILabel!
    @IBOutlet weak var twitterLabel: UILabel!
    @IBOutlet weak var instagramTitleLabel: UILabel!
    @IBOutlet weak var instagramLabel: UILabel!
    @IBOutlet weak var youTubeTitleLabel: UILabel!
    @IBOutlet weak var youTubeLabel: UILabel!
    @IBOutlet weak var pinterestTitleLabel: UILabel!
    @IBOutlet weak var pinterestLabel: UILabel!
    
    
    
    // MARK: - Override Functions
    override func initVariables() {
        aboutUsViewModel.nibName = "AboutUsView"
    }
    
    // MARK: - Override Functions
    // joining AboutUsView and AboutUsView.xib
    override func getNibName() -> String {
        return aboutUsViewModel.nibName
    }
    
    override func initUIViewAndActions() {
        super.initUIViewAndActions()
        
        // Loading Monitoring
        aboutUsViewModel.isLoading.bind{
            if($0) {
                Common.instance.showBarLoading()
            }else {
                Common.instance.hideBarLoading()
            }
        }
        
        setupFont()
        setupLabelTitle()
        setupColor()
    }
    
    override func initData() {
        // Load data from PS Server
        
        aboutUsViewModel.getAboutUs()
        aboutUsViewModel.aboutUsLiveData.bind{ [weak self] in
            
            if let resourse : Resourse<AboutUs> = $0 {
                
                if resourse.status == Status.SUCCESS
                    || resourse.status == Status.LOADING {
                    
                    if let aboutUs : AboutUs = resourse.data {
                        
                        self?.bindAboutUsData(aboutUs)
                        
                    }
                    
                } else if resourse.status == Status.ERROR {
                    print("Error in loading data. Message : " + resourse.message)
                }
            }else {
                print("Something Wrong")
            }
            
        }
        
    }
    
    
    func setupFont() {
        titleLabel.font = customFont.headerUIFont
        descLabel.font = customFont.normalUIFont
        websiteLabel.font = customFont.normalUIFont
        emailLabel.font = customFont.normalUIFont
        phoneLabel.font = customFont.normalUIFont
        facebookLabel.font = customFont.normalUIFont
        gplusLabel.font = customFont.normalUIFont
        twitterLabel.font = customFont.normalUIFont
        instagramLabel.font = customFont.normalUIFont
        youTubeLabel.font = customFont.normalUIFont
        pinterestLabel.font = customFont.normalUIFont
        
        websiteTitleLabel.font = customFont.normalBoldUIFont
        emailTitleLabel.font = customFont.normalBoldUIFont
        phoneTitleLabel.font = customFont.normalBoldUIFont
        facebookTitleLabel.font = customFont.normalBoldUIFont
        gplusTitleLabel.font = customFont.normalBoldUIFont
        twitterTitleLabel.font = customFont.normalBoldUIFont
        instagramTitleLabel.font = customFont.normalBoldUIFont
        youTubeTitleLabel.font = customFont.normalBoldUIFont
        pinterestTitleLabel.font = customFont.normalBoldUIFont
    }
    
    //MARKS: Custom Functions
    func setupLabelTitle() {
        websiteTitleLabel.text = language.aboutUs__website
        emailTitleLabel.text = language.aboutUs__email
        phoneTitleLabel.text = language.aboutUs__phone
        facebookTitleLabel.text = language.aboutUs__facebook
        gplusTitleLabel.text = language.aboutUs__google_plus
        twitterTitleLabel.text = language.aboutUs__twitter
        instagramTitleLabel.text = language.aboutUs__instagram
        youTubeTitleLabel.text = language.aboutUs__youTube
        pinterestTitleLabel.text = language.aboutUs__pinterest
        
    }
    
    func setupColor() {
        
        let textColor = configs.colorText
        
        //Text Data
        titleLabel.textColor = textColor
        descLabel.textColor = textColor
        websiteLabel.textColor = textColor
        emailLabel.textColor = textColor
        phoneLabel.textColor = textColor
        facebookLabel.textColor = textColor
        gplusLabel.textColor = textColor
        twitterLabel.textColor = textColor
        instagramLabel.textColor = textColor
        youTubeLabel.textColor = textColor
        pinterestLabel.textColor = textColor
        
        
        //Title
        websiteTitleLabel.textColor = textColor
        emailTitleLabel.textColor = textColor
        phoneTitleLabel.textColor = textColor
        facebookTitleLabel.textColor = textColor
        gplusTitleLabel.textColor = textColor
        twitterTitleLabel.textColor = textColor
        instagramTitleLabel.textColor = textColor
        youTubeTitleLabel.textColor = textColor
        pinterestTitleLabel.textColor = textColor
        
    }
    
    func bindAboutUsData(_ aboutUs: AboutUs) {
        titleLabel.text = aboutUs.about_title
        titleLabel.setLineHeight(height: configs.lineSpacing,aligment: .center)
        descLabel.text = aboutUs.about_description
        descLabel.setLineHeight(height: configs.lineSpacing,aligment: .center)
        websiteLabel.text = aboutUs.about_website
        emailLabel.text = aboutUs.about_email
        phoneLabel.text = aboutUs.about_phone
        facebookLabel.text = aboutUs.facebook
        gplusLabel.text = aboutUs.google_plus
        twitterLabel.text = aboutUs.twitter
        instagramLabel.text = aboutUs.instagram
        youTubeLabel.text = aboutUs.youtube
        pinterestLabel.text = aboutUs.pinterest
        
        let imageURL = configs.imageUrl + aboutUs.default_photo.img_path
        
        aboutUsImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "PlaceholderImage"))
        
    }
    
}
