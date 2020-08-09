//
//  ImageSliderViewController.swift
//
//  Created by Panacea-Soft on 2/11/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import UIKit

class GalleryDetailSliderViewController : PSUIViewController {
    
    var itemImages = [Image]()
    var imageCache = NSCache<AnyObject, AnyObject>()
    weak var pageViewController: UIPageViewController?
    var selectedIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.controllerTitle = language.galleryTitle
        
        createPageViewController()
        setupPageControl()
   }
   
    override func viewDidDisappear(_ animated: Bool) {
        let appearance = UIPageControl.appearance()
        appearance.backgroundColor = UIColor.clear
    }
    
   func createPageViewController() {
        
        let pageController = self.storyboard!.instantiateViewController(withIdentifier: "PageController") as! UIPageViewController
        pageController.dataSource = self
        
        if itemImages.count > 0 {
            
            var localIndex = 0
            if selectedIndex < itemImages.count {
                localIndex = selectedIndex
            }
            
            let firstController = getItemController(localIndex)!
            let startingViewControllers: NSArray = [firstController]
            pageController.setViewControllers(startingViewControllers as? [UIViewController], direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
    addChild(pageViewController!)
        self.view.addSubview(pageViewController!.view)
    pageViewController!.didMove(toParent: self)
    }
    
    func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.gray
        appearance.currentPageIndicatorTintColor = UIColor.white
        appearance.backgroundColor = UIColor.darkGray
    }
    
    
}


extension GalleryDetailSliderViewController : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! GalleryDetailImageController
        
        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex-1)
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! GalleryDetailImageController
        
        if itemController.itemIndex+1 < itemImages.count {
            return getItemController(itemController.itemIndex+1)
        }
        
        return nil
    }
    
    func getItemController(_ itemIndex: Int) -> GalleryDetailImageController? {
        if itemIndex < itemImages.count {
            let pageItemController = self.storyboard!.instantiateViewController(withIdentifier: "ItemImageController") as! GalleryDetailImageController
            pageItemController.itemIndex = itemIndex
            pageItemController.imageName = itemImages[itemIndex].img_path
            pageItemController.imageDesc = itemImages[itemIndex].img_desc
            return pageItemController
        }
        
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return itemImages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        var localIndex = 0
        if selectedIndex < itemImages.count {
            localIndex = selectedIndex
        }
        return localIndex
    }
}





