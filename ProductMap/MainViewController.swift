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


class MainViewController: UIViewController, SearchTextFieldDelegate, TopBarContainerDelegate {
    
    // MARK: - Lists
    var listOfCategories: [Category] = []
    // List of Products
    var listOfProducts: [Product] = []
    var listOfFilteredProducts = Set<Product>()
    
    
    // MARK: - Views
    let mainMapView = MainMapView()
    let searchView = SearchView()
    let topBarContainer = TopBarContainer()
    var searchTextField = SearchTextField()
    var categoriesCollectionView: CategoriesCollectionView!
    var searchCollectionView: SearchCollectionView!
    let locationManager = CLLocationManager()
    
    
    // MARK: - Logic
    var calloutViewIsVisible = false
    // Used to prevent didUpdate from sending continous network request
    var didGetCity: Bool = false
    
    // MARK: Properties and Outlets
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup map view
        mainMapView.setupMapView(self)
        // Setup searchView
        searchView.setupSearchView(self)
        // Setup top bar container
        topBarContainer.setupTopBarContainer(self)
        // Setup search text field
        searchTextField.setupSearchTextField(self, topBarContainer)
        // Setup for location manager
        setupLocationManager()
        // Setup search collectoion view
        setupSearchCollectionView()
        
        // TESTING
//        let product = Product(id: nil, title: "Testing", description: "Testing", city: "San Francisco", coordinate: CLLocationCoordinate2DMake(0, 0) , upvoteCount: 1)
//        APIClient.sharedInstance.createProduct(product: product)
        
        
    }
    
    func updateProducts(city: String) {
        APIClient.sharedInstance.getProductsByCity(city: city) { (products) in
            
            self.mainMapView.addAnnotations(products)
        }
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
        
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        layout.sectionInset = UIEdgeInsets(
            top: 20,
            left: 12,
            bottom: 10,
            right: 10
        )
        
        // Makes the height and width equal
        layout.itemSize = CGSize(
            width: self.view.frame.width * 0.9,
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
}



