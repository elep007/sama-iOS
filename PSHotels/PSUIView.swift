//
//  PSUIView.swift
//  PSHotels
//
//  Created by Panacea-Soft on 10/22/17.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import UIKit

@IBDesignable
class PSUIView : UIView {
    
    
    // MARK: Custom Variables
    var view : UIView!
    var isLogin : Bool = false
    var loginUserId : String = ""
    
    
    
    // MARK: - Override and Require Functions
    /// Init UIView Functions ///
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.initView()
        
    }
    
    
    // MARK: - Custom Functions
    func getNibName() -> String {
        return ""
    }
    
    private func initView() {
        self.refreshUserLogin()
    
        self.initVariables()
    
        let nibName : String = getNibName()
    
        view = loadViewFromNib(nibName: nibName)
        view.frame = bounds
        view.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.RawValue(UInt8(UIView.AutoresizingMask.flexibleWidth.rawValue) | UInt8(UIView.AutoresizingMask.flexibleHeight.rawValue)))
    }
    
    /// This function will help to setup the UIV
    func setup() {
        
        self.addSubview(view)
        
        self.initUIViewAndActions()
        
        self.initData()
        
    }
    
    /// This function will load the view from NIB file name
    ///
    /// - Parameter nibName: Name of NibFile
    /// - Returns: UIView based on nibfile
    private func loadViewFromNib(nibName: String) -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func refreshUserLogin() {
        // Checking user is login or not
        let userInfo = Common.instance.isUserLogin()
        self.isLogin = userInfo.isLogin
        self.loginUserId = userInfo.loginUserId
    }
    
    /// This function need to override in your sub class to init UI.
    func initVariables() {}
    
    /// This function need to override in your sub class to init UI.
    func initUIViewAndActions() {
        Common.instance.setupLoadingBar(self.view)
    }
    
    /// This function need to override in your sub class to load data.
    func initData() {}
    
    /// Init Collection Pinterest View
    func initPinterestCollectionView(collectionView : UICollectionView, nibName : String, numberOfColumns : Int) {
        let uiNibName = UINib(nibName: nibName, bundle:nil)
        
        collectionView.register(uiNibName, forCellWithReuseIdentifier: nibName)
        
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self as? UICollectionViewDelegate
        collectionView.dataSource = self as? UICollectionViewDataSource
        
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = (self as! PinterestLayoutDelegate)
            layout.numberOfColumns = numberOfColumns
            
        }
    }
    
    /// Init Collection Pinterest View
    func initPinterestCollectionView(collectionView : UICollectionView, nibName : String, nibHeaderName : String, numberOfColumns : Int) {
        let uiNibName = UINib(nibName: nibName, bundle:nil)
        let uiNibHeaderName = UINib(nibName: nibHeaderName, bundle:nil)
        
        collectionView.register(uiNibName, forCellWithReuseIdentifier: nibName)
        collectionView.register(uiNibHeaderName, forCellWithReuseIdentifier: nibHeaderName)
        
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self as? UICollectionViewDelegate
        collectionView.dataSource = self as? UICollectionViewDataSource
        
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = (self as! PinterestLayoutDelegate)
            layout.numberOfColumns = numberOfColumns
            
        }
    }
    
    // Init Collection View
    func initCollectionView(collectionView: UICollectionView, nibName: String) {
        
        let uiNibName = UINib(nibName: nibName, bundle:nil)
        
        collectionView.register(uiNibName, forCellWithReuseIdentifier: nibName)
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
            
        }
        
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self as? UICollectionViewDelegate
        collectionView.dataSource = self as? UICollectionViewDataSource
    }
    
    // Init Collection View with Header View
    func initCollectionView(collectionView: UICollectionView, nibName: String, nibHeaderName: String) {
        let uiNibName = UINib(nibName: nibName, bundle:nil)
        let uiNibHeaderName = UINib(nibName: nibHeaderName , bundle:nil)
        
        collectionView.register(uiNibHeaderName, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: nibHeaderName)
        collectionView.register(uiNibName, forCellWithReuseIdentifier: nibName)
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
            
            flowLayout.headerReferenceSize = CGSize(width: collectionView.bounds.width, height: 70)
            
        }
        
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self as? UICollectionViewDelegate
        collectionView.dataSource = self as? UICollectionViewDataSource
        
    }
    
    
    
    
}
