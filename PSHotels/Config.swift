//
//  config.swift
//  PSHotels
//
//  Created by Panacea-soft on 2/11/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

struct configs {
    
//    static var mainUrl:String = "http://192.168.1.3:8888/pshotels/index.php/rest"
//    static var imageUrl:String = "http://192.168.1.3:8888/pshotels/uploads/"

    static var mainUrl:String = "http://admin.vip-sama.com/index.php/rest"
    static var imageUrl:String = "http://admin.vip-sama.com/uploads/"

    static let apiKey : String = "teampsisthebest"
    
    // PS Hotel API
    static let getCities                = "/cities/get/api_key/%@"
    static let getHotels                = "/hotels/get/api_key/%@/login_user_id/%@"
    static let getHotelByHotelId        = "/hotels/get/api_key/%@/login_user_id/%@/hotel_id/%@"
    static let getRoomByRoomId          = "/rooms/get/api_key/%@/login_user_id/%@/room_id/%@"
    static let getPrice                 = "/hotels/max_price/api_key/%@"
    static let getHotelFeaturesByHotelId = "/hotels/features/api_key/%@/hotel_id/%@"
    static let getHotelFeaturesByCityId = "/hotels/features/api_key/%@/city_id/%@"
    static let getRoomFeaturesByHotelId = "/rooms/features/api_key/%@/hotel_id/%@"
    static let getRoomFeaturesByRoomId = "/rooms/features/api_key/%@/room_id/%@"
    static let getRoomListByHotelId     = "/rooms/get/api_key/%@/hotel_id/%@"
    static let getHotelInfo             = "/hotel_info_groups/get/api_key/%@"
    static let postSearchHotel          = "/hotels/get/api_key/%@/login_user_id/%@/limit/%d/offset/%d"
    static let getHotelReviewSummary    = "/reviews/summary/api_key/%@/hotel_id/%@"
    static let getHotelReviewDetail     = "/reviews/details/api_key/%@/hotel_id/%@/limit/%d/offset/%d"
    static let getRoomReviewSummary    = "/reviews/summary/api_key/%@/room_id/%@"
    static let getRoomReviewDetail     = "/reviews/details/api_key/%@/room_id/%@/limit/%d/offset/%d"
    static let postReview               = "/reviews/submit/api_key/%@"
    static let getReviewCategory        = "/review_categories/get/api_key/%@"
    static let postInquiry              = "/inquirys/add/api_key/%@"
    static let getRecommendedHotels     = "/hotels/get/api_key/%@/is_recommended/1/login_user_id/%@/limit/%d/offset/%d"
    static let getPromotionHotels       = "/hotels/get/api_key/%@/promotion_only/1/login_user_id/%@/limit/%d/offset/%d"
    static let getPopularHotels         = "/hotels/get/api_key/%@/popular/1/login_user_id/%@/limit/%d/offset/%d"
    static let getFavouriteHotels         = "/hotels/get/api_key/%@/is_favourited/1/login_user_id/%@/limit/%d/offset/%d"
    static let postFavHotel             = "/favourites/press/api_key/%@"
    static let postHotelTouchCount           = "/hotel_touches/add/api_key/%@"
    static let postRoomTouchCount           = "/room_touches/add/api_key/%@"
    static let getAboutUs               = "/abouts/get/api_key/%@"
    static let postContactUs            = "/contacts/add/api_key/%@"
    static let postRegisterNotiToken    = "/notis/register/api_key/%@"
    static let postUnregisterNotiToken  = "/notis/unregister/api_key/%@"
    static let getImageList             = "/images/get/api_key/%@/img_parent_id/%@"
    static let getUser                  = "/users/get/api_key/%@/user_id/%@"
    static let doUploadImage            = "/images/upload/api_key/"
    static let postUserLogin            = "/users/login/api_key/%@"
    static let postUser                 = "/users/add/api_key/%@"
    static let postForgotPassword       = "/users/reset/api_key/%@"
    static let putUser                  = "/users/profile_update/api_key/%@"
    static let postPasswordUpdate       = "/users/password_update/api_key/%@"
    static let postBooking              = "/bookings/add/api_key/%@"
    static let getBookingList           = "/bookings/get/api_key/%@/login_user_id/%@/limit/%d/offset/%d"
    
    
    static var colorWhite            = Common.instance.colorWithHexString("#ffffff")
    static var colorDisable          = Common.instance.colorWithHexString("#e5e0e0")
    static var colorDisableText      = Common.instance.colorWithHexString("#777575")
    /*
    // Red Theme
    static var colorHightLight          = Common.instance.colorWithHexString("#F5B612")
    static var windowBackground         = Common.instance.colorWithHexString("#fffff7")
    static var colorPrimaryLight        = Common.instance.colorWithHexString("#ff6659")
    static var colorPrimary             = Common.instance.colorWithHexString("#d32f2f")
    static var colorPrimaryDark         = Common.instance.colorWithHexString("#9a0007")
    static var colorAccent              = Common.instance.colorWithHexString("#e57373")
    static var colorSelection           = Common.instance.colorWithHexString("#CCCCCC")
    static var colorTextAlt             = Common.instance.colorWithHexString("#FFFFFF")
    static var colorText                = Common.instance.colorWithHexString("#555555")
    static var colorTextLight           = Common.instance.colorWithHexString("#989898")
    static var colorReviewTitle         = Common.instance.colorWithHexString("#2196F3")
    static var colorSectionTitle        = Common.instance.colorWithHexString("#f5a623")
    static var colorPromotion           = Common.instance.colorWithHexString("#E34B4B")
    static var colorLine                = Common.instance.colorWithHexString("#f0f0f0")
    static var colorDate                = Common.instance.colorWithHexString("#898989")
    static var colorTag                 = Common.instance.colorWithHexString("#C3CE27")
    static var colorButtonBg            = Common.instance.colorWithHexString("#DDDDDD")
    static var colorSwipe               = Common.instance.colorWithHexString("#e56830")
    static var colorCancel              = Common.instance.colorWithHexString("#F41530")
    static var colorConfirm             = Common.instance.colorWithHexString("#68C701")
    */
    
    
    
    // Blue Color Theme
    static var colorHightLight          = Common.instance.colorWithHexString("#F5B612")
    static var windowBackground         = Common.instance.colorWithHexString("#fffff7")
    static var colorPrimaryLight        = Common.instance.colorWithHexString("#b0bec5")
    static var colorPrimary             = Common.instance.colorWithHexString("#2196F3")
    static var colorPrimaryDark         = Common.instance.colorWithHexString("#102027")
    static var colorAccent              = Common.instance.colorWithHexString("#90a4ae")
    static var colorSelection           = Common.instance.colorWithHexString("#CCCCCC")
    static var colorTextAlt             = Common.instance.colorWithHexString("#FFFFFF")
    static var colorText                = Common.instance.colorWithHexString("#555555")
    static var colorTextLight           = Common.instance.colorWithHexString("#989898")
    static var colorSectionTitle        = Common.instance.colorWithHexString("#f5a623")
    static var colorReviewTitle         = Common.instance.colorWithHexString("#2196F3")
    static var colorPromotion           = Common.instance.colorWithHexString("#E34B4B")
    static var colorLine                = Common.instance.colorWithHexString("#f0f0f0")
    static var colorDate                = Common.instance.colorWithHexString("#898989")
    static var colorTag                 = Common.instance.colorWithHexString("#C3CE27")
    static var colorButtonBg            = Common.instance.colorWithHexString("#DDDDDD")
    static var colorSwipe               = Common.instance.colorWithHexString("#e56830")
    static var colorCancel              = Common.instance.colorWithHexString("#F41530")
    static var colorConfirm             = Common.instance.colorWithHexString("#68C701")
    
    
    /*
    // Dark Grey Color Theme
    static var colorHightLight          = Common.instance.colorWithHexString("#F5B612")
    static var windowBackground         = Common.instance.colorWithHexString("#fffff7")
    static var colorPrimaryLight        = Common.instance.colorWithHexString("#90A4AE")
    static var colorPrimary             = Common.instance.colorWithHexString("#37474F")
    static var colorPrimaryDark         = Common.instance.colorWithHexString("#263238")
    static var colorAccent              = Common.instance.colorWithHexString("#90a4ae")
    static var colorSelection           = Common.instance.colorWithHexString("#CCCCCC")
    static var colorTextAlt             = Common.instance.colorWithHexString("#FFFFFF")
    static var colorText                = Common.instance.colorWithHexString("#555555")
    static var colorTextLight           = Common.instance.colorWithHexString("#989898")
    static var colorSectionTitle        = Common.instance.colorWithHexString("#f5a623")
    static var colorReviewTitle         = Common.instance.colorWithHexString("#2196F3")
    static var colorPromotion           = Common.instance.colorWithHexString("#E34B4B")
    static var colorLine                = Common.instance.colorWithHexString("#f0f0f0")
    static var colorDate                = Common.instance.colorWithHexString("#898989")
    static var colorTag                 = Common.instance.colorWithHexString("#C3CE27")
    static var colorButtonBg            = Common.instance.colorWithHexString("#DDDDDD")
    static var colorSwipe               = Common.instance.colorWithHexString("#e56830")
    static var colorCancel              = Common.instance.colorWithHexString("#F41530")
    static var colorConfirm             = Common.instance.colorWithHexString("#68C701")
    */
    
    // Connection timeout Interval seconds
    static var timeoutInterval = 150
    
    // Line Spacing
    static let lineSpacing : CGFloat = 5
    
    // Filter by User
    static let IS_FAVOURITE_FILTER = "0"                // 0 no filter
    static let IS_EDITOR_PICKED_FILTER = "0"            // 0 no filter
    static let IS_TRENDING_FILTER = "1"                 // 1 filter
    
    // Counts
    static let HOTEL_LIST_COUNT = 10
    static let BOOKING_LIST_COUNT = 10
    static let REVIEW_DETAIL_COUNT = 10
    static let SEARCH_COUNT = 10
    static let COMMENT_COUNT = 10
    
    //no login user name
    static let default_user             = "nologinuser"
}

struct language {
    
    // APP
    static var appName                 = "Sama"
    static var percent                 = "%"
    
    
    // Nav Title
    static var psTitle                 = "Sama"
    static var promotionTitle          = "Promotion Hotels"
    static var searchResultTitle       = "Search Result"
    static var profileTitle            = "User Profile"
    static var profileEditTitle        = "User Profile Edit"
    static var passwordChangeTitle     = "Password Change"
    static var myFavTitle              = "My Favourite Hotels"
    static var myBookingTitle          = "My Booking List"
    static var aboutAppTitle           = "About Us"
    static var contactUsTitle          = "Contact Us"
    static var forgotPasswordTitle     = "Forgot Password"
    static var galleryTitle            = "Gallery"
    static let notiSettingTitle        = "Notification Setting"
    static var LoginTitle              = "Login"
    static var registerTitle           = "Register"
    static var inquiryTitle            = "Inquiry"
    static var bookingTitle            = "Hotel Booking"
    static var searchFilterTitle       = "Filter"
    static var searchLocationTitle     = "Select Destination"
    static var reviewTitle             = "Review"
    static var reviewSubmitTitle       = "Review Submit"
    static var reviewRoomFilter        = "Select Room"
    static var hotelFilterTitle        = "Filter"
    static var hotelTitle              = "Hotel"
    
    
    // Menu
    static var menu__home                   = "Find Hotels"
    static var menu__categories             = "Subscribe Categories"
    static var menu__hotelsRelated          = "Hotels Related"
    static var menu__recommendedHotel       = "Recommended Hotels"
    static var menu__newsByCategory         = "News By Category"
    static var menu__popularHotels          = "Popular Hotels"
    static var menu__promotion              = "Promotion Hotels"
    static var menu__searchNews             = "Search News"
    static var menu__userInfo               = "User Info"
    static var menu__profile                = "Profile"
    static var menu__myFavouriteItems       = "My Favourite Hotels"
    static var menu__logout                 = "Logout"
    static var menu__app                    = "App"
    static var menu__aboutApp               = "About Us"
    static var menu__contactUs              = "Contact Us"
    static var menu__setting                = "Notification Setting"
    static var menu__booking                = "My Booking List"
    
    
    // Search - Select Destination
    static var dest__country                = "Country : "
    
    // Search - Filter
    static var searchFilter__hotelRating    = "Hotel Star Rating"
    static var searchFilter__hotelPrice     = "Price"
    static var searchFilter__hotelFeatures  = "Hotel Features"
    static var searchFilter__guestRatingAll = "Guest Rating: All"
    static var searchFilter__guestRating    = "Guest Rating: "
    static var searchFilter__orHigher       = " or higher"
    static var searchFilter__plus           = " + "
    static var searchFilter__sign           = " $ "
    static var searchFilter__filter         = "Filter By Stars, Price, Rating"
    
    // Filter Room
    static var roomFilter__hotel            = "Hotel :"
    
    // Subscribe Categories
    static let subscribeCategory       = "Please select the category you want to see."
    
    // Search
    static let selectCategory          = "Please select the category"
    static let searchKeyword           = "Search Keywords"
    static let searchButton            = "Search"
    static let detaultCategoryName     = "All Categories"
    static let search__all             = "All"
    static let search__stars           = "Stars"
    static let search__starsS          = "S"
    static let search__review          = "Reviews"
    static let search__reviewR         = "R"
    static let search__price           = "Price"
    static let search__rating          = "Rating"
    static let search__pricePerNight   = "Price per night"
    static let search__checkInOutTime   = "Check in/out time"
    static let search__contactEmail     = "Contact email"
    static let search__contactPhone     = "Contact phone"
    static let search__tilde             = "~"
    static let search__slash            = "/"
    
    // Hotel
    static let hotel__rooms             = "Rooms"
    static let hotel__adults            = "adults"
    static let hotel__kids              = "kids"
    static let hotel__beds              = "beds"
    static let hotel__reviews           = "reviews"
    static let hotel__inquiry           = "Inquiry"
    static let hotel__extraBeds         = "Extra beds : "
    static let hotel__pricePerNight     = "Price per night"
    static let hotel__guestLimit        = "Gutest Limit"
    static let hotel__bedsCount         = "Beds"
    static let hotel__roomSize          = "Room Size"
    
    
    // Inquiry
    static let inquiry__name                  = "Name *"
    static let inquiry__email                 = "Email *"
    static let inquiry__phone                 = "Phone *"
    static let inquiry__title                 = "Title *"
    static let inquiry__message               = "Message *"
    static let inquiry__submit                = "Submit"
    
    // Booking
    static let booking__name                = "Name *"
    static let booking__email               = "Email *"
    static let booking__phone               = "Phone"
    static let booking__guestCount          = "How many guest?"
    static let booking__adultCount          = "Adult"
    static let booking__kidCount            = "Kids"
    static let booking__extraBeds           = "Extra bed count."
    static let booking__startDate           = "Start Date *"
    static let booking__endDate             = "End Date *"
    static let booking__remark              = "Remark"
    static let booking__submit              = "Submit"
    static let booking__0Count              = "0"
    static var booking__available           = "Book This Room";
    static var booking__not__available      = "Booking Not Available";
    
    
    // Search Popup
    static let popupHeader              = "Please select the categories."
    
    // Profile
    static let profile__likeLabel                = "Likes"
    static let profile__commentLabel             = "Comments"
    static let profile__favouriteLabel           = "Favourites"
    static let profile__emailTitle               = "Email"
    static let profile__phoneTitle               = "Phone"
    static let profile__aboutMeTitle             = "About Me"
    static let profile__joinedDateTitle          = "Joined Date"
    
    // Profile Edit
    static let profileEdit__userName        = "User Name *"
    static let profileEdit__email           = "Email *"
    static let profileEdit__phone           = "Phone"
    static let profileEdit__aboutMe         = "About Me"
    static let profileEdit__submit          = "Submit"
    static let profileEdit__passwordChange  = "Password Change"
    
    // Password Change
    static let passwordChange__password         = "Password"
    static let passwordChange__confirmPassword  = "Confirm Password"
    static let passwordChange__submit           = "Submit"
    
    // Login
    static let login__login                    = "Login"
    static let login__email                    = "Email"
    static let login__password                 = "Password"
    static let login__submit                   = "Submit"
    static let login__register                 = "Not a member? Join Now"
    static let login__forgot                   = "Forgot Password ?"
    
    // Register
    static let register__register              = "Registration"
    static let register__userName              = "User Name"
    static let register__email                 = "Email"
    static let register__password              = "Password"
    static let register__submit                = "Submit"
    static let register__login                 = "Already member? Login "
    
    // Forgot Password
    static let forgot__forgot                  = "Forgot Your Password ?"
    static let forgot__guide                   = "Enter your mail below to receive your password reset instructions."
    static let forgot__email                   = "Email"
    static let forgot__submit                  = "Submit"
    static let forgot__login                   = "Already member? Login "
    
    
    // AboutUs
    static let aboutUs__website                = "Visit To Our Website"
    static let aboutUs__email                  = "Email"
    static let aboutUs__phone                  = "Phone"
    static let aboutUs__facebook               = "Facebook"
    static let aboutUs__google_plus            = "Google Plus"
    static let aboutUs__twitter                = "Twitter"
    static let aboutUs__instagram              = "Instagram"
    static let aboutUs__youTube                = "YouTube"
    static let aboutUs__pinterest              = "Pinterest"
    
    // Contact Us
    static let contactUs__name                  = "Contact Name *"
    static let contactUs__email                 = "Contact Email *"
    static let contactUs__phone                 = "Contact Phone"
    static let contactUs__message               = "Contact Message *"
    static let contactUs__submit                = "Submit"
    
    
    // Notification Setting
    static let noti__title                      = "Notification Setting (On/Off)"
    static let noti__messageTitle               = "Latest Message From System."
    static let noti__registerSuccess            = "Successfully Register."
    static let noti__unregisterSuccess          = "Successfully Unregister."
    static let noti__noToken                    = "Can't get token ID from your device. Please try agian later."
    
    
    // Messages
    static var message__profile_edit_successful = "Updated profile successfully."
    static var message__registerSuccess         = "Your account registeration is successful. You are ready to login."
    static var message__shareMessage            = "PSHotels is solution to build News App easily. Check detail at www.panacea-soft.com"
    static var message__shareURL                = "http://codecanyon.net/user/panacea-soft"
    static var message__inquirySuccess          = "Inquiry sent. Please wait the reply from hotel."
    static var message__booking_success          = "Booking was successfully sent."
    
    // Error Messages
    static var error_message__no_user_in_local          = "Problem in getting user from local."
    static var error_message__blank_room                = "Please select room."
    static var error_message__blank_comment             = "Please input comment."
    static var error_message__blank_email               = "Please input email."
    static var error_message__blank_password            = "Please input password."
    static var error_message__blank_confirm_password    = "Please input confirm password."
    static var error_message__not_same_confirm_password = "Password are not same."
    static var error_message__blank_username            = "Please input username."
    static var error_message__blank_keyword             = "Please input search keyword."
    static var error_message__blank_city                = "Please select city."
    
    static var error_message__invalid_date              = "Please select valid date."
    static var error_message__blank_contact_name        = "Please input name."
    static var error_message__blank_contact_email       = "Please input email."
    static var error_message__blank_contact_phone       = "Please input phone."
    static var error_message__blank_message             = "Please input message."
    static var error_message__blank_title               = "Please input title."
    static var error_message__blank_input               = "Please select "
    static var error_message__blank_start_date          = "Please input start date."
    static var error_message__blank_end_date            = "Please input end date."
    static var error_message__not_number                = "Please input number."
    static var error_message__no_internet_connection    = "No Internet Connection!"
    static var error_message__imageIsNull               = "Oops! selected image is blank."
    
    // General
    static var btnOK                           = "OK"
    
    //Booking
    
    
 
}

struct notiKey {
    static var deviceIDKey      = "DEVICE_ID"
    static var deviceTokenKey   = "TOKEN"
    static var isRegister       = "IS_REGISTER"
    static var notiMessageKey   = "NOTI_MSG"
    static var notiLatestMessage = "NOTI_LATEST_MESSAGE"
    static var devicePlatform   = "IOS"
    
    static var unRegister       = "UNREGISTER"
    static var registered       = "REGISTERED"
}

struct customFont{
    
    
    static var normalFontName               = "Helvetica Neue"
    static var normalBoldFontName           = "HelveticaNeue-Bold"
    static let menuFontName                 = "Helvetica Neue"
    
    static var bookingDaySize : CGFloat          = 39
    static var headerFontSize : CGFloat          = 20
    static var subHeaderFontSize: CGFloat        = 18
    static var tagFontSize : CGFloat             = 14
    static var dateFontSize : CGFloat            = 13
    static var textFontSize : CGFloat            = 16
    static var detailTextFontSize: CGFloat       = 16
    
    static var menuUIFont = Common.instance.getUIFont(fontName: menuFontName, fontSize: subHeaderFontSize)
    
    static var bookingDayUIFont = Common.instance.getUIFont(fontName: normalFontName, fontSize: bookingDaySize)
    
    static var normalUIFont = Common.instance.getUIFont(fontName: normalFontName, fontSize: textFontSize)
    
    static var normalBoldUIFont = Common.instance.getUIFont(fontName: normalBoldFontName, fontSize: textFontSize)
    
    static var headerUIFont = Common.instance.getUIFont(fontName: normalFontName, fontSize: headerFontSize)
    
    static var subHeaderUIFont = Common.instance.getUIFont(fontName: normalFontName, fontSize: subHeaderFontSize)
    
    static var subHeaderBoldUIFont = Common.instance.getUIFont(fontName: normalBoldFontName, fontSize: subHeaderFontSize)
    
    static var tagUIFont = Common.instance.getUIFont(fontName: normalFontName, fontSize: tagFontSize)
    
    static var dateUIFont = Common.instance.getUIFont(fontName: normalFontName, fontSize: dateFontSize)
    
    static var datailTextUIFont = Common.instance.getUIFont(fontName: normalFontName, fontSize: detailTextFontSize)
}

struct admobConfig {
    static var isEnabled = false
    static var bannerAdUnitId = "ca-app-pub-8907881762519005/4386840291"
    static var interstitialAdUnitId = "ca-app-pub-8907881762519005/4718846932"
    static var admobAppId = "ca-app-pub-8907881762519005~8465686104"
}

struct buildType {
    static let development  = "development"
    static let production   = "production"
}

struct appStatus {
    
    // Change buildType.production if app is ready for release.
    // So, It will not do print
    static let appBuildType = buildType.development
    
}

struct UserInfoKeys {
    static let loginUserId = "LOGIN_USER_ID"
    static let userName = "USER_NAME"
    static let userEmail = "USER_EMAIL"
    static let userPhone = "USER_PHONE"
    static let userAboutMe = "USER_ABOUTME"
    static let userCoverPhoto = "USER_COVER_PHOTO"
    static let userProfilePhoto = "USER_PROFILE_PHOTO"
    static let addedDate = "USER_ADDED_DATE"
    static let likeCount = "USER_LIKE_COUNT"
    static let commentsCount = "USER_COMMENT_COUNT"
    static let favouriteCount = "USER_FAVOURITE_COUNT"
}

struct UserContact {
    static let UC_name = "UC_CONTACT_NAME"
    static let UC_email = "UC_CONTACT_EMAIL"
    static let UC_phone = "UC_CONTACT_PHONE"
    static let UC_title = "UC_CONTACT_TITLE"
    static let UC_message = "UC_CONTACT_MESSAGE"
}

struct SearchLog {
    static let SL_cityId = "SL_CITYID"
    static let SL_cityName = "SL_NAME"
    static let SL_hotelName = "SL_HOTEL_NAME"
    static let SL_starRating = "SL_STAR_RATING"
    static let SL_lowerPrice = "SL_LOWER_PRICE"
    static let SL_upperPrice = "SL_UPPER_PRICE"
    static let SL_guestRating = "SL_GUEST_RATING"
}



