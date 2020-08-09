//
//  SearchLocationView.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/23/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

//MARK: Protocolas
protocol SearchLocationProtocol : class {
    func selectLocation(_ city: City)
}

@IBDesignable
class SearchLocationView: PSUIView {
    
    var cityViewModel : CityViewModel = CityViewModel()
    var selectedCatId : String = ""
    var parent: UIViewController? = nil
    var delegate : SearchLocationProtocol? = nil
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var guestRatingLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Override Functions
    
    override func initVariables() {
        cityViewModel.nibName = "SearchLocationView"
        cityViewModel.cellId = "CityFilterCollectionViewCell"
    }
    
    override func getNibName() -> String {
        return cityViewModel.nibName
    }
    
     override func initUIViewAndActions() {
        super.initUIViewAndActions()
        
        searchBar.delegate = self
        
        super.initPinterestCollectionView(collectionView: collectionView, nibName: cityViewModel.cellId, numberOfColumns: 1)
        
        // Loading Monitoring
        cityViewModel.isLoading.bind{
            if($0) {
                Common.instance.showBarLoading()
                
            }else {
                Common.instance.hideBarLoading()
                
            }
        }
    }
    
    override func initData() {
        
        // Load data from PS Server
        cityViewModel.getCities()
        
        cityViewModel.citiesLiveData.bind{ [weak self] in
            
            if let resourseList : Resourse<[City]> = $0 {
                
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

extension SearchLocationView : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let filterStr = searchBar.text {
            if filterStr == "" {
                cityViewModel.isFilter = false
                collectionView.reloadData()
            }else {
                cityViewModel.isFilter = true
                
                cityViewModel.filterCity(filterStr)
                
                collectionView.reloadData()
                
            }
        }else {
            cityViewModel.isFilter = false
            collectionView.reloadData()
        }
        
    }
}



// MARK: - Collection View Datasource extension
extension SearchLocationView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = cityViewModel.cellId
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CityFilterCollectionViewCell
        
        if cityViewModel.isFilter {
            let data = cityViewModel.filterCities
            if data.count > indexPath.row {
                cell.titleLabel.text = data[indexPath.row].city_name
                cell.countryLabel.text = language.dest__country + data[indexPath.row].country.country_name
            }
            
        }else {
            if let data = cityViewModel.citiesLiveData.value?.data {
                if data.count > indexPath.row {
                    cell.titleLabel.text = data[indexPath.row].city_name
                    cell.countryLabel.text = language.dest__country + data[indexPath.row].country.country_name
                }
            }
        }
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if cityViewModel.isFilter {
            let data = cityViewModel.filterCities
            print("data count \(data.count)")
            return data.count
            
            
        }else {
            if let data = cityViewModel.citiesLiveData.value?.data {
                print("data count \(data.count)")
                return data.count
            }
        }
        
        return 0
        
    }
}




// MARK: - Collection View Delegate extension
extension SearchLocationView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ps.print("Selected Index \(indexPath.row)")
        
        if let _ : CityFilterCollectionViewCell = collectionView.cellForItem(at: indexPath) as? CityFilterCollectionViewCell {
            
            if cityViewModel.isFilter {
                let data = cityViewModel.filterCities
                delegate?.selectLocation(data[indexPath.row])
                
            }else {
                if let data = cityViewModel.citiesLiveData.value?.data {
                    
                    delegate?.selectLocation(data[indexPath.row])
                    
                    
                    
                }
            }
            
            closeView()
            
            
        }
    }
    
}


// MARK: - PinterestLayout Delegate Extension
extension SearchLocationView : PinterestLayoutDelegate {
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath , withWidth width:CGFloat) -> CGFloat {
        
        return 70
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        
        return 0
    }
    
}
