//
//  MainMapView.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/12/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//


import UIKit
import MapKit
import Firebase

class MainMapView: MKMapView, AddProductViewDelegate {
    
    private var productCoordinate: CLLocationCoordinate2D?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        resetRegion()
        // Cleans the map
        showsPointsOfInterest = false
        // Setting user location
        showsUserLocation = true
        // Map type
        mapType = MKMapType.standard
        // Setup gesture recognizer
        setupLongTapGesture()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    /// Starts the map with a location in Chicago.
    /// It is set for testing.
    func resetRegion() {
        // For testing
        let chicagoCoordinate = CLLocationCoordinate2DMake(41.8832301, -87.6278121)
        let region = MKCoordinateRegionMakeWithDistance(chicagoCoordinate, 5000, 5000)
        self.setRegion(region, animated: true)
    }
    
    
    fileprivate func setupLongTapGesture() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(
            target: self,
            action: #selector(longPressHandler)
        )
        
        addGestureRecognizer(longPressGestureRecognizer)
    }
    
    
    /// Adds a pin on the MapView when the user long presses
    ///
    /// - Parameter gestureRecognizer: Default UIGestureRecognizer
    @objc fileprivate func longPressHandler(_ gestureRecognizer: UIGestureRecognizer) {
        
        if gestureRecognizer.state != .began { return }
        
        let touchPoint = gestureRecognizer.location(in: self)
        // Converts the touch point to a coordinate
        let touchMapCoordinate = self.convert(
            touchPoint,
            toCoordinateFrom: self
        )
        
        productCoordinate = touchMapCoordinate
        
        guard let productLocation = Product(
            title: "Test",
            description: "Testing",
            city: "Testong",
            coordinate: touchMapCoordinate
            ) else { return }
        
        // Adds the notation
        // TODO: Make a network request to Firebase
        self.setCenter(touchMapCoordinate, animated: true)
        self.addAnnotation(productLocation)
        self.isUserInteractionEnabled = false
        // Show view to insert product information
        showAddProductView()
    }
    
    fileprivate func showAddProductView() {
        
        guard let keyWindow = keyWindow else {
            return
        }
        
        let width = keyWindow.frame.width
        let height = keyWindow.frame.height
        
        let frame = CGRect(
            x: 0,
            y: keyWindow.frame.maxY,
            width: width,
            height: height * 0.8
        )
        let addProductView = AddProductView(frame: frame)
        
        addProductView.delegate = self
        
        guard let mainViewController = keyWindow.rootViewController else {
            return
        }
        
        mainViewController.view.addSubview(addProductView)
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 1,
            options: .curveEaseIn,
            animations: {
            // Animate Product View
            addProductView.frame.origin.y = height * 0.5
            self.frame.size.height = keyWindow.frame.height * 0.55
        })
        
    }
    
    
    func resizeMapView() {
        guard let keyWindow = keyWindow else {
            return
        }
        
        UIView.animate(withDuration: 0.2, animations: { 
            self.frame.size.height = keyWindow.frame.height

        }) { (_) in
            self.isUserInteractionEnabled = true
        }
    }
    
    
    func createProduct(title: String, description: String, image: UIImage?) {
        
        guard let productCoordinate = self.productCoordinate else {
            return
        }
        
        guard let product = Product(
            title: title,
            description: description,
            city: "Test",
            coordinate: productCoordinate
        ) else { return }
        
        APIClient.sharedInstance.createProduct(product: product)
        
    }
}
