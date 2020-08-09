//
//  ProfileEditView.swift
//  PSHotels
//
//  Created by Panacea-Soft on 10/25/17.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import UIKit

protocol ProfileEditViewDelegate {
    func refreshUserData()
}

@IBDesignable
class ProfileEditView: PSUIView{

    var picker:UIImagePickerController?=UIImagePickerController()
    
    @IBOutlet weak var profileBgImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var aboutmeTextView: UITextView!
    @IBOutlet weak var profileImageEdit: UIImageView!
    @IBOutlet weak var usernameTitleLabel: UILabel!
    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var phoneTitleLabel: UILabel!
    @IBOutlet weak var aboutMeTitleLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var passwordChangeButton: UIButton!
    
    
    // MARK: Custom Variables
    var userViewModel : UserViewModel = UserViewModel()
    var parent: UserProfileEditViewController?
    var delegate : ProfileEditViewDelegate? = nil
    
    // MARK: - Override Functions
    override func initVariables() {
        userViewModel.nibName = "ProfileEditView"
    }
    
    
    
    
    // MARK: - Override Functions
    // joining DetailView.swift and DetailView.xib
    override func getNibName() -> String {
        return userViewModel.nibName
    }
    
    override func initUIViewAndActions() {
        super.initUIViewAndActions()
        
        // setup ui
        usernameTitleLabel.font = customFont.normalBoldUIFont
        usernameTitleLabel.textColor = configs.colorText
        usernameTitleLabel.text = language.profileEdit__userName
        
        emailTitleLabel.font = customFont.normalBoldUIFont
        emailTitleLabel.textColor = configs.colorText
        emailTitleLabel.text = language.profileEdit__email
        
        phoneTitleLabel.font = customFont.normalBoldUIFont
        phoneTitleLabel.textColor = configs.colorText
        phoneTitleLabel.text = language.profileEdit__phone
        
        aboutMeTitleLabel.font = customFont.normalBoldUIFont
        aboutMeTitleLabel.textColor = configs.colorText
        aboutMeTitleLabel.text = language.profileEdit__aboutMe
        
        submitButton.setTitleColor(configs.colorTextAlt, for: .normal)
        submitButton.titleLabel?.font = customFont.normalUIFont
        submitButton.backgroundColor = configs.colorPrimary
        submitButton.setTitle(language.profileEdit__submit, for: .normal)
        
        passwordChangeButton.setTitleColor(configs.colorTextAlt, for: .normal)
        passwordChangeButton.titleLabel?.font = customFont.normalUIFont
        passwordChangeButton.backgroundColor = configs.colorPrimary
        passwordChangeButton.setTitle(language.profileEdit__passwordChange, for: .normal)
        
        usernameTextField.font = customFont.normalUIFont
        usernameTextField.textColor = configs.colorText
        
        emailTextField.font = customFont.normalUIFont
        emailTextField.textColor = configs.colorText
        
        phoneTextField.font = customFont.normalUIFont
        phoneTextField.textColor = configs.colorText
        
        aboutmeTextView.font = customFont.normalUIFont
        aboutmeTextView.textColor = configs.colorText
        
        usernameTextField.delegate = self
        emailTextField.delegate = self
        phoneTextField.delegate = self
        aboutmeTextView.delegate = self
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(ProfileEditView.openImagePicker))
        profileImageView.addGestureRecognizer(singleTap)
    }
    
    override func initData() {
        
        
        // Loading Monitoring
        userViewModel.isLoading.bind{
            if($0) {
                
                Common.instance.showBarLoading()
                
            }else {
                //Stop Animation
                Common.instance.hideBarLoading()
                
            }
        }
        
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
        
        
        userViewModel.updateUserLiveData.bind{ [weak self] in
            
            if let resourse : Resourse<User> = $0 {
                
                Common.instance.hideLoading()
                
                if resourse.status == Status.SUCCESS
                    || resourse.status == Status.LOADING {
                    
                    if let user : User = resourse.data {
                        
                        _ = SweetAlert().showAlert(language.profileEditTitle, subTitle:  language.message__profile_edit_successful, style: AlertStyle.success)
                        
                        self?.bindUserData(user)
                        
                        Common.instance.saveUserInfo(user)
                        
                        self?.delegate?.refreshUserData()
                        
                    }
                    
                } else if resourse.status == Status.ERROR {
                    print("Error in loading data. Message : " + resourse.message)
                    _ = SweetAlert().showAlert(language.profileEditTitle, subTitle:  resourse.message, style: AlertStyle.error)
                }
            }else {
                print("Something Wrong")
            }
            
        }
        
        
        userViewModel.uploadUserProfileLiveData.bind { [weak self] in
            if let resourse : Resourse<User> = $0 {
                
                Common.instance.hideLoading()
                
                if resourse.status == Status.SUCCESS
                    || resourse.status == Status.LOADING {
                    
                    if let user : User = resourse.data {
                        
                        let imagePath = Common.instance.fileInDocumentsDirectory("profile_.png")
                        let _ = Common.instance.saveImage((self?.profileImageView.image!)!, path: imagePath)
                        
                        _ = SweetAlert().showAlert(language.profileEditTitle, subTitle:  language.message__profile_edit_successful, style: AlertStyle.success)
                        
                        self?.bindUserData(user, refreshImage: false)
                        
                        
                        
                        let loadedImage = Common.instance.loadImageFromPath(imagePath)
                        if loadedImage != nil {
                            let imageURL = configs.imageUrl + user.user_profile_photo
                            self?.profileImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: loadedImage)
                        }
                        
                        self?.delegate?.refreshUserData()
                    }
                    
                } else if resourse.status == Status.ERROR {
                    print("Error in loading data. Message : " + resourse.message)
                }
            }else {
                print("Something Wrong")
            }
        }
    }
    
    
    //MARK: Custom Functions
    
    func bindUserData(_ user: User, refreshImage : Bool = true) {
        usernameTextField.text = user.user_name
        emailTextField.text = user.user_email
        phoneTextField.text = user.user_phone
        aboutmeTextView.text = user.user_about_me
        
        if refreshImage {
            let imagePath = Common.instance.fileInDocumentsDirectory("profile_.png")
            let loadedImage = Common.instance.loadImageFromPath(imagePath)
            if loadedImage != nil {
            
                let imageURL = configs.imageUrl + user.user_profile_photo
                profileImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: loadedImage)
                
                let imageURLForBg = configs.imageUrl + user.user_profile_photo
                profileBgImageView.sd_setImage(with: URL(string: imageURLForBg), placeholderImage: loadedImage)
            }else {
                let imageURL = configs.imageUrl + user.user_profile_photo
                profileImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "PlaceholderProfileImage"))
                
                let imageURLForBg = configs.imageUrl + user.user_profile_photo
                profileBgImageView.sd_setImage(with: URL(string: imageURLForBg), placeholderImage: UIImage(named: "PlaceholderProfileImage"))
            }
        }
        
    }
    
    
    //MARK: Actions
    
    @objc func openImagePicker() {
        
        if !Connectivity.isConnected() {
            _ = SweetAlert().showAlert(language.profileEditTitle, subTitle:  language.error_message__no_internet_connection, style: AlertStyle.error)
            parent?.dismiss(animated: true, completion: nil)
            return
        }
        
        self.picker?.delegate = self
        self.picker!.allowsEditing = false
        self.picker!.sourceType =  .photoLibrary
        self.parent?.present(self.picker!, animated: true, completion: nil)
        
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        
        if !Connectivity.isConnected() {
            _ = SweetAlert().showAlert(language.profileEditTitle, subTitle:  language.error_message__no_internet_connection, style: AlertStyle.error)
            return
        }
        
        if usernameTextField.text == "" {
            _ = SweetAlert().showAlert(language.registerTitle, subTitle:  language.error_message__blank_username, style: AlertStyle.error)
            return
        }
        
        if emailTextField.text == "" {
            _ = SweetAlert().showAlert(language.registerTitle, subTitle:  language.error_message__blank_email, style: AlertStyle.error)
            return
        }
        
        Common.instance.showLoading()
        
        userViewModel.updateUser(userId: super.loginUserId, userName: usernameTextField.text!, email: emailTextField.text!, phone: phoneTextField.text!, aboutMe: aboutmeTextView.text!)
    
    }
    
    @IBAction func passwordChangeClicked(_ sender: Any) {
        if !Connectivity.isConnected() {
            _ = SweetAlert().showAlert(language.passwordChangeTitle, subTitle:  language.error_message__no_internet_connection, style: AlertStyle.error)
            return
        }
        
        PSNavigationController.instance.navigateToPasswordUpdate()
        PSNavigationController.instance.updateBackButton()
        
    }
    
    
}

extension ProfileEditView : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        parent?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let pickedImage = info[.originalImage] as? UIImage {
            profileImageView.contentMode = .scaleAspectFit
            profileImageView.image = pickedImage
            
            parent?.dismiss(animated: true, completion: nil)
            
            Common.instance.showLoading()
            
            DispatchQueue.main.async {
                self.userViewModel.uploadProfilePhoto(userId: super.loginUserId, image: self.profileImageView.image!)
            }
            
            return
            
        }
        
        parent?.dismiss(animated: true, completion: nil)
    }
    
}


extension ProfileEditView : UITextFieldDelegate  {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            
            if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextView {
                nextField.becomeFirstResponder()
            }else {
                // Not found, so remove keyboard.
                textField.resignFirstResponder()
            }
        }
        // Do not add a line break
        return false
    }
}

extension ProfileEditView : UITextViewDelegate {
    // hides text views
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

