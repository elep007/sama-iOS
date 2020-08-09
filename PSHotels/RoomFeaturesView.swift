//
//  RoomFeaturesView.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/13/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

// MARK: Protocols
@objc protocol RoomFeaturesViewDelegate: class {
    func resizeRoomFeaturesContainer(_ height: CGFloat)
}


@IBDesignable
class RoomFeaturesView: PSUIView {
    
    //MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    var hotelViewModel : HotelViewModel = HotelViewModel()
    
    // MARK: - Custom variables
    // NibName of View. This variable will use later in getNibName()
    //var hotelFeatureViewModel : RoomFeatureViewModel = RoomFeatureViewModel()
    var roomFeatureViewModel : RoomFeatureViewModel = RoomFeatureViewModel()
    var parentView : UIViewController?
    var delegate : RoomFeaturesViewDelegate!
    var sectionCount = 0
    var itemCount = 0
    var roomData : Room? = nil
    
    // MARK: - Override Functions
    override func initVariables() {
        roomFeatureViewModel.nibName = "RoomFeaturesView"
        roomFeatureViewModel.cellId = "FeatureCollectionViewCell"
        roomFeatureViewModel.headerCellId = "FeatureHeaderCollectionReusableView"
    }
    
    
    // MARK: - Override Functions
    // joining DetailView.swift and DetailView.xib
    override func getNibName() -> String {
        return roomFeatureViewModel.nibName
    }
    
    
    override func initUIViewAndActions() {
        
        super.initCollectionView(collectionView: collectionView, nibName: roomFeatureViewModel.cellId, nibHeaderName: roomFeatureViewModel.headerCellId)
    }
    
    override func initData() {
        // Load data from PS Server
        
        roomFeatureViewModel.getRoomFeatures(roomId: (roomData?.room_id)!)
        roomFeatureViewModel.roomFeatureListByRoomIdLiveData.bind{ [weak self] in
            
            if let resourse : Resourse<[RoomFeature]> = $0 {
                
                if resourse.status == Status.SUCCESS
                    || resourse.status == Status.LOADING {
                    
                    if let hotelFeatureList : [RoomFeature] = resourse.data {
                        
                        if hotelFeatureList.count > 0 {
                            
                            let lSectionCount = hotelFeatureList.count
                            var lItemCount = 0
                            
                            for i in 0..<hotelFeatureList.count {
                                lItemCount = lItemCount + hotelFeatureList[i].types.count
                            }
                            
                            self?.delegate.resizeRoomFeaturesContainer(CGFloat((lSectionCount*70) + (lItemCount*30) + 200))
                            
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
extension RoomFeaturesView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: roomFeatureViewModel.cellId, for: indexPath) as! FeatureCollectionViewCell
        
        if let data = self.roomFeatureViewModel.roomFeatureListByRoomIdLiveData.value?.data {
            
            cell.featureLabel.text = data[indexPath.section].types[indexPath.row].rinfo_typ_name
            
        }
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if let data = self.roomFeatureViewModel.roomFeatureListByRoomIdLiveData.value?.data {
            return data.count
        }else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = self.roomFeatureViewModel.roomFeatureListByRoomIdLiveData.value?.data {
            
            return data[section].types.count
            
        }else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: roomFeatureViewModel.headerCellId, for: indexPath) as! FeatureHeaderCollectionReusableView
            if let data = self.roomFeatureViewModel.roomFeatureListByRoomIdLiveData.value?.data {
                
                sectionHeaderView.featureHeaderLabel.text = data[indexPath.section].rinfo_grp_name
                
                // hotel ImageView
                let imageURL = configs.imageUrl + data[indexPath.section].default_photo.img_path
                
                sectionHeaderView.featureHeaderImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "PlaceholderImage"))
                
            }
            
            
            return sectionHeaderView
        }else {
            let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: roomFeatureViewModel.headerCellId, for: indexPath) as! FeatureHeaderCollectionReusableView
            
            return sectionHeaderView
        }
    }
    
    
}
extension RoomFeaturesView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSize(width: self.view.bounds.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 30)
    }
   
}

extension RoomFeaturesView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected Index \(indexPath.row)")
        
    }
    
}

