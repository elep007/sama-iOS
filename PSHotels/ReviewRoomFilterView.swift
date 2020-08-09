//
//  RoomFilterView.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/9/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

//MARK: Protocolas
protocol RoomFilterViewProtocol : class {
    func selectRoom(_ room: Room)
}

@IBDesignable
class ReviewRoomFilterView: PSUIView {
    
    var roomViewModel : RoomViewModel = RoomViewModel()
    var selectedCatId : String = ""
    var parent: UIViewController? = nil
    var delegate : RoomFilterViewProtocol? = nil
    var hotelData: Hotel? = nil
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var guestRatingLabel: UILabel!
    
    
    // MARK: - Override Functions
    override func initVariables() {
        roomViewModel.cellId = "RoomFilterCollectionViewCell"
        roomViewModel.nibName = "ReviewRoomFilterView"
    }
    
    override func getNibName() -> String {
        return roomViewModel.nibName
    }
    
    override func initUIViewAndActions() {
        super.initUIViewAndActions()
        
        searchBar.delegate = self
        
        super.initPinterestCollectionView(collectionView: collectionView, nibName: roomViewModel.cellId, numberOfColumns: 1)
        
        
        // Loading Monitoring
        roomViewModel.isLoading.bind{
            if($0) {
                Common.instance.showBarLoading()
                
            }else {
                Common.instance.hideBarLoading()
                
            }
        }
    }
    
    override func initData() {
        
        // Load data from PS Server
        roomViewModel.getRoomListByHotelId(hotelId: (hotelData?.hotel_id)!)
        
        roomViewModel.roomListByHotelIdLiveData.bind{ [weak self] in
            
            if let resourseList : Resourse<[Room]> = $0 {
                
                if resourseList.status == Status.SUCCESS ||
                    resourseList.status == Status.LOADING {
                    
                    self?.collectionView.reloadData()
                    
                }else if resourseList.status == Status.ERROR {
                    
                    print("1 Error in loading data. Message : " + resourseList.message)
                    
                }else {
                    print("Error in loading data. Message : " + resourseList.message)
                }
            }else {
                print("Something Wrong")
            }
            
        }
        
    }
    
    func closeView() {
        parent?.navigationController?.popViewController(animated: true)
        parent?.dismiss(animated: true, completion: nil)
    }
}

extension ReviewRoomFilterView : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let filterStr = searchBar.text {
            if filterStr == "" {
                roomViewModel.isFilter = false
                collectionView.reloadData()
            }else {
                roomViewModel.isFilter = true
                
                roomViewModel.filterCity(filterStr)
                
                collectionView.reloadData()
                
            }
        }else {
            roomViewModel.isFilter = false
            collectionView.reloadData()
        }
        
    }
}



// MARK: - Collection View Datasource extension
extension ReviewRoomFilterView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = roomViewModel.cellId
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! RoomFilterCollectionViewCell
        
        if roomViewModel.isFilter {
            let data = roomViewModel.filterRoomList
            if data.count > indexPath.row {
                cell.roomNameLabel.text = data[indexPath.row].room_name
                
                if let hotelName : String = hotelData?.hotel_name {
                    cell.hotelNameLabel.text = "\(language.roomFilter__hotel) \(hotelName)"
                }else {
                    cell.hotelNameLabel.text = " - "
                }
                
                let imageURL = configs.imageUrl + data[indexPath.row].default_photo.img_path
                
                cell.roomImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "PlaceholderImage"))
                
            }
            
        }else {
            if let data = roomViewModel.roomListByHotelIdLiveData.value?.data {
                if data.count > indexPath.row {
                    cell.roomNameLabel.text = data[indexPath.row].room_name
                    if let hotelName : String = hotelData?.hotel_name {
                        cell.hotelNameLabel.text = "\(language.roomFilter__hotel) \(hotelName)"
                    }else {
                        cell.hotelNameLabel.text = " - "
                    }
                    
                    let imageURL = configs.imageUrl + data[indexPath.row].default_photo.img_path
                    
                    cell.roomImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "PlaceholderImage"))
                }
            }
        }
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if roomViewModel.isFilter {
            let data = roomViewModel.filterRoomList
            print("data count \(data.count)")
            return data.count
            
            
        }else {
            if let data = roomViewModel.roomListByHotelIdLiveData.value?.data {
                print("data count \(data.count)")
                return data.count
            }
        }
        
        return 0
        
    }
}




// MARK: - Collection View Delegate extension
extension ReviewRoomFilterView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ps.print("Selected Index \(indexPath.row)")
        
        if let _ : RoomFilterCollectionViewCell = collectionView.cellForItem(at: indexPath) as? RoomFilterCollectionViewCell {
            
            if roomViewModel.isFilter {
                let data = roomViewModel.filterRoomList
                delegate?.selectRoom(data[indexPath.row])
                
            }else {
                if let data = roomViewModel.roomListByHotelIdLiveData.value?.data {
                    
                    delegate?.selectRoom(data[indexPath.row])
                    
                    
                    
                }
            }
            
            closeView()
            
            
        }
    }
    
}


// MARK: - PinterestLayout Delegate Extension
extension ReviewRoomFilterView : PinterestLayoutDelegate {
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath , withWidth width:CGFloat) -> CGFloat {
        
        return 70
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        
        return 0
    }
    
}
