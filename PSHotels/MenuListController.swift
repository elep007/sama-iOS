//
//  MenuListController.swift
//
//  Created by Panacea-soft on 2/11/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//


import UIKit

class MenuListController: UITableViewController {
    
    
    // MARK: IBOutlet
    @IBOutlet weak var myFavCell: UITableViewCell!
    @IBOutlet weak var logoutCell: UITableViewCell!
    @IBOutlet weak var loginCell: UITableViewCell!
    @IBOutlet weak var profileCell: UITableViewCell!
    @IBOutlet weak var subscribeCategoryCell: UITableViewCell!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var newsRelatedLabel: UILabel!
    @IBOutlet weak var recommendedLabel: UILabel!
    @IBOutlet weak var popularLabel: UILabel!
    @IBOutlet weak var promotionLabel: UILabel!
    @IBOutlet weak var userInfoLabel: UILabel!
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var myFavouriteItemsLabel: UILabel!
    @IBOutlet weak var myBookingListLabel: UILabel!
    @IBOutlet weak var logoutLabel: UILabel!
    @IBOutlet weak var appLabel: UILabel!
    @IBOutlet weak var aboutAppLabel: UILabel!
    @IBOutlet weak var contactUsLabel: UILabel!
    @IBOutlet weak var settingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    
    // MARK: Custom Variables
    var userLoggedIn : Bool = false {
        didSet {
            updateMenu()
        }
    }
    
    let homeIndex : Int = 0
    let recommendedHotelsIndex : Int = 2
    let popularHotelsIndex : Int = 3
    let promotionHotelsIndex : Int = 4
    let profileIndex : Int = 6
    let loginIndex : Int = 7
    let myBookingIndex : Int = 8
    let myFavIndex : Int = 9
    let logoutIndex : Int = 10
    let aboutAppIndex : Int = 12
    let contactUsIndex : Int = 13
    let settingIndex : Int = 14
    
    
    var currentIndexPath : IndexPath?
    
    
    // MARK: Override Functions
    override func viewDidLoad() {
        if(Common.instance.isUserLogin().isLogin) {
            self.userLoggedIn = true
        }
        
        currentIndexPath = IndexPath(row: homeIndex, section: 0)
        selectCell(currentIndexPath!)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        homeLabel.text = language.menu__home
        newsRelatedLabel.text = language.menu__hotelsRelated
        recommendedLabel.text = language.menu__recommendedHotel
        popularLabel.text = language.menu__popularHotels
        promotionLabel.text = language.menu__promotion
        userInfoLabel.text = language.menu__userInfo
        profileLabel.text = language.menu__profile
        myFavouriteItemsLabel.text = language.menu__myFavouriteItems
        myBookingListLabel.text = language.menu__booking
        logoutLabel.text = language.menu__logout
        appLabel.text = language.menu__app
        aboutAppLabel.text = language.menu__aboutApp
        contactUsLabel.text = language.menu__contactUs
        settingLabel.text = language.menu__setting
        
        
        nameLabel.font = customFont.subHeaderBoldUIFont
        nameLabel.textColor = configs.colorText
        nameLabel.text = language.appName
        
        homeLabel.font = customFont.normalUIFont
        homeLabel.textColor = configs.colorText
        
        newsRelatedLabel.font = customFont.tagUIFont
        newsRelatedLabel.textColor = configs.colorTag
        
        recommendedLabel.font = customFont.normalUIFont
        recommendedLabel.textColor = configs.colorText
        
        popularLabel.font = customFont.normalUIFont
        popularLabel.textColor = configs.colorText
        
        promotionLabel.font = customFont.normalUIFont
        promotionLabel.textColor = configs.colorText
        
        userInfoLabel.font = customFont.tagUIFont
        userInfoLabel.textColor = configs.colorTag
        
        profileLabel.font = customFont.normalUIFont
        profileLabel.textColor = configs.colorText
        
        loginLabel.font = customFont.normalUIFont
        loginLabel.textColor = configs.colorText
        
        myFavouriteItemsLabel.font = customFont.normalUIFont
        myFavouriteItemsLabel.textColor = configs.colorText
        
        myBookingListLabel.font = customFont.normalUIFont
        myBookingListLabel.textColor = configs.colorText
        
        logoutLabel.font = customFont.normalUIFont
        logoutLabel.textColor = configs.colorText
        
        appLabel.font = customFont.tagUIFont
        appLabel.textColor = configs.colorTag
        
        aboutAppLabel.font = customFont.normalUIFont
        aboutAppLabel.textColor = configs.colorText
        
        contactUsLabel.font = customFont.normalUIFont
        contactUsLabel.textColor = configs.colorText
        
        settingLabel.font = customFont.normalUIFont
        settingLabel.textColor = configs.colorText
        
        
        
    }
    
    func deselectCurrentCell() {
        if let curIndexPath = currentIndexPath {
            let curSelectedCell = tableView.cellForRow(at: curIndexPath)
            curSelectedCell?.backgroundColor = UIColor.white
        }
    }
    
    func selectCell(_ indexPath : IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        selectedCell?.backgroundColor = configs.colorSelection
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        deselectCurrentCell()
        
        selectCell(indexPath)
        
        currentIndexPath = indexPath
        
        if((indexPath as NSIndexPath).row == profileIndex) {
            
            performSegue(withIdentifier: "profile", sender: profileIndex)
            
        }else if((indexPath as NSIndexPath).row == loginIndex) {
            
            performSegue(withIdentifier: "login", sender: profileIndex)
            
            
        }else if((indexPath as NSIndexPath).row == recommendedHotelsIndex) {
            
            performSegue(withIdentifier: "Recommended", sender: recommendedHotelsIndex)
            
        } else if ((indexPath as NSIndexPath).row == popularHotelsIndex) {
            
            performSegue(withIdentifier: "Popular", sender: popularHotelsIndex)
            
        } else if ((indexPath as NSIndexPath).row == promotionHotelsIndex) {
            
            performSegue(withIdentifier: "Promotion", sender: promotionHotelsIndex)
            
        } else if ((indexPath as NSIndexPath).row == myFavIndex) {
            
            performSegue(withIdentifier: "Favourite", sender: myFavIndex)
            
        }else if ((indexPath as NSIndexPath).row == myBookingIndex) {
            
            performSegue(withIdentifier: "Booking", sender: myBookingIndex)
            
        } else if((indexPath as NSIndexPath).row == logoutIndex ){
            
            deselectCurrentCell()
            
            currentIndexPath = IndexPath(row: homeIndex, section: 0)
            selectCell(currentIndexPath!)
            
            self.userLoggedIn = false
            
            performSegue(withIdentifier: "Home", sender: self)
            
            Common.instance.deleteUserInfo()
            
            // Delete the profile image from local
            let imagePath = Common.instance.fileInDocumentsDirectory("profile_.png")
            Common.instance.deleteImageFromPath(imagePath)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        if (segue.identifier == "NewsFav") {
//            if let param = sender as? Int {
//
//                if let vc: UINavigationController = segue.destination as? UINavigationController {
//
//                    let favouriteNewsViewController = vc.topViewController as! PromotionHotelListViewController
//
//                }else {
//                    ps.print("Invalid")
//                }
//            }
//        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if !userLoggedIn {
           
            if
                indexPath.row == myFavIndex ||
                indexPath.row == profileIndex ||
                indexPath.row == logoutIndex ||
                indexPath.row == myBookingIndex {
                return 0
            }
            return 52
        }else {
            
            if indexPath.row == loginIndex {
                return 0
            }
            
            return 52
        }
    }
    
    // MARK: Custom Functions
    func updateMenu(){
        
        tableView.reloadData()
        
    }
    
    
    func openProfilePage() {
        
        userLoggedIn = true
        
        deselectCurrentCell()
        
        currentIndexPath = IndexPath(row: profileIndex, section: 0)
        selectCell(currentIndexPath!)
        
        performSegue(withIdentifier: "profile", sender: profileIndex)
    }
    
    
}
