//
//  APIRouters.swift
//
//  Created by Panacea-soft on 14/1/16.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Alamofire
import Foundation

enum APIRouters: URLRequestConvertible {
    /// Returns a URL request or throws if an `Error` was encountered.
    ///
    /// - throws: An `Error` if the underlying `URLRequest` is `nil`.
    ///
    /// - returns: A URL request.
    public func asURLRequest() throws -> URLRequest {
        let result: (path: String, parameters: Parameters, method : HTTPMethod) = {
            switch self {
            
            // ****************************************************
            // PSHotels API
            // ****************************************************
            case .GetCities(let apiKey):
                
                let url: String = NSString(format: APIRouters.getCities as NSString, apiKey) as String
                return (url, ["params":"no"], .get)
                
            case .GetHotels(let apiKey, let loginUserId):
                
                let url: String = NSString(format: APIRouters.getHotels as NSString, apiKey, loginUserId) as String
                return (url, ["params":"no"], .get)
                
            case .GetHotelByHotelId(let apiKey, let loginUserId, let hotelId):
                
                let url: String = NSString(format: APIRouters.getHotelByHotelId as NSString, apiKey, loginUserId, hotelId) as String
                return (url, ["params":"no"], .get)
                
            case .GetRoomByRoomId(let apiKey, let loginUserId, let roomId):
                
                let url: String = NSString(format: APIRouters.getRoomByRoomId as NSString, apiKey, loginUserId, roomId) as String
                return (url, ["params":"no"], .get)
                
            case .GetRoomListByHotelId(let apiKey, let hotelId):
                
                let url: String = NSString(format: APIRouters.getRoomListByHotelId as NSString, apiKey, hotelId) as String
                return (url, ["params":"no"], .get)
                
            case .GetPrice(let apiKey):
                
                let url: String = NSString(format: APIRouters.getPrice as NSString, apiKey) as String
                return (url, ["params":"no"], .get)
                
            case .GetHotelInfo(let apiKey):
                
                let url: String = NSString(format: APIRouters.getHotelInfo as NSString, apiKey) as String
                return (url, ["params":"no"], .get)
                
            case .PostSearchHotel(let apiKey, let loginUserId, let limit, let offset, let params):
                
                let url: String = NSString(format: APIRouters.postSearchHotel as NSString, apiKey, loginUserId, limit, offset) as String
                return (url, params, .post)
                
            case .GetHotelReviewSummary(let apiKey, let parentId):
                
                let url: String = NSString(format: APIRouters.getHotelReviewSummary as NSString, apiKey, parentId) as String
                return (url, ["params":"no"], .get)
                
            case .GetHotelReviewDetail(let apiKey, let parentId, let limit, let offset):
                
                let url: String = NSString(format: APIRouters.getHotelReviewDetail as NSString, apiKey, parentId, limit, offset) as String
                return (url, ["params":"no"], .get)
                
            case .GetRoomReviewSummary(let apiKey, let parentId):
                
                let url: String = NSString(format: APIRouters.getRoomReviewSummary as NSString, apiKey, parentId) as String
                return (url, ["params":"no"], .get)
                
            case .GetRoomReviewDetail(let apiKey, let parentId, let limit, let offset):
                
                let url: String = NSString(format: APIRouters.getRoomReviewDetail as NSString, apiKey, parentId, limit, offset) as String
                return (url, ["params":"no"], .get)
                
            case .GetHotelFeaturesByHotelId(let apiKey, let hotelId):
                
                let url: String = NSString(format: APIRouters.getHotelFeaturesByHotelId as NSString, apiKey, hotelId) as String
                return (url, ["params":"no"], .get)
                
            case .GetHotelFeaturesByCityId(let apiKey, let cityId):
                
                let url: String = NSString(format: APIRouters.getHotelFeaturesByCityId as NSString, apiKey, cityId) as String
                return (url, ["params":"no"], .get)
                
            case .GetRoomFeaturesByRoomId(let apiKey, let roomId):
                
                let url: String = NSString(format: APIRouters.getRoomFeaturesByRoomId as NSString, apiKey, roomId) as String
                return (url, ["params":"no"], .get)
                
            case .GetRoomFeaturesByHotelId(let apiKey, let hotelId):
                
                let url: String = NSString(format: APIRouters.getRoomFeaturesByHotelId as NSString, apiKey, hotelId) as String
                return (url, ["params":"no"], .get)
                
            case .PostReview(let apiKey, let params):
                
                let url: String = NSString(format: APIRouters.postReview as NSString, apiKey) as String
                return (url, params, .post)
                
            case .GetReviewCategory(let apiKey):
                
                let url: String = NSString(format: APIRouters.getReviewCategory as NSString, apiKey) as String
                return (url, ["params":"no"], .get)
                
            case .PostInquiry(let apiKey, let params):
                
                let url: String = NSString(format: APIRouters.postInquiry as NSString, apiKey) as String
                return (url, params, .post)
            
            case .PostBooking(let apiKey, let params):
                
                let url: String = NSString(format: APIRouters.postBooking as NSString, apiKey) as String
                return (url, params, .post)
                
                
            case .GetRecommendedHotelList(let apiKey, let loginUserId, let limit, let offset):
                
                let url: String = NSString(format: APIRouters.getRecommendedHotels as NSString, apiKey, loginUserId, limit, offset) as String
                return (url, ["params":"no"], .get)
                
            case .GetPromotionHotelList(let apiKey, let loginUserId, let limit, let offset):
                
                let url: String = NSString(format: APIRouters.getPromotionHotels as NSString, apiKey, loginUserId, limit, offset) as String
                return (url, ["params":"no"], .get)
                
            case .GetPopularHotelList(let apiKey, let loginUserId, let limit, let offset):
                
                let url: String = NSString(format: APIRouters.getPopularHotels as NSString, apiKey, loginUserId, limit, offset) as String
                return (url, ["params":"no"], .get)
                
            case .GetFavouriteHotelList(let apiKey, let loginUserId, let limit, let offset):
                
                let url: String = NSString(format: APIRouters.getFavouriteHotels as NSString, apiKey, loginUserId, limit, offset) as String
                return (url, ["params":"no"], .get)
                
            case .PostFavHotel(let apiKey, let params):
                
                let url: String = NSString(format: APIRouters.postFavHotel as NSString, apiKey) as String
                return (url, params, .post)
                
            case .PostHotelTouchCount(let apiKey, let params):
                
                let url: String = NSString(format: APIRouters.postHotelTouchCount as NSString, apiKey) as String
                return (url, params, .post)
                
            case .PostRoomTouchCount(let apiKey, let params):
                
                let url: String = NSString(format: APIRouters.postRoomTouchCount as NSString, apiKey) as String
                return (url, params, .post)
                
           
            case .PostRegisterNotiToken(let apiKey, let params):
                
                let url: String = NSString(format: APIRouters.postRegisterNotiToken as NSString, apiKey) as String
                return (url, params, .post)
                
            case .PostUnregisterNotiToken(let apiKey, let params):
                
                let url: String = NSString(format: APIRouters.postUnregisterNotiToken as NSString, apiKey) as String
                return (url, params, .post)
                
            case .GetUser(let apiKey, let loginUserId):
                
                let url: String = NSString(format: APIRouters.getUser as NSString, apiKey, loginUserId) as String
                return (url, ["params":"no"], .get)
                
            //uploadimage
            case .PostUserLogin(let apiKey, let params):
                
                let url: String = NSString(format: APIRouters.postUserLogin as NSString, apiKey) as String
                return (url, params, .post)
                
            case .PostUser(let apiKey, let params):
                
                let url: String = NSString(format: APIRouters.postUser as NSString, apiKey) as String
                return (url, params, .post)
                
            case .PostForgotPassword(let apiKey, let params):
                
                let url: String = NSString(format: APIRouters.postForgotPassword as NSString, apiKey) as String
                return (url, params, .post)
                
            case .PutUser(let apiKey, let params):
                
                let url: String = NSString(format: APIRouters.putUser as NSString, apiKey) as String
                return (url, params, .put)
                
            case .PutPassword(let apiKey, let params):
                
                let url: String = NSString(format: APIRouters.postPasswordUpdate as NSString, apiKey) as String
                return (url, params, .put)
                
            case .GetAboutUs(let apiKey):
                
                let url: String = NSString(format: APIRouters.getAboutUs as NSString, apiKey) as String
                return (url, ["params":"no"], .get)
                
            case .GetImageList(let apiKey, let imageParentId):
                
                let url: String = NSString(format: APIRouters.getImageList as NSString, apiKey, imageParentId) as String
                return (url, ["params":"no"], .get)
                
            case .PostContactUs(let apiKey, let params):
                
                let url: String = NSString(format: APIRouters.postContactUs as NSString, apiKey) as String
                return (url, params, .post)
                
            case .GetBookingList(let apiKey, let loginUserId, let limit, let offset):
                
                let url: String = NSString(format: APIRouters.getBookingList as NSString, apiKey, loginUserId, limit, offset) as String
                return (url, ["params":"no"], .get)
                
            }
        }()
        
        let url = try APIRouters.baseURLString.asURL()
        let cachePolicy: NSURLRequest.CachePolicy = Connectivity.isConnected() ? .reloadIgnoringLocalCacheData : .returnCacheDataElseLoad
        
        let timeout = 1
        var urlRequest = URLRequest(url: url.appendingPathComponent(result.path), cachePolicy: cachePolicy, timeoutInterval: TimeInterval(timeout))
        urlRequest.addValue("private", forHTTPHeaderField: "Cache-Control")
        //urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = result.method.rawValue
        print(" Time Interval \(TimeInterval(configs.timeoutInterval))")
        urlRequest.timeoutInterval = TimeInterval(configs.timeoutInterval)
        ps.print(try URLEncoding.default.encode(urlRequest, with: result.parameters))
        return try URLEncoding.default.encode(urlRequest, with: result.parameters)
    }

    static let baseURLString = configs.mainUrl
    static let imageURLString = configs.imageUrl
    
    // PSHotels API
    static let getCities                = configs.getCities
    static let getHotels                = configs.getHotels
    static let getHotelByHotelId        = configs.getHotelByHotelId
    static let getRoomByRoomId          = configs.getRoomByRoomId
    static let getRoomListByHotelId     = configs.getRoomListByHotelId
    static let getPrice                 = configs.getPrice
    static let getHotelInfo             = configs.getHotelInfo
    static let postSearchHotel          = configs.postSearchHotel
    static let getHotelReviewSummary    = configs.getHotelReviewSummary
    static let getHotelReviewDetail     = configs.getHotelReviewDetail
    static let getRoomReviewSummary     = configs.getRoomReviewSummary
    static let getRoomReviewDetail      = configs.getRoomReviewDetail
    static let getHotelFeaturesByHotelId = configs.getHotelFeaturesByHotelId
    static let getHotelFeaturesByCityId = configs.getHotelFeaturesByCityId
    static let getRoomFeaturesByRoomId  = configs.getRoomFeaturesByRoomId
    static let getRoomFeaturesByHotelId = configs.getRoomFeaturesByHotelId
    static let postReview               = configs.postReview
    static let getReviewCategory        = configs.getReviewCategory
    static let postInquiry              = configs.postInquiry
    static let postBooking              = configs.postBooking
    static let getRecommendedHotels     = configs.getRecommendedHotels
    static let getPromotionHotels       = configs.getPromotionHotels
    static let getPopularHotels         = configs.getPopularHotels
    static let getFavouriteHotels       = configs.getFavouriteHotels
    static let postFavHotel             = configs.postFavHotel
    static let postHotelTouchCount      = configs.postHotelTouchCount
    static let postRoomTouchCount       = configs.postRoomTouchCount
    static let postRegisterNotiToken    = configs.postRegisterNotiToken
    static let postUnregisterNotiToken  = configs.postUnregisterNotiToken
    static let getUser                  = configs.getUser
    static let doUploadImage            = configs.doUploadImage
    static let postUserLogin            = configs.postUserLogin
    static let postUser                 = configs.postUser
    static let postForgotPassword       = configs.postForgotPassword
    static let putUser                  = configs.putUser
    static let postPasswordUpdate       = configs.postPasswordUpdate
    static let getAboutUs               = configs.getAboutUs
    static let getImageList             = configs.getImageList
    static let postContactUs            = configs.postContactUs
    static let getBookingList           = configs.getBookingList
    
    // ****************************************************
    // PSHotels API
    // ****************************************************
    case GetCities(String)
    case GetHotels(String, String)
    case GetHotelByHotelId(String, String, String)
    case GetRoomByRoomId(String, String, String)
    case GetPrice(String)
    case GetRoomListByHotelId(String, String)
    case GetHotelInfo(String)
    case PostSearchHotel(String, String, Int, Int, [String: AnyObject])
    case GetHotelReviewSummary(String, String)
    case GetHotelReviewDetail(String, String, Int, Int)
    case GetRoomReviewSummary(String, String)
    case GetRoomReviewDetail(String, String, Int, Int)
    case GetHotelFeaturesByHotelId(String, String)
    case GetHotelFeaturesByCityId(String, String)
    case GetRoomFeaturesByRoomId(String, String)
    case GetRoomFeaturesByHotelId(String, String)
    case PostReview(String, [String : AnyObject])
    case GetReviewCategory(String)
    case PostInquiry(String, [String : AnyObject])
    case PostBooking(String, [String : AnyObject])
    case GetRecommendedHotelList(String, String, Int, Int)
    case GetPromotionHotelList(String, String, Int, Int)
    case GetPopularHotelList(String, String, Int, Int)
    case GetFavouriteHotelList(String, String, Int, Int)
    case PostFavHotel(String, [String : AnyObject])
    case PostHotelTouchCount(String, [String : AnyObject])
    case PostRoomTouchCount(String, [String : AnyObject])
    case PostRegisterNotiToken(String, [String : AnyObject])
    case PostUnregisterNotiToken(String, [String : AnyObject])
    case GetUser(String, String)
    //uploadimage
    case PostUserLogin(String, [String : AnyObject])
    case PostUser(String, [String : AnyObject])
    case PostForgotPassword(String, [String : AnyObject])
    case PutUser(String, [String : AnyObject])
    case PutPassword(String, [String : AnyObject])
    case GetAboutUs(String)
    case GetImageList(String, String)
    case PostContactUs(String, [String: AnyObject])
    case GetBookingList(String, String, Int, Int)
    
    }



func UploadImage(url: String, userId: String, platform: String, image : UIImage, completionHandler: @escaping (Resourse<User>) -> Void) {
    
    
        var resourse : Resourse<User>?
    
        let myUrl = NSURL(string: APIRouters.baseURLString + url)
        
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        
        
        let param = [
            "platform_name"  : platform,
            "user_id"    : "\(userId)"
        ]
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let imageData = image.jpegData(compressionQuality: 1)
        
        if(imageData==nil)  {
            resourse = Resourse(status: Status.ERROR, message: language.error_message__imageIsNull)
            DispatchQueue.main.async {
                completionHandler(resourse!)
                
            }
            return;
        }
        
        request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "pic", imageDataKey: imageData! as NSData, boundary: boundary) as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            guard let _ = data, error == nil else {                                                 // check for fundamental networking error
                ps.print("error=\(String(describing: error))")
                resourse = Resourse(status: Status.ERROR, message: language.error_message__no_internet_connection)
                DispatchQueue.main.async {
                    completionHandler(resourse!)
                }
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                ps.print("statusCode should be 200, but is \(httpStatus.statusCode)")
                ps.print("response = \(String(describing: response))")
                
                
                resourse = Resourse(status: Status.ERROR, message: language.error_message__no_internet_connection)
                DispatchQueue.main.async {
                    completionHandler(resourse!)
                }
                
                return
                
            }
            
            // You can print out response object
            ps.print("******* response = \(String(describing: response))")
            
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            ps.print("****** response data = \(responseString!)")
            
            do {
                
                let result = try JSONDecoder().decode(User.self, from: data!)
                
                
                resourse = Resourse(status: Status.SUCCESS, message: "", data: result)
                
                DispatchQueue.main.async {
                    completionHandler(resourse!)
                }
                
                
            }catch
            {
                
                DispatchQueue.main.async {
                    resourse = Resourse(status: Status.ERROR, message: "Error in parsing data. ")
                    DispatchQueue.main.async {
                        completionHandler(resourse!)
                    }
                    
                }
                return

            }
            
        }
        task.resume()
    
    
}

func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
    let body = NSMutableData();
    
    if parameters != nil {
        for (key, value) in parameters! {
            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString(string: "\(value)\r\n")
        }
    }
    
    let filename = "user-profile.jpg"
    let mimetype = "image/jpg"
    
    body.appendString(string: "--\(boundary)\r\n")
    body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
    body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
    body.append(imageDataKey as Data)
    body.appendString(string: "\r\n")
    
    body.appendString(string: "--\(boundary)--\r\n")
    
    return body
}

func generateBoundaryString() -> String {
    return "Boundary-\(NSUUID().uuidString)"
}

struct  STATUS {
    static let success : String = "success"
    static let fail : String = "fail"
}
