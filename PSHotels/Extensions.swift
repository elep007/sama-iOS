//
//  Extensions.swift
//
//  Created by Panacea-Soft on 10/3/16.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation
import Alamofire

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    // For image loading from server with url
    func loadImage(urlString : String, completionHandler: @escaping (String, String, UIImage, String) -> Void) {

        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage
        {
            DispatchQueue.main.async(execute: { () -> Void in
                self.image = imageFromCache
            })
            completionHandler(STATUS.success, "\(urlString) ( From Cache )", imageFromCache, "success")
            return
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            if let image = UIImage(named:"PlaceholderImage") {
                self.image = image
            }
        })
        DispatchQueue.main.async(execute: { () -> Void in
        ps.print("URL : " + urlString)
        Alamofire.request(urlString).responseData { response in
            guard let data = response.result.value else {
                let errmsg : String = "error in loading image."
                let img = UIImage()
                
                completionHandler(STATUS.fail, urlString, img, errmsg)
                
                return
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                self.image = UIImage(data: data)
                
                if self.image != nil {
                
                    imageCache.setObject(self.image!, forKey: urlString as AnyObject)
                    completionHandler(STATUS.success, urlString, self.image!, "success")
                }else {
                    completionHandler(STATUS.fail, urlString, UIImage(), "success")
                }
            })
            
            
        }
        })
        
    }
}

extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

//https://stackoverflow.com/a/46288728/2691537
public extension KeyedDecodingContainer  {
    
    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        let stringValue = try self.decode(String.self, forKey: key)
        guard let floatValue = Int(stringValue) else {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Could not parse json key to a Float object")
            throw DecodingError.dataCorrupted(context)
        }
        return floatValue
    }
    
}

