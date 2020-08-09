//
//  HotelFeaturesView.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/7/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

// MARK: Protocols
@objc protocol HotelFeaturesViewDelegate: class {
    func resizeHotelFeaturesContainer(_ height: CGFloat)
}


@IBDesignable
class HotelFeaturesView: PSUIView {
    
    //MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Custom variables
    // NibName of View. This variable will use later in getNibName()
    var hotelFeatureViewModel : HotelFeatureViewModel = HotelFeatureViewModel()
    var parentView : UIViewController?
    var delegate : HotelFeaturesViewDelegate!
    var sectionCount = 0
    var itemCount = 0
    var hotelData : Hotel? = nil
    
    // MARK: - Override Functions
    override func initVariables() {
        hotelFeatureViewModel.nibName = "HotelFeaturesView"
        hotelFeatureViewModel.cellId = "FeatureCollectionViewCell"
        hotelFeatureViewModel.headerCellId = "FeatureHeaderCollectionReusableView"
    }
    
    
    // MARK: - Override Functions
    // joining DetailView.swift and DetailView.xib
    override func getNibName() -> String {
        return hotelFeatureViewModel.nibName
    }
    
    
    override func initUIViewAndActions() {
        
        super.initCollectionView(collectionView: collectionView, nibName: hotelFeatureViewModel.cellId, nibHeaderName: hotelFeatureViewModel.headerCellId)
       
    }
    
    override func initData() {
        // Load data from PS Server
        
        hotelFeatureViewModel.getHotelFeatures(hotelId: (hotelData?.hotel_id)!)
        hotelFeatureViewModel.hotelFeatureListByHotelIdLiveData.bind{ [weak self] in
            
            if let resourse : Resourse<[HotelFeature]> = $0 {
                
                if resourse.status == Status.SUCCESS
                    || resourse.status == Status.LOADING {
                    
                    if let hotelFeatureList : [HotelFeature] = resourse.data {
                        
                        if hotelFeatureList.count > 0 {
                            
                            let lSectionCount = hotelFeatureList.count
                            var lItemCount = 0
                            
                            for i in 0..<hotelFeatureList.count {
                                lItemCount = lItemCount + hotelFeatureList[i].types.count
                            }
                            
                            self?.delegate.resizeHotelFeaturesContainer(CGFloat((lSectionCount*70) + (lItemCount*30) + 200))
                            
                            self?.collectionView.reloadData()
                            
                        }
                    }
                    
                    
                } else if resourse.status == Status.ERROR {
                    print("Error in loading data. Message : " + resourse.message)
                }
            }else {
                print("Something Wrong")
            }
            
        }
        
       
    }
    
}


// MARK: - Collection View Datasource extension
extension HotelFeaturesView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hotelFeatureViewModel.cellId, for: indexPath) as! FeatureCollectionViewCell
        
        if let data = self.hotelFeatureViewModel.hotelFeatureListByHotelIdLiveData.value?.data {
            
            cell.featureLabel.text = data[indexPath.section].types[indexPath.row].hinfo_typ_name
            
            
        }
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if let data = self.hotelFeatureViewModel.hotelFeatureListByHotelIdLiveData.value?.data {
            return data.count
        }else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = self.hotelFeatureViewModel.hotelFeatureListByHotelIdLiveData.value?.data {
            
            return data[section].types.count
            
        }else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: hotelFeatureViewModel.headerCellId, for: indexPath) as! FeatureHeaderCollectionReusableView
            if let data = self.hotelFeatureViewModel.hotelFeatureListByHotelIdLiveData.value?.data {
                
                sectionHeaderView.featureHeaderLabel.text = data[indexPath.section].hinfo_grp_name
                
                // hotel ImageView
                let imageURL = configs.imageUrl + data[indexPath.section].default_photo.img_path
                
                sectionHeaderView.featureHeaderImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "PlaceholderImage"))
                
            }
            
            
            return sectionHeaderView
        }else {
            let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: hotelFeatureViewModel.headerCellId, for: indexPath) as! FeatureHeaderCollectionReusableView
            
            return sectionHeaderView
        }
    }
    
    
}
extension HotelFeaturesView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSize(width: self.view.bounds.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 30)
    }
    
}

extension HotelFeaturesView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected Index \(indexPath.row)")
        
    }
    
}


