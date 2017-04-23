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
        mainMapView.setupMapView(self)
        // Setup searchView
        searchView.setupSearchView(self)
        // Setup search text field
        setupSearchTextField()
        // Setup for location manager
        setupLocationManager()
        // Setup search collectoion view
        setupSearchCollectionView()
        
        // Testing with artificial data
        APIClient.sharedInstance.getProductsByCity(city: "San Francisco") { (products) in
            
            self.mainMapView.addAnnotations(products)
            
        }
        
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
    
    
    fileprivate func setupSearchTextField() {
        self.view.addSubview(searchTextField)
        // Using this update products
        searchTextField.searchTextFieldDelegate = self
        
        // SearchTextField setup
        let textFieldFrame = CGRect(
            x: self.view.frame.width * 0.15,
            y: self.view.frame.height * 0.05,
            width: self.view.frame.width * 0.7,
            height: self.view.frame.height * 0.06
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



