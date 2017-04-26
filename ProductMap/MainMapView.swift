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

protocol AnimationManagerDelegate: class {
    func dismissTopBarContainer()
}


class MainMapView: MKMapView, AddProductViewDelegate {
    
    private var productCoordinate: CLLocationCoordinate2D?
    private var productLocation: Product?
    weak var animationDelegate: AnimationManagerDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Cleans the map
        showsPointsOfInterest = true
        showsTraffic = false
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
    
    
    // MARK: - Map setup
    func setupMapView(_ viewController: UIViewController) {
        viewController.view.addSubview(self)
        
        frame = viewController.view.frame
        // Setting the delegate
        delegate = viewController as? MKMapViewDelegate
        // User location
        showsUserLocation = true
        // Allow user tracking
        userTrackingMode = MKUserTrackingMode.follow
        
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
        
        // MARK: - Holy Grail
        productLocation = Product(
            id: nil,
            title: "",
            description: "",
            city: "",
            coordinate: touchMapCoordinate,
            upvoteCount: 0
            )
        
        // APIClient.sharedInstance.createProduct(product: productLocation)
        // TODO: Call a delegate method to send the ID
        
        guard let productLocation = productLocation else {
            return
        }
        
        self.setCenter(
            touchMapCoordinate,
            animated: false
        )
        self.addAnnotation(productLocation)
        self.isUserInteractionEnabled = false
        // Show view to insert product information
        showAddProductView()
        animationDelegate?.dismissTopBarContainer()
        
        let notificationName = NSNotification.Name("DismissTopBarNotification")
        NotificationCenter.default.post(
            name: notificationName,
            object: nil
        )
    
    }
    
    
    public func showAddProductView() {
        
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
            addProductView.frame.origin.y = height * 0.25
            self.frame.size.height = keyWindow.frame.height * 0.3
        }, completion: { (_) in
            
            guard let productCoordinate = self.productCoordinate else {
                return
            }
            
            // Adds the notation
            let region = MKCoordinateRegionMakeWithDistance(
                productCoordinate,
                50,
                50
            )
            self.setRegion(
                region,
                animated: true
            )
        })
        
    }
    
    
    func resizeMapView(for state: addProductViewState) {
        // Getting the phone size
        guard let keyWindow = keyWindow else {
            return
        }
        
        guard let productLocation = productLocation else {
            return
        }
        
        let userLocation = self.userLocation.coordinate
        
        UIView.animate(withDuration: 0.2, animations: {
            // Assigning the height of the map equal to the size of the screen
            self.frame.size.height = keyWindow.frame.height
            
            // Setting the center of the map to the user location
            self.setCenter(userLocation, animated: false)
            // Getting the region to focus
            let region = MKCoordinateRegionMakeWithDistance(
                userLocation,
                1200,
                1200
            )
            self.setRegion(region, animated: false)
            
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
        
        let userLocation = self.userLocation.coordinate
        let clLocation = CLLocation(
            latitude: userLocation.latitude,
            longitude: userLocation.longitude
        )
        
        DataManager.shared.getCityByCoordinates(location: clLocation) { (city) in
            
            let product = Product(
                id: nil,
                title: title,
                description: description,
                city: city,
                coordinate: productCoordinate,
                upvoteCount: 0
            )
            
            APIClient.sharedInstance.createProduct(product: product)
            
        }
        
    }
}
