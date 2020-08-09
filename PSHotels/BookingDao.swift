//
//  BookingDao.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 5/3/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class BookingDao {
    
    // Singleton
    class var sharedManager: BookingDao {
        struct Static {
            static let instance = BookingDao()
        }
        return Static.instance
    }
    
    // Core Booking
    private let bookingFile = "bookingFile.json"
    private var bookingList  = Resourse<[Booking]>()
    
    // init
    init() {
        
        // Init
        if let bookingListFromFile : [Booking] = Storage.retrieve(bookingFile, from: .documents, as: [Booking].self) {
            bookingList = Resourse<[Booking]>(status: Status.SUCCESS, message: "", data: bookingListFromFile)
        }
    }
    
    
    //***************************************************************
    //MARK: Core Booking
    //***************************************************************
    
    // Save and Replace
    func save(_ Booking : Booking) {
        
        if let data = self.bookingList.data {
            let index = data.firstIndex{$0 == Booking}
            
            if let i = index {
                self.bookingList.data?[i] = Booking
            }else {
                self.bookingList.data?.append(Booking)
            }
            
        }else {
            self.bookingList.status = Status.SUCCESS
            self.bookingList.data = [Booking]
        }
        
        Storage.store(bookingList.data!, to: .documents, as: bookingFile)
    }
    
    // Save and Replace All
    func save(_ bookingList : [Booking]) {
        if let _ = self.bookingList.data {
            for Booking in bookingList {
                
                if let data = self.bookingList.data {
                    let index = data.firstIndex{$0 == Booking}
                    
                    if let i = index {
                        self.bookingList.data?[i] = Booking
                    }else {
                        self.bookingList.data?.append(Booking)
                    }
                    self.bookingList.status = Status.SUCCESS
                }else {
                    self.bookingList.status = Status.SUCCESS
                    self.bookingList.data?.append(Booking)
                }
            }
        }else {
            self.bookingList.status = Status.SUCCESS
            self.bookingList.data = bookingList
        }
        
        
        Storage.store(self.bookingList.data!, to: .documents, as: bookingFile)
    }
    
    
    func getbookingList() -> Resourse<[Booking]> {
        return bookingList
    }
    
    func deletebookingList() {
        bookingList.data = [Booking]()
        Storage.store(self.bookingList.data!, to: .documents, as: bookingFile)
    }
    
}

