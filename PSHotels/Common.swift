//
//  Common.swift
//
//  Created by Panacea-soft on 2/11/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation
import SVProgressHUD
import GoogleMobileAds

open class Common {

    static let instance: Common = Common()
    let screenSize: CGRect = UIScreen.main.bounds
    
    public init(){}
    
    open func isValidEmail(_ testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    open func getLoginUserInfoPlist() -> String{
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths[0] as! String
        let path = (documentsDirectory as NSString).appendingPathComponent("LoginUserInfo.plist")
        return path
    }
    
    open func circleImageView(_ image:UIImageView) ->UIImageView {
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = configs.colorPrimary.cgColor
        image.layer.backgroundColor = UIColor.white.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        return image
    }
    
    open func setTextViewBorderColor(_ txtView: UITextView)-> UITextView {
        txtView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        txtView.layer.borderWidth = 1.0
        txtView.layer.cornerRadius = 5
        return txtView
    }
    
    func isUserLogin()-> (isLogin: Bool, loginUserId: String) {
        
        let db = UserDefaults.standard
        if let loginUserId : String = db.string(forKey: UserInfoKeys.loginUserId) {
            if loginUserId != "" {
                return (true, loginUserId)
            }
        }
        
        return (false, configs.default_user)
       
    }
    
    func getBasicUserInfo() -> ( userName: String, email: String, phone : String) {
        let db = UserDefaults.standard
        var name = ""
        var email = ""
        var phone = ""
        
        if let userName : String = db.string(forKey: UserInfoKeys.userName) {
            if userName != "" {
                name = userName
            }
        }
        
        if let userEmail : String = db.string(forKey: UserInfoKeys.userEmail) {
            if userEmail != "" {
                email = userEmail
            }
        }
        
        if let userPhone : String = db.string(forKey: UserInfoKeys.userPhone) {
            if userPhone != "" {
                phone = userPhone
            }
        }
        
        return (name, email, phone)
    }
    
    func deleteUserInfo() {
        let db = UserDefaults.standard
        db.set("", forKey: UserInfoKeys.loginUserId)
        db.set("", forKey: UserInfoKeys.userName)
        db.set("", forKey: UserInfoKeys.userEmail)
        db.set("", forKey: UserInfoKeys.userPhone)
        db.set("", forKey: UserInfoKeys.userAboutMe)
        db.set("", forKey: UserInfoKeys.userCoverPhoto)
        db.set("", forKey: UserInfoKeys.userProfilePhoto)
        db.set("", forKey: UserInfoKeys.addedDate)
        db.set("", forKey: UserInfoKeys.likeCount)
        db.set("", forKey: UserInfoKeys.commentsCount)
        db.set("", forKey: UserInfoKeys.favouriteCount)
    }
    
    func saveUserInfo(_ user: User) {
        let db = UserDefaults.standard
        db.set(user.user_id, forKey: UserInfoKeys.loginUserId)
        db.set(user.user_name, forKey: UserInfoKeys.userName)
        db.set(user.user_email, forKey: UserInfoKeys.userEmail)
        db.set(user.user_phone, forKey: UserInfoKeys.userPhone)
        db.set(user.user_about_me, forKey: UserInfoKeys.userAboutMe)
        db.set(user.user_cover_photo, forKey: UserInfoKeys.userCoverPhoto)
        db.set(user.user_profile_photo, forKey: UserInfoKeys.userProfilePhoto)
        db.set(user.added_date, forKey: UserInfoKeys.addedDate)
        db.set(user.like_count, forKey: UserInfoKeys.likeCount)
        db.set(user.comment_count, forKey: UserInfoKeys.commentsCount)
        db.set(user.favourite_count, forKey: UserInfoKeys.favouriteCount)
        
        print("Save User ID : \(String(describing: db.string(forKey: UserInfoKeys.loginUserId)))")
    }
    
    func saveUserContact(name: String, email: String, phone: String) {
        UserDefaults.standard.set(name, forKey:  UserContact.UC_name);
        UserDefaults.standard.set(email, forKey:  UserContact.UC_email);
        UserDefaults.standard.set(phone, forKey:  UserContact.UC_phone);
        
    }
    
    func saveSearch(cityId: String,
                    cityName: String,
                    hotelName: String,
                    starRating: String,
                    lowerPrice: String,
                    upperPrice: String,
                    guestRating: String) {
        UserDefaults.standard.set(cityId, forKey:  SearchLog.SL_cityId);
        UserDefaults.standard.set(cityName, forKey:  SearchLog.SL_cityName);
        UserDefaults.standard.set(hotelName, forKey:  SearchLog.SL_hotelName);
        UserDefaults.standard.set(starRating, forKey:  SearchLog.SL_starRating);
        UserDefaults.standard.set(lowerPrice, forKey:  SearchLog.SL_lowerPrice);
        UserDefaults.standard.set(upperPrice, forKey:  SearchLog.SL_upperPrice);
        UserDefaults.standard.set(guestRating, forKey:  SearchLog.SL_guestRating);
    }
    
    func loadSearch() -> (cityId: String, cityName: String, hotelName: String, starRating: String, lowerPrice: String, upperPrice: String, guestRating: String){
        let prefs = UserDefaults.standard
        var cityId = prefs.string(forKey: SearchLog.SL_cityId)
        var cityName = prefs.string(forKey: SearchLog.SL_cityName)
        var hotelName = prefs.string(forKey: SearchLog.SL_hotelName)
        var starRating = prefs.string(forKey: SearchLog.SL_starRating)
        var lowerPrice = prefs.string(forKey: SearchLog.SL_lowerPrice)
        var upperPrice = prefs.string(forKey: SearchLog.SL_upperPrice)
        var guestRating = prefs.string(forKey: SearchLog.SL_guestRating)
        
        if cityId == nil {
            cityId = ""
        }
        
        if cityName == nil {
            cityName = ""
        }
        
        if hotelName == nil {
            hotelName = ""
        }
        
        if starRating == nil {
            starRating = ""
        }
        
        if lowerPrice == nil {
            lowerPrice = ""
        }
        
        if upperPrice == nil {
            upperPrice = ""
        }
        
        if guestRating == nil {
            guestRating = ""
        }
        
        return (cityId!, cityName!, hotelName!, starRating!, lowerPrice!, upperPrice!, guestRating!)
        
    }
    
    func loadBackgroundImage(_ view: UIView)-> UIView {
        if let patternImage = UIImage(named: "Background") {
            view.backgroundColor = UIColor(patternImage: patternImage)
        }
        return view
    }
    
    
    func heightOfString(for text:String, with font: UIFont, width: CGFloat, lineHeight: CGFloat  = 0) -> CGFloat {
        
        var extraLineHeight : CGFloat = 0
        
        let nsstring = NSString(string: text)
        
        let maxHeight = CGFloat(1000.0)
        let textAttributes = [NSAttributedString.Key.font: font]
        
        let boundingRect = nsstring.boundingRect(with: CGSize(width: width, height: maxHeight), options: .usesLineFragmentOrigin, attributes: textAttributes, context: nil)
        
        var textHeight = ceil(boundingRect.size.height)
        
        if textHeight < boundingRect.height {
            textHeight = textHeight + 1
        }
        print(width)
        print(textHeight)
        if lineHeight > 0 {
            
            let nsstringSingleLine = NSString(string: "A")
            let boundingRectForSingleLine = nsstringSingleLine.boundingRect(with: CGSize(width: width, height: maxHeight), options: .usesLineFragmentOrigin, attributes: textAttributes, context: nil)
            
            let singleLineHeight = ceil(boundingRectForSingleLine.height)
            let totalLines = textHeight / singleLineHeight
            
            if totalLines > 1.0 {
                extraLineHeight = totalLines * lineHeight
                extraLineHeight = ceil(extraLineHeight)
                
                print("Total Lines \(text) - \(ceil(textHeight / singleLineHeight))")
            }
            /*print("single line \(singleLineHeight)")
            print("actual height \(textHeight)")
            print("line \(totalLines)")*/
        }
        
        //print("Extra Height  \(extraLineHeight)")
        
        return textHeight + extraLineHeight
        
    }
    
    
    func colorWithHexString (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    func getUIFont(fontName: String, fontSize: CGFloat) -> UIFont {
        return UIFont(name: fontName , size: fontSize)!
        
    }
    
    var linearBar : LinearProgressBar? = nil
    
    func setupLoadingBar(_ view: UIView) {
        self.linearBar = LinearProgressBar()
        view.addSubview(linearBar!)
        
    }
    
    func showBarLoading() {
        if linearBar != nil {
            linearBar?.startAnimation()
        }
    }
    
    func hideBarLoading() {
        if linearBar != nil {
            linearBar?.stopAnimation()
        }
    }
    
    func showLoading(_ status: String = "Loading...") {
        SVProgressHUD.show(withStatus: status)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        
    }
    
    func hideLoading() {
        SVProgressHUD.dismiss()
    }
    
    /*******************************
     * Function related with images
     *******************************/
    func saveImage(_ image: UIImage, path: String) -> Bool {
        let pngImageData = image.pngData()
        let result = (try? pngImageData!.write(to: URL(fileURLWithPath: path), options: [.atomic])) != nil
        return result
    }
    
    func loadImageFromPath(_ path: String) -> UIImage? {
        let data = try? Data(contentsOf: URL(fileURLWithPath: path))
        if data != nil {
            let image = UIImage(data: data!)!
            return image
        }
        
        return nil
    }
    
    func deleteImageFromPath(_ path: String) {
        // Create a FileManager instance
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: path)
        }
        catch let error as NSError {
            ps.print("Ooops! Something went wrong: \(error)")
        }
    }
    
    func scaleUIImageToSize(_ image: UIImage, size: CGSize) -> UIImage {
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
    func getImageSize(_ size: CGSize) -> CGSize{
        let limitWidth :CGFloat = 150
        var convertedSize : CGSize = size
        var scale :CGFloat = 0
        
        if size.width > limitWidth {
            scale = size.width / limitWidth
            
            convertedSize.width /= scale
            convertedSize.height /= scale
        }
        
        return convertedSize
    }
    
    // Documents directory
    func documentsDirectory() -> String {
        let documentsFolderPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        return documentsFolderPath
    }
    // File in Documents directory
    open func fileInDocumentsDirectory(_ filename: String) -> String {
        return documentsDirectory().stringByAppendingPathComponent(filename)
    }
    
    // To update back button
    func updateBackButton(_ navigationItem: UINavigationItem) {
        let backItem = UIBarButtonItem()
        backItem.tintColor = configs.colorTextAlt
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
  
    
}

// to allow use of .stringByAppendingPathComponent method in Swift 2
extension String {
    func stringByAppendingPathComponent(_ path: String) -> String {
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
    
    var html2AttributedString: NSAttributedString? {
        guard
            let data = data(using: String.Encoding.utf8)
            else { return nil }
        do {
            return try NSAttributedString(data: data, options: [ .documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        } catch let error as NSError {
            ps.print(error.localizedDescription)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}


extension NSAttributedString {
    
    func attributedString(withFontSize size: CGFloat) -> NSAttributedString {
        
        let mutableString = NSMutableAttributedString(attributedString: self)
        
        mutableString.beginEditing()
        
        mutableString.enumerateAttribute(.font, in: NSRange(location: 0, length: mutableString.length), options: [], using: { (value, range, stop) in
            
            
            if let font = (value as? UIFont)?.withSize(size) {
                
                mutableString.removeAttribute(.font, range: range)
                mutableString.addAttribute(.font, value: font, range: range)
                
                // *** Create instance of `NSMutableParagraphStyle`
                let paragraphStyle = NSMutableParagraphStyle()
                
                // *** set LineSpacing property in points ***
                paragraphStyle.lineSpacing = 8 // Whatever line spacing you want in points
                
                paragraphStyle.alignment = .justified
                
                paragraphStyle.lineBreakMode = .byWordWrapping
                
                
                // *** Apply attribute to string ***
                mutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:range)
                
                
            }
            
        })
        
        mutableString.endEditing()
        
        return NSAttributedString(attributedString: mutableString)
    }
    
}


// To dismiss the keyboard when click outside of text field
// Usage.
// extends the UITextFieldDelegate in class
// copy the following code to viewDidLoad
// self.hideKeyboardWhenTappedAround()
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


// For Custom PS Printing
// 
struct ps {
    
    static func print(_ string: String) {
        if appStatus.appBuildType == buildType.development {
            Swift.print(string)
            
        }
    }
    
    static func print(_ items: Any...) {
        if appStatus.appBuildType == buildType.development {
            Swift.print(items)
            
        }
    }
    
    static func print(_ items: Any..., separator: String ) {
        
        if appStatus.appBuildType == buildType.development {
            Swift.print(items, separator)
            
        }
    }
    
    static func print(_ items: Any..., terminator: String ) {
        
        if appStatus.appBuildType == buildType.development {
            Swift.print(items, terminator)
            
        }
    }
    
    static func print(_ items: Any..., separator: String , terminator: String) {
        
        if appStatus.appBuildType == buildType.development {
            Swift.print(items, separator, terminator)
            
        }
    }
    
    static func print(_ items: Any..., terminator: String , separator: String) {
        
        if appStatus.appBuildType == buildType.development {
            Swift.print(items, separator, terminator)
            
        }
    }
    
}
