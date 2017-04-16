//
//  ViewController.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/12/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class MainViewController: UIViewController {
    
    // MARK: - List of Categories
    var listOfCategories: [Category] = []
    
    // MARK: - Views
    private let mainMapView = MainMapView()
    private let topBarView = TopBarView()
    private let bottomBarView = BottomBarView()
    private var categoriesCollectionView: CategoriesCollectionView!
    private let locationManager = CLLocationManager()
    
    // MARK: Properties and Outlets
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup map view
        setupMapView()
        // Setup topBarView
        setupTopBarView()
        // Setup bottomBarView
        setupBottomBarView()
        // Setup categories collection view
        setupCategoryCollectionView()
        // Setup the hardcoded categories
        setupCategories()
        // Setup search text field
        topBarView.setupSearchTextField()
        // Setup for location manager
        setupLocationManager()
    }
    
    // MARK: - Map setup
    fileprivate func setupMapView() {
        self.view.addSubview(mainMapView)
        
        mainMapView.frame = self.view.frame
        // Setting the delegate
        mainMapView.delegate = self
    }
    
    // MARK: - Setup topBarView
    fileprivate func setupTopBarView() {
        self.view.addSubview(topBarView)
    
        let width = self.view.frame.width
        let height = self.view.frame.height
        let frame = CGRect(x: 0,
                           y: 0,
                           width: width,
                           height: height * 0.12)
        topBarView.frame = frame
    
    }
    
    // MARK: - Setup bottomBarView
    fileprivate func setupBottomBarView() {
        self.view.addSubview(bottomBarView)
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        let frame = CGRect(x: 0,
                           y: height * 0.87,
                           width: width,
                           height: height * 0.8)
        bottomBarView.frame = frame
        
    }
    
    // MARK: - Setup Collection View
    fileprivate func setupCategoryCollectionView() {
        // Getting the frame of the bottom bar view
        let frame = CGRect(x: 0,
                           y: 0,
                           width: bottomBarView.frame.width,
                           height: bottomBarView.frame.height)
        // Getting an instance of a layout
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(
            top: 20,
            left: 12,
            bottom: 10,
            right: 10
        )
        
        layout.itemSize = CGSize(
            width: 60,
            height: 60
        )
 
        
        // Instantiating the categories collection view
        categoriesCollectionView = CategoriesCollectionView(
            frame: frame,
            collectionViewLayout: layout
        )
        
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        
        bottomBarView.addSubview(categoriesCollectionView)
    }
    
    
    fileprivate func setupCategories() {
        // Adding built in categories
        self.listOfCategories = ["Food","Fashion", "Fun", "Gadgets", "Services"].map {
            return Category(title: $0)!
        }
        print(listOfCategories.count)
        // Refresh collection view
        categoriesCollectionView.reloadData()
    }
    
    
    fileprivate func setupLocationManager() {
        // MARK: - Authorization
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    // MARK: - Annotations
    
    
    // MARK: - Overlays
    
    
    // MARK: Life Cycle
    
    
}



