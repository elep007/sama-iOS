//
//  AboutUsDao.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/16/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

class AboutUsDao {
    
    // Singleton
    class var sharedManager: AboutUsDao {
        struct Static {
            static let instance = AboutUsDao()
        }
        return Static.instance
    }
    
    // Core AboutUs
    private let aboutusFile = "aboutusFile.json"
    private var aboutUs  = Resourse<AboutUs>()
    
    // init
    init() {
        
        // Init
        if let aboutUsFromFile : AboutUs = Storage.retrieve(aboutusFile, from: .documents, as: AboutUs.self) {
            aboutUs = Resourse<AboutUs>(status: Status.SUCCESS, message: "", data: aboutUsFromFile)
        }
    }
    
    
    //***************************************************************
    //MARK: Core AboutUs
    //***************************************************************
    
    // Save and Replace
    func save(_ aboutUs : AboutUs) {
        
        self.aboutUs.data = aboutUs
        self.aboutUs.status = Status.SUCCESS
        
        Storage.store(self.aboutUs.data!, to: .documents, as: aboutusFile)
    }
    
    
    // Save and Replace All
    func save(_ aboutUsList : [AboutUs]) {
        
        if let _ = self.aboutUs.data {
            for aboutUs in aboutUsList {
                self.aboutUs.status = Status.SUCCESS
                self.aboutUs.data = aboutUs
                
            }
        }else {
            if aboutUsList.count > 0 {
                self.aboutUs.status = Status.SUCCESS
                self.aboutUs.data = aboutUsList[0]
            }
        }
        
        Storage.store(self.aboutUs.data!, to: .documents, as: aboutusFile)
    }
    
    // get AboutUs
    func getAboutUs()  -> Resourse<AboutUs> {
        return self.aboutUs
    }
    
}
