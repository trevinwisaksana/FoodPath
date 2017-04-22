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
    private var productLocation: Product?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Cleans the map
        showsPointsOfInterest = true
        // Setting user location
        showsUserLocation = true
        // Disabling compass
        showsCompass = false
        // Map type
        mapType = MKMapType.standard
        // Setup gesture recognizer
        setupLongTapGesture()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        productLocation = Product(
            id: nil,
            title: "Test",
            description: "Testing",
            city: "Testong",
            coordinate: touchMapCoordinate,
            upvoteCount: 0
            )
        
        guard let productLocation = productLocation else {
            return
        }
        
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
    
    
    func resizeMapView(for state: addProductViewState) {
        guard let keyWindow = keyWindow else {
            return
        }
        
        guard let productLocation = productLocation else {
            return
        }
        
        UIView.animate(withDuration: 0.2, animations: { 
            self.frame.size.height = keyWindow.frame.height
            
            switch state {
            case .addProduct:
                break
            case .cancelAdd:
                self.removeAnnotation(productLocation)
            }
            
        }) { (_) in
            self.isUserInteractionEnabled = true
        }
    }
    
    
    func createProduct(title: String, description: String, image: UIImage?) {
        
        guard let productCoordinate = self.productCoordinate else {
            return
        }
        
        let product = Product(
            id: nil,
            title: title,
            description: description,
            city: "San Francisco",
            coordinate: productCoordinate,
            upvoteCount: 0
        ) 
        
        APIClient.sharedInstance.createProduct(product: product)
        
    }
}
