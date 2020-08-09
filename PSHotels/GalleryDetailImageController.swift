//
//  PageItemController.swift
//
//  Created by Panacea-soft on 2/11/18
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import UIKit
import SDWebImage

class GalleryDetailImageController: UIViewController {
 
    var itemIndex: Int = 0
    var imageDesc: String = ""
    var imageName: String = ""
    
    @IBOutlet weak var imageScrollView: ImageScrollView!
    
    @IBOutlet weak var imageDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url : String = "\(configs.imageUrl)\(imageName)"
        
        self.imageScrollView.display(image: UIImage(named: "PlaceholderImage")!)
        self.imageScrollView.adjustFrameToCenter()
        SDWebImageManager.shared().loadImage(with: NSURL(string: url) as URL?, options: .continueInBackground, progress:  {
            (receivedSize :Int, ExpectedSize :Int, url) in
            
            },  completed: {
                (image : UIImage?, data: Data?, error : Error?, cacheType : SDImageCacheType, finished : Bool, url : URL?) in

            if error == nil {
                self.imageScrollView.display(image: image!)
                self.imageScrollView.adjustFrameToCenter()
            }
        })
        
        imageDescription.text = imageDesc
        
        imageDescription.font = customFont.normalUIFont
        imageDescription.textColor = configs.colorText
    }
    
    
}
