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

class MainViewController: UIViewController, SearchTextFieldDelegate, SearchViewDelegate {
    
    // MARK: - Lists
    var listOfCategories: [Category] = []
    // List of Products
    var listOfProducts: [Product] = []
    var listOfFilteredProducts = Set<Product>()
    
    // MARK: - Views
    let mainMapView = MainMapView()
    let searchView = SearchView()
    let bottomBarView = BottomBarView()
    var searchTextField = SearchTextField()
    var categoriesCollectionView: CategoriesCollectionView!
    var searchCollectionView: SearchCollectionView!
    let locationManager = CLLocationManager()
    
    
    // MARK: - Logic
    var calloutViewIsVisible = false
    
    
    // MARK: Properties and Outlets
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup map view
        setupMapView()
        // Setup searchView
        setupSearchView()
        // Setup bottomBarView
        setupBottomBarView()
        // Setup categories collection view
        setupCategoryCollectionView()
        // Setup the hardcoded categories
        setupCategories()
        // Setup search text field
        setupSearchTextField()
        // Setup for location manager
        setupLocationManager()
        // Setup search collectoion view
        setupSearchCollectionView()
        
        // Testing with artificial data
        APIClient.sharedInstance.getProductsByCity(city: "Test") { (products) in
            
            self.mainMapView.addAnnotations(products)
            
        }
    }
    
    // MARK: - Map setup
    fileprivate func setupMapView() {
        self.view.addSubview(mainMapView)
        
        mainMapView.frame = self.view.frame
        // Setting the delegate
        mainMapView.delegate = self
        // User location
        mainMapView.showsUserLocation = true
        // Allow user tracking
        mainMapView.userTrackingMode = MKUserTrackingMode.follow
        
    }
    
    // MARK: - Setup searchView
    fileprivate func setupSearchView() {
        self.view.addSubview(searchView)
        
        let width = self.view.frame.width
        let frame = CGRect(x: self.view.frame.origin.x,
                           y: self.view.frame.origin.y,
                           width: width,
                           height: 0)
        searchView.frame = frame
        
        searchView.searchViewDelegate = self
    }
    
    // MARK: - Setup bottomBarView
    fileprivate func setupBottomBarView() {
        self.view.addSubview(bottomBarView)
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        let frame = CGRect(x: 0,
                           y: height * 0.84,
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
        // Creating an instance of a layout
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(
            top: 20,
            left: 12,
            bottom: 10,
            right: 10
        )
        
        // Makes the height and width equal
        layout.itemSize = CGSize(
            width: self.view.frame.width / 4.9,
            height: self.view.frame.width / 4.9
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
    
    
    fileprivate func setupSearchTextField() {
        self.view.addSubview(searchTextField)
        // Using this update products
        searchTextField.searchTextFieldDelegate = self
        
        // SearchTextField setup
        let textFieldFrame = CGRect(
            x: self.view.frame.width * 0.05,
            y: self.view.frame.height * 0.05,
            width: self.view.frame.width * 0.9,
            height: self.view.frame.height * 0.07
        )
        
        searchTextField.frame = textFieldFrame
    }
    
    
    fileprivate func setupSearchCollectionView() {

        // Getting the frame of the bottom bar view
        let frame = CGRect(
            x: 0,
            y: self.view.frame.height * 0.12,
            width: self.view.frame.width,
            height: 0
        )
        // Creating an instance of a layout
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(
            top: 20,
            left: 12,
            bottom: 10,
            right: 10
        )
        
        // Makes the height and width equal
        layout.itemSize = CGSize(
            width: self.view.frame.width * 0.8,
            height: self.view.frame.width * 0.2
        )
        
        // Instantiating the categories collection view
        searchCollectionView = SearchCollectionView(
            frame: frame,
            collectionViewLayout: layout
        )
        
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.alwaysBounceVertical = true
        
        searchView.addSubview(searchCollectionView)
    }
    
    
    fileprivate func setupCategories() {
        // Adding built in categories
        self.listOfCategories = ["Food","Fashion", "Fun", "Gadgets"].map {
            return Category(title: $0)!
        }
        // Refresh collection view
        categoriesCollectionView.reloadData()
    }
    
    
    fileprivate func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    
    // MARK: - Annotations
    
    
    // MARK: - Overlays
    
    
    // MARK: Life Cycle
    
    
}



