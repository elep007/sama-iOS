//
//  GalleryView.swift
//  PSImage
//
//  Created by Panacea-Soft on 2/14/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation


class GalleryView : PSUIView {
    
    // MARK: Custom Variables
    // NibName of View. This variable will use later in getNibName()
    @IBOutlet weak var imageListCollectionView: UICollectionView!
    var imageViewModel : ImageViewModel = ImageViewModel()
    var uiRefresher : UIRefreshControl?
    var newsId: String = ""
    var parent : GalleryViewController?
    
    // MARK: - Override Functions
    override func initVariables() {
        imageViewModel.nibName = "GalleryView"
        imageViewModel.cellId = "GalleryCollectionViewCell"
    }
    
    // joining ImageListView.swift and ImageListView.xib
    override func getNibName() -> String {
        return imageViewModel.nibName
    }
    
    
    override func initUIViewAndActions() {
        super.initUIViewAndActions()
        
        super.initPinterestCollectionView(collectionView: imageListCollectionView, nibName: imageViewModel.cellId, numberOfColumns: 3)
        
        // Loading Monitoring
        imageViewModel.isLoading.bind{
            if($0) {
                Common.instance.showBarLoading()
            }else {
                Common.instance.hideBarLoading()
            }
        }
        
    }
    override func initData() {
        
        
        // Load data from PS Server
        imageViewModel.getImageList(newsId: newsId)
        
        imageViewModel.imageListLiveData.bind{ [weak self] in
            
            if let imageListResourse : Resourse<[Image]> = $0 {
                
                if imageListResourse.status == Status.SUCCESS
                    || imageListResourse.status == Status.LOADING {
                    
                    DispatchQueue.main.async{
                        
                        self?.imageListCollectionView?.reloadData()
                        
                        if let layout = self?.imageListCollectionView.collectionViewLayout as? PinterestLayout {
                            layout.reset()
                            
                        }
                    }
                    
                }else {
                    print("Error in loading data. Message : " + imageListResourse.message)
                }
            }else {
                print("Something Wrong")
            }
            
        }
        
    }
}



// MARK: - Collection View Datasource extension
extension GalleryView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = imageViewModel.cellId
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! GalleryCollectionViewCell
        
        if let data = imageViewModel.imageListLiveData.value?.data {
            
            let imageURL = configs.imageUrl + data[indexPath.row].img_path
            
            cell.galleryImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "PlaceholderImage"))
           
            
        }
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let data = imageViewModel.imageListLiveData.value?.data {
            print("data count \(data.count)")
            return data.count
        }else {
            return 0
        }
        
    }
}




// MARK: - Collection View Delegate extension
extension GalleryView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ps.print("Selected Index \(indexPath.row)")
        
        if let data = self.imageViewModel.imageListLiveData.value?.data {
            PSNavigationController.instance.updateBackButton()
            if let layout = self.imageListCollectionView.collectionViewLayout as? PinterestLayout {
                layout.reset()
                
            }
            
            let imgSliderViewController = self.parent?.storyboard?.instantiateViewController(withIdentifier: "ImageSlider") as? GalleryDetailSliderViewController
            self.parent?.navigationController?.pushViewController(imgSliderViewController!, animated: true)
            imgSliderViewController?.itemImages = data
            imgSliderViewController?.selectedIndex = indexPath.row
            
        }
        
    }
    
}


// MARK: - PinterestLayout Delegate Extension
extension GalleryView : PinterestLayoutDelegate {
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath , withWidth width:CGFloat) -> CGFloat {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 199
        }else {
            return 99
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        print(contentHeight)
        print(Common.instance.screenSize.height)
        if contentHeight >= Common.instance.screenSize.height {
            if offsetY > contentHeight - scrollView.frame.size.height {
                print("going to load")
                if(!imageViewModel.isLoading.value) {
                    print("start loading")
                    imageViewModel.getImageList(newsId: newsId)
                }
            }
        }
    }
}

