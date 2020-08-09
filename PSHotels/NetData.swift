//
//  NetData.swift
//
//  Created by Panacea-soft on 28/1/16.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation
import UIKit

enum MimeType: String {
    case ImageJpeg = "image/jpeg"
    case ImagePng = "image/png"
    case ImageGif = "image/gif"
    case Json = "application/json"
    case Unknown = ""
    
    func getString() -> String? {
        switch self {
        case .ImagePng:
            fallthrough
        case .ImageJpeg:
            fallthrough
        case .ImageGif:
            fallthrough
        case .Json:
            return self.rawValue
        case .Unknown:
            fallthrough
        default:
            return nil
        }
    }
}

class NetData
{
    let data: Data
    let mimeType: MimeType
    let filename: String
    
    init(data: Data, mimeType: MimeType, filename: String) {
        self.data = data
        self.mimeType = mimeType
        self.filename = filename
    }
    
    init(pngImage: UIImage, filename: String) {
        data = pngImage.pngData()!
        self.mimeType = MimeType.ImagePng
        self.filename = filename
    }
    
    init(jpegImage: UIImage, compressionQuanlity: CGFloat, filename: String) {
        data = jpegImage.jpegData(compressionQuality: compressionQuanlity)!
        self.mimeType = MimeType.ImageJpeg
        self.filename = filename
    }
}
