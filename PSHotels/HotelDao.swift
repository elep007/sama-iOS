//
//  HotelDao.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/28/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation


class HotelDao {
    
    // Singleton
    class var sharedManager: HotelDao {
        struct Static {
            static let instance = HotelDao()
        }
        return Static.instance
    }
    
    // Core Hotel
    private let hotelFile = "hotelFile.json"
    private var hotelList  = Resourse<[Hotel]>()
    
    // Search
    private let searchHotelFile = "searchHotel.json"
    private var searchHotelList  = Resourse<[SearchHotel]>()
    
    // Featured
    private let featuredHotelFile = "featuredHotel.json"
    private var featuredHotelList  = Resourse<[FeaturedHotel]>()
    
    // Popular
    private let popularHotelFile = "popularHotel.json"
    private var popularHotelList  = Resourse<[PopularHotel]>()
    
    // Promotion
    private let promotionHotelFile = "promotionHotel.json"
    private var promotionHotelList  = Resourse<[PromotionHotel]>()
    
    // Favourite
    private let favouriteHotelFile = "favouriteHotel.json"
    private var favouriteHotelList  = Resourse<[FavouriteHotel]>()
    
    // init
    init() {
        
        // Init Core
        if let hotelListFromFile : [Hotel] = Storage.retrieve(hotelFile, from: .documents, as: [Hotel].self) {
            hotelList = Resourse<[Hotel]>(status: Status.SUCCESS, message: "", data: hotelListFromFile)
        }
        
        // Init Search Hotel
        if let searchListFromFile : [SearchHotel] = Storage.retrieve(searchHotelFile, from: .documents, as: [SearchHotel].self) {
            searchHotelList = Resourse<[SearchHotel]>(status: Status.SUCCESS, message: "", data: searchListFromFile)
        }
        
        // Init Featured Hotel
        if let featuredListFromFile : [FeaturedHotel] = Storage.retrieve(featuredHotelFile, from: .documents, as: [FeaturedHotel].self) {
            featuredHotelList = Resourse<[FeaturedHotel]>(status: Status.SUCCESS, message: "", data: featuredListFromFile)
        }
        
        // Init Popular Hotel
        if let popularListFromFile : [PopularHotel] = Storage.retrieve(popularHotelFile, from: .documents, as: [PopularHotel].self) {
            popularHotelList = Resourse<[PopularHotel]>(status: Status.SUCCESS, message: "", data: popularListFromFile)
        }
        
        // Init Promotion Hotel
        if let promotionListFromFile : [PromotionHotel] = Storage.retrieve(promotionHotelFile, from: .documents, as: [PromotionHotel].self) {
            promotionHotelList = Resourse<[PromotionHotel]>(status: Status.SUCCESS, message: "", data: promotionListFromFile)
        }
        
        // Init Favourite Hotel
        if let favouriteListFromFile : [FavouriteHotel] = Storage.retrieve(favouriteHotelFile, from: .documents, as: [FavouriteHotel].self) {
            favouriteHotelList = Resourse<[FavouriteHotel]>(status: Status.SUCCESS, message: "", data: favouriteListFromFile)
        }
        
        
    }
    
    //***************************************************************
    //MARK: Core Hotel
    //***************************************************************
    
    // Save and Replace
    func save(_ hotel : Hotel) {
        
        if let data = self.hotelList.data {
            let index = data.firstIndex{$0 == hotel}
            
            if let i = index {
                self.hotelList.data?[i] = hotel
            }else {
                self.hotelList.status = Status.SUCCESS
                self.hotelList.data?.append(hotel)
            }
            
        }else {
            self.hotelList.status = Status.SUCCESS
            self.hotelList.data = [hotel]
        }
        
        Storage.store(hotelList.data!, to: .documents, as: hotelFile)
    }
    
    // Save and Replace All
    func save(_ hotelList : [Hotel]) {
        for hotel in hotelList {
            save(hotel)
        }
    }
    
    // get hotel by hotelid
    func getHotelById(_ hotelId: String)  -> Resourse<Hotel> {
        
        let hotelHolder : Resourse<Hotel> = Resourse<Hotel>()
        
        if let data = hotelList.data {
            let hotelFilter = data.filter{$0.hotel_id == hotelId}
            if hotelFilter.count > 0 {
                hotelHolder.data = hotelFilter[0]
                hotelHolder.status = Status.SUCCESS
            }
            
        }
        
        return hotelHolder
    }
    
    //***************************************************************
    // End Core Hotel
    //***************************************************************
    
    //***************************************************************
    //MARK: Search Hotel
    //***************************************************************
    
    
    // Save and Replace
    func save(_ searchHotel : SearchHotel) {
        
        if let data = self.searchHotelList.data {
            let index = data.firstIndex{$0 == searchHotel}
            
            if let i = index {
                self.searchHotelList.data?[i] = searchHotel
            }else {
                self.searchHotelList.data?.append(searchHotel)
            }
            
        }else {
            
            self.searchHotelList.status = Status.SUCCESS
            self.searchHotelList.data = [searchHotel]
            
        }
        
        Storage.store(searchHotelList.data!, to: .documents, as: searchHotelFile)
        
    }
    
    // Save and Replace All
    func save(_ searchHotelList : [SearchHotel]) {
        
        if let _ = self.searchHotelList.data {
            for searchHotel in searchHotelList {
                
                if let data = self.searchHotelList.data {
                    let index = data.firstIndex{$0 == searchHotel}
                    
                    if let i = index {
                        self.searchHotelList.data?[i] = searchHotel
                    }else {
                        self.searchHotelList.data?.append(searchHotel)
                    }
                    
                }else {
                    self.searchHotelList.data?.append(searchHotel)
                }
            }
        }else {
            self.searchHotelList.status = Status.SUCCESS
            self.searchHotelList.data = searchHotelList
        }
        
        
        Storage.store(self.searchHotelList.data!, to: .documents, as: searchHotelFile)
    }
    
    func deleteSearchHotel() {
        searchHotelList.data = [SearchHotel]()
        Storage.store(searchHotelList.data!, to: .documents, as: searchHotelFile)
        
        if let hotelData = hotelList.data {
            var filterList = hotelData
            
            // filter with featured list
            if let featured = featuredHotelList.data {
                let hotelIdMap = featured.map{ $0.hotel_id }
                
                for hotelId in hotelIdMap {
                    filterList = filterList.filter{ $0.hotel_id != hotelId}
                }
            }
            
            // filter with popular list
            if let popular = popularHotelList.data {
                let hotelIdMap = popular.map{ $0.hotel_id }
                
                for hotelId in hotelIdMap {
                    filterList = filterList.filter{ $0.hotel_id != hotelId}
                }
            }
            
            // filter with promotion list
            if let promotion = promotionHotelList.data {
                let hotelIdMap = promotion.map{ $0.hotel_id }
                
                for hotelId in hotelIdMap {
                    filterList = filterList.filter{ $0.hotel_id != hotelId}
                }
            }
            
            // filter with favourite list
            if let favourite = favouriteHotelList.data {
                let hotelIdMap = favourite.map{ $0.hotel_id }
                
                for hotelId in hotelIdMap {
                    filterList = filterList.filter{ $0.hotel_id != hotelId}
                }
            }
            
            // search hotel list to delete
            hotelList.data = filterList
            Storage.store(hotelList.data, to: .documents, as: hotelFile)
            
        }
    }
    
    
    func convertToSearchHotel(_ searchHotelList : [Hotel]) -> [SearchHotel] {
        
        var rtnSearchHotelList : [SearchHotel] = [SearchHotel]()
        for searchHotel in searchHotelList {
            let searchHotel : SearchHotel = SearchHotel(searchHotel.hotel_id)
            rtnSearchHotelList.append(searchHotel)
        }
        
        return rtnSearchHotelList
    }
    
    func getSearchHotel() -> Resourse<[Hotel]>{
        
        if let recent = searchHotelList.data {
            
            // Get All Search Hotel Id
            let flatData = recent.map{$0.hotel_id}
            
            let localSearchHotelList = Resourse<[Hotel]>()
            
            if let data : [Hotel] = hotelList.data {
                
                for hotelId in flatData {
                    let searchHotelList = data.filter{$0.hotel_id ==  hotelId}
                    
                    if(searchHotelList.count > 0) {
                        for searchHotel in searchHotelList {
                            
                            if localSearchHotelList.data == nil {
                                localSearchHotelList.status = Status.SUCCESS
                                localSearchHotelList.data = [searchHotel]
                            }else {
                                localSearchHotelList.data?.append(searchHotel)
                            }
                        }
                    }
                }
                
            }
            return localSearchHotelList
            
        }
        
        
        return Resourse<[Hotel]>()
    }
    
    
    //***************************************************************
    // End Search Hotel
    //***************************************************************
    
    
    //***************************************************************
    //MARK: Featured Hotel
    //***************************************************************
    
    // Save and Replace
    func save(_ featuredHotel : FeaturedHotel) {
        
        if let data = self.featuredHotelList.data {
            let index = data.firstIndex{$0 == featuredHotel}
            
            if let i = index {
                self.featuredHotelList.data?[i] = featuredHotel
            }else {
                self.featuredHotelList.data?.append(featuredHotel)
            }
            
        }else {
            
            self.featuredHotelList.status = Status.SUCCESS
            self.featuredHotelList.data = [featuredHotel]
            
        }
        
        Storage.store(featuredHotelList.data!, to: .documents, as: featuredHotelFile)
        
    }
    
    // Save and Replace All
    func save(_ featuredHotelList : [FeaturedHotel]) {
        
        if let _ = self.featuredHotelList.data {
            for searchHotel in featuredHotelList {
                
                if let data = self.featuredHotelList.data {
                    let index = data.firstIndex{$0 == searchHotel}
                    
                    if let i = index {
                        self.featuredHotelList.data?[i] = searchHotel
                    }else {
                        self.featuredHotelList.data?.append(searchHotel)
                    }
                    
                }else {
                    self.featuredHotelList.data?.append(searchHotel)
                }
            }
        }else {
            self.featuredHotelList.status = Status.SUCCESS
            self.featuredHotelList.data = featuredHotelList
        }
        
        
        Storage.store(self.featuredHotelList.data!, to: .documents, as: featuredHotelFile)
    }
    
    func deleteFeaturedHotel() {
        featuredHotelList.data = [FeaturedHotel]()
        Storage.store(featuredHotelList.data!, to: .documents, as: featuredHotelFile)
        
        if let hotelData = hotelList.data {
            var filterList = hotelData
            
            // filter with search list
            if let search = searchHotelList.data {
                let hotelIdMap = search.map{ $0.hotel_id }
                
                for hotelId in hotelIdMap {
                    filterList = filterList.filter{ $0.hotel_id != hotelId}
                }
            }
            
            // filter with popular list
            if let popular = popularHotelList.data {
                let hotelIdMap = popular.map{ $0.hotel_id }
                
                for hotelId in hotelIdMap {
                    filterList = filterList.filter{ $0.hotel_id != hotelId}
                }
            }
            
            // filter with promotion list
            if let promotion = promotionHotelList.data {
                let hotelIdMap = promotion.map{ $0.hotel_id }
                
                for hotelId in hotelIdMap {
                    filterList = filterList.filter{ $0.hotel_id != hotelId}
                }
            }
            
            // filter with favourite list
            if let favourite = favouriteHotelList.data {
                let hotelIdMap = favourite.map{ $0.hotel_id }
                
                for hotelId in hotelIdMap {
                    filterList = filterList.filter{ $0.hotel_id != hotelId}
                }
            }
            
            // search hotel list to delete
            hotelList.data = filterList
            Storage.store(hotelList.data, to: .documents, as: hotelFile)
            
        }
    }
    
    
    func convertToFeaturedHotel(_ featuredHotelList : [Hotel]) -> [FeaturedHotel] {
        
        var rtnFeaturedHotelList : [FeaturedHotel] = [FeaturedHotel]()
        for featuredHotel in featuredHotelList {
            let featuredHotel : FeaturedHotel = FeaturedHotel(featuredHotel.hotel_id)
            rtnFeaturedHotelList.append(featuredHotel)
        }
        
        return rtnFeaturedHotelList
    }
    
    func getFeaturedHotel() -> Resourse<[Hotel]>{
        
        if let recent = featuredHotelList.data {
            
            // Get All Search Hotel Id
            let flatData = recent.map{$0.hotel_id}
            
            let localFeaturedHotelList = Resourse<[Hotel]>()
            
            if let data : [Hotel] = hotelList.data {
                
                for hotelId in flatData {
                    let featuredHotelList = data.filter{$0.hotel_id ==  hotelId}
                    
                    if(featuredHotelList.count > 0) {
                        for searchHotel in featuredHotelList {
                            
                            if localFeaturedHotelList.data == nil {
                                localFeaturedHotelList.status = Status.SUCCESS
                                localFeaturedHotelList.data = [searchHotel]
                            }else {
                                localFeaturedHotelList.data?.append(searchHotel)
                            }
                        }
                    }
                }
                
            }
            return localFeaturedHotelList
            
        }
        
        
        return Resourse<[Hotel]>()
    }
    
    
    //***************************************************************
    // End Featured Hotel
    //***************************************************************
    
    
    
    //***************************************************************
    //MARK: Popular Hotel
    //***************************************************************
    
    
    // Save and Replace
    func save(_ popularHotel : PopularHotel) {
        
        if let data = self.popularHotelList.data {
            let index = data.firstIndex{$0 == popularHotel}
            
            if let i = index {
                self.popularHotelList.data?[i] = popularHotel
            }else {
                self.popularHotelList.data?.append(popularHotel)
            }
            
        }else {
            
            self.popularHotelList.status = Status.SUCCESS
            self.popularHotelList.data = [popularHotel]
            
        }
        
        Storage.store(popularHotelList.data!, to: .documents, as: popularHotelFile)
        
    }
    
    // Save and Replace All
    func save(_ popularHotelList : [PopularHotel]) {
        
        if let _ = self.popularHotelList.data {
            for searchHotel in popularHotelList {
                
                if let data = self.popularHotelList.data {
                    let index = data.firstIndex{$0 == searchHotel}
                    
                    if let i = index {
                        self.popularHotelList.data?[i] = searchHotel
                    }else {
                        self.popularHotelList.data?.append(searchHotel)
                    }
                    
                }else {
                    self.popularHotelList.data?.append(searchHotel)
                }
            }
        }else {
            self.popularHotelList.status = Status.SUCCESS
            self.popularHotelList.data = popularHotelList
        }
        
        
        Storage.store(self.popularHotelList.data!, to: .documents, as: popularHotelFile)
    }
    
    func deletePopularHotel() {
        popularHotelList.data = [PopularHotel]()
        Storage.store(popularHotelList.data!, to: .documents, as: popularHotelFile)
        
        if let hotelData = hotelList.data {
            var filterList = hotelData
            
            // filter with search list
            if let search = searchHotelList.data {
                let hotelIdMap = search.map{ $0.hotel_id }
                
                for hotelId in hotelIdMap {
                    filterList = filterList.filter{ $0.hotel_id != hotelId}
                }
            }
            
            // filter with featured list
            if let featured = featuredHotelList.data {
                let hotelIdMap = featured.map{ $0.hotel_id }
                
                for hotelId in hotelIdMap {
                    filterList = filterList.filter{ $0.hotel_id != hotelId}
                }
            }
            
            // filter with promotion list
            if let promotion = promotionHotelList.data {
                let hotelIdMap = promotion.map{ $0.hotel_id }
                
                for hotelId in hotelIdMap {
                    filterList = filterList.filter{ $0.hotel_id != hotelId}
                }
            }
            
            // filter with favourite list
            if let favourite = favouriteHotelList.data {
                let hotelIdMap = favourite.map{ $0.hotel_id }
                
                for hotelId in hotelIdMap {
                    filterList = filterList.filter{ $0.hotel_id != hotelId}
                }
            }
            
            // search hotel list to delete
            hotelList.data = filterList
            Storage.store(hotelList.data, to: .documents, as: hotelFile)
            
        }
    }
    
    
    func convertToPopularHotel(_ popularHotelList : [Hotel]) -> [PopularHotel] {
        
        var rtnPopularHotelList : [PopularHotel] = [PopularHotel]()
        for popularHotel in popularHotelList {
            let popularHotel : PopularHotel = PopularHotel(popularHotel.hotel_id)
            rtnPopularHotelList.append(popularHotel)
        }
        
        return rtnPopularHotelList
    }
    
    func getPopularHotel() -> Resourse<[Hotel]>{
        
        if let recent = popularHotelList.data {
            
            // Get All Search Hotel Id
            let flatData = recent.map{$0.hotel_id}
            
            let localPopularHotelList = Resourse<[Hotel]>()
            
            if let data : [Hotel] = hotelList.data {
                
                for hotelId in flatData {
                    let popularHotelList = data.filter{$0.hotel_id ==  hotelId}
                    
                    if(popularHotelList.count > 0) {
                        for searchHotel in popularHotelList {
                            
                            if localPopularHotelList.data == nil {
                                localPopularHotelList.status = Status.SUCCESS
                                localPopularHotelList.data = [searchHotel]
                            }else {
                                localPopularHotelList.data?.append(searchHotel)
                            }
                        }
                    }
                }
                
            }
            return localPopularHotelList
            
        }
        
        
        return Resourse<[Hotel]>()
    }
    
    
    //***************************************************************
    // End Popular Hotel
    //***************************************************************
    
    
    
    //***************************************************************
    //MARK: Promotion Hotel
    //***************************************************************
    
    // Save and Replace
    func save(_ promotionHotel : PromotionHotel) {
        
        if let data = self.promotionHotelList.data {
            let index = data.firstIndex{$0 == promotionHotel}
            
            if let i = index {
                self.promotionHotelList.data?[i] = promotionHotel
            }else {
                self.promotionHotelList.data?.append(promotionHotel)
            }
            
        }else {
            
            self.promotionHotelList.status = Status.SUCCESS
            self.promotionHotelList.data = [promotionHotel]
            
        }
        
        Storage.store(promotionHotelList.data!, to: .documents, as: promotionHotelFile)
        
    }
    
    // Save and Replace All
    func save(_ promotionHotelList : [PromotionHotel]) {
        
        if let _ = self.promotionHotelList.data {
            for searchHotel in promotionHotelList {
                
                if let data = self.promotionHotelList.data {
                    let index = data.firstIndex{$0 == searchHotel}
                    
                    if let i = index {
                        self.promotionHotelList.data?[i] = searchHotel
                    }else {
                        self.promotionHotelList.data?.append(searchHotel)
                    }
                    
                }else {
                    self.promotionHotelList.data?.append(searchHotel)
                }
            }
        }else {
            self.promotionHotelList.status = Status.SUCCESS
            self.promotionHotelList.data = promotionHotelList
        }
        
        
        Storage.store(self.promotionHotelList.data!, to: .documents, as: promotionHotelFile)
    }
    
    func deletePromotionHotel() {
        promotionHotelList.data = [PromotionHotel]()
        Storage.store(promotionHotelList.data!, to: .documents, as: promotionHotelFile)
        
        if let hotelData = hotelList.data {
            var filterList = hotelData
            
            // filter with search list
            if let search = searchHotelList.data {
                let hotelIdMap = search.map{ $0.hotel_id }
                
                for hotelId in hotelIdMap {
                    filterList = filterList.filter{ $0.hotel_id != hotelId}
                }
            }
            
            // filter with featured list
            if let featured = featuredHotelList.data {
                let hotelIdMap = featured.map{ $0.hotel_id }
                
                for hotelId in hotelIdMap {
                    filterList = filterList.filter{ $0.hotel_id != hotelId}
                }
            }
            
            // filter with popular list
            if let popular = popularHotelList.data {
                let hotelIdMap = popular.map{ $0.hotel_id }
                
                for hotelId in hotelIdMap {
                    filterList = filterList.filter{ $0.hotel_id != hotelId}
                }
            }
            
            // filter with favourite list
            if let favourite = favouriteHotelList.data {
                let hotelIdMap = favourite.map{ $0.hotel_id }
                
                for hotelId in hotelIdMap {
                    filterList = filterList.filter{ $0.hotel_id != hotelId}
                }
            }
            
            // search hotel list to delete
            hotelList.data = filterList
            Storage.store(hotelList.data, to: .documents, as: hotelFile)
            
        }
    }
    
    
    func convertToPromotionHotel(_ promotionHotelList : [Hotel]) -> [PromotionHotel] {
        
        var rtnPromotionHotelList : [PromotionHotel] = [PromotionHotel]()
        for promotionHotel in promotionHotelList {
            let promotionHotel : PromotionHotel = PromotionHotel(promotionHotel.hotel_id)
            rtnPromotionHotelList.append(promotionHotel)
        }
        
        return rtnPromotionHotelList
    }
    
    func getPromotionHotel() -> Resourse<[Hotel]>{
        
        if let recent = promotionHotelList.data {
            
            // Get All Search Hotel Id
            let flatData = recent.map{$0.hotel_id}
            
            let localPromotionHotelList = Resourse<[Hotel]>()
            
            if let data : [Hotel] = hotelList.data {
                
                for hotelId in flatData {
                    let promotionHotelList = data.filter{$0.hotel_id ==  hotelId}
                    
                    if(promotionHotelList.count > 0) {
                        for searchHotel in promotionHotelList {
                            
                            if localPromotionHotelList.data == nil {
                                localPromotionHotelList.status = Status.SUCCESS
                                localPromotionHotelList.data = [searchHotel]
                            }else {
                                localPromotionHotelList.data?.append(searchHotel)
                            }
                        }
                    }
                }
                
            }
            return localPromotionHotelList
            
        }
        
        
        return Resourse<[Hotel]>()
    }
    
    
    //***************************************************************
    // End Promotion Hotel
    //***************************************************************
    
    
    
    //***************************************************************
    //MARK: Favourite Hotel
    //***************************************************************
    
    
    // Save and Replace
    func save(_ favouriteHotel : FavouriteHotel) {
        
        if let data = self.favouriteHotelList.data {
            let index = data.firstIndex{$0 == favouriteHotel}
            
            if let i = index {
                self.favouriteHotelList.data?[i] = favouriteHotel
            }else {
                self.favouriteHotelList.data?.append(favouriteHotel)
            }
            
        }else {
            
            self.favouriteHotelList.status = Status.SUCCESS
            self.favouriteHotelList.data = [favouriteHotel]
            
        }
        
        Storage.store(favouriteHotelList.data!, to: .documents, as: favouriteHotelFile)
        
    }
    
    // Save and Replace All
    func save(_ favouriteHotelList : [FavouriteHotel]) {
        
        if let _ = self.favouriteHotelList.data {
            for favouriteHotel in favouriteHotelList {
                
                if let data = self.favouriteHotelList.data {
                    let index = data.firstIndex{$0 == favouriteHotel}
                    
                    if let i = index {
                        self.favouriteHotelList.data?[i] = favouriteHotel
                    }else {
                        self.favouriteHotelList.data?.append(favouriteHotel)
                    }
                    
                }else {
                    self.favouriteHotelList.data?.append(favouriteHotel)
                }
            }
        }else {
            self.favouriteHotelList.status = Status.SUCCESS
            self.favouriteHotelList.data = favouriteHotelList
        }
        
        
        Storage.store(self.favouriteHotelList.data!, to: .documents, as: favouriteHotelFile)
    }
    
    func deleteFavouriteHotelById(_ hotel_id: String) {
        if let data = favouriteHotelList.data {
            let updatedData = data.filter{$0.hotel_id != hotel_id}
            Storage.store(updatedData, to: .documents, as: favouriteHotelFile)
            favouriteHotelList.data = updatedData
        }
    }
    
    func deleteFavouriteHotel() {
        favouriteHotelList.data = [FavouriteHotel]()
        Storage.store(favouriteHotelList.data!, to: .documents, as: favouriteHotelFile)
        
        if let hotelData = hotelList.data {
            var filterList = hotelData
            
            // filter with search list
            if let search = searchHotelList.data {
                let hotelIdMap = search.map{ $0.hotel_id }
                
                for hotelId in hotelIdMap {
                    filterList = filterList.filter{ $0.hotel_id != hotelId}
                }
            }
            
            // filter with featured list
            if let featured = featuredHotelList.data {
                let hotelIdMap = featured.map{ $0.hotel_id }
                
                for hotelId in hotelIdMap {
                    filterList = filterList.filter{ $0.hotel_id != hotelId}
                }
            }
            
            // filter with popular list
            if let popular = popularHotelList.data {
                let hotelIdMap = popular.map{ $0.hotel_id }
                
                for hotelId in hotelIdMap {
                    filterList = filterList.filter{ $0.hotel_id != hotelId}
                }
            }
            
            // filter with promotion list
            if let promotion = promotionHotelList.data {
                let hotelIdMap = promotion.map{ $0.hotel_id }
                
                for hotelId in hotelIdMap {
                    filterList = filterList.filter{ $0.hotel_id != hotelId}
                }
            }
            
            // search hotel list to delete
            hotelList.data = filterList
            Storage.store(hotelList.data, to: .documents, as: hotelFile)
            
        }
    }
    
    
    func convertToFavouriteHotel(_ favouriteHotelList : [Hotel]) -> [FavouriteHotel] {
        
        var rtnFavouriteHotelList : [FavouriteHotel] = [FavouriteHotel]()
        for favouriteHotel in favouriteHotelList {
            let favouriteHotel : FavouriteHotel = FavouriteHotel(favouriteHotel.hotel_id)
            rtnFavouriteHotelList.append(favouriteHotel)
        }
        
        return rtnFavouriteHotelList
    }
    
    func getFavouriteHotel() -> Resourse<[Hotel]>{
        
        if let recent = favouriteHotelList.data {
            
            // Get All Search Hotel Id
            let flatData = recent.map{$0.hotel_id}
            
            let localFavouriteHotelList = Resourse<[Hotel]>()
            
            if let data : [Hotel] = hotelList.data {
                
                for hotelId in flatData {
                    let favouriteHotelList = data.filter{$0.hotel_id ==  hotelId}
                    
                    if(favouriteHotelList.count > 0) {
                        for favouriteHotel in favouriteHotelList {
                            
                            if localFavouriteHotelList.data == nil {
                                localFavouriteHotelList.status = Status.SUCCESS
                                localFavouriteHotelList.data = [favouriteHotel]
                            }else {
                                localFavouriteHotelList.data?.append(favouriteHotel)
                            }
                        }
                    }
                }
                
            }
            return localFavouriteHotelList
            
        }
        
        
        return Resourse<[Hotel]>()
    }
    
    
    //***************************************************************
    // End Favourite Hotel
    //***************************************************************
    
    
    
}
