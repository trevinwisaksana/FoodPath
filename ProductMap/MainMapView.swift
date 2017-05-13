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


class MainMapView: MKMapView, AddProductViewDelegate, AddFoodButtonDelegate, CancelAddFoodButtonDelegate {
    
    
    private var productCoordinate: CLLocationCoordinate2D?
    private var productLocation: Product?
    private var productID: String?
    private var currentCity: String?
    private var mapCrosshair = UIImageView()
    private var pinAnnotationImage =  MKPinAnnotationView()
    private var crosshairIsHidden = true
    
    private var addFoodButton = AddFoodButton()
    private var cancelAddFoodButton = CancelAddFoodButton()
    
    
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
        
        frame = viewController.view.bounds
        // Setting the delegate
        delegate = viewController as? MKMapViewDelegate
        // User location
        showsUserLocation = true
        // Allow user tracking
        userTrackingMode = MKUserTrackingMode.follow
        
        // Setup crosshair image
        setupMapCrosshair()
        
        // Setup food button
        addFoodButton.setupAddFoodButton(superview: self)
        
        // Setup cancel button
        cancelAddFoodButton.setupCancelAddFoodButton(superview: self)
        
        // TODO: Add an animation to change the button size and title to "Add food destination"
    
    }
    
    
    func displayCrosshair() {
        mapCrosshair.isHidden = false
        
        UIView.animate(withDuration: 0.2) {
            self.cancelAddFoodButton.alpha = 1
        }
        
    }
    
    
    func dismissCrosshair() {
        mapCrosshair.isHidden = true
        addFoodButton.resizeToOriginal()
    }
    
    
    /// Sets up the middle crosshair
    fileprivate func setupMapCrosshair() {
        
        mapCrosshair.image = #imageLiteral(resourceName: "pinImage")
        
        mapCrosshair.center.x = self.center.x
        mapCrosshair.frame.origin = self.center
        // Setting the position of the crosshair to be slightly higher than the thumb movement area
        mapCrosshair.center.y = self.center.y / 1.5
        
        mapCrosshair.frame.size = CGSize(width: 20, height: 50)
        
        mapCrosshair.isHidden = true
        
        self.addSubview(mapCrosshair)
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
    @objc func longPressHandler(_ gestureRecognizer: UIGestureRecognizer) {
        
        if gestureRecognizer.state != .began { return }
        
        let touchPoint = gestureRecognizer.location(in: self)
        // Converts the touch point to a coordinate
        let touchMapCoordinate = self.convert(
            touchPoint,
            toCoordinateFrom: self
        )
        
        productCoordinate = touchMapCoordinate
        
        guard let productCoordinate = productCoordinate else {
            return
        }
        
        let clLocation = CLLocation(
            latitude: productCoordinate.latitude,
            longitude: productCoordinate.longitude
        )
        
        DataManager.shared.getCityByCoordinates(
            location: clLocation) { (city) in
                
                self.currentCity = city
                
                self.productLocation = Product(
                    id: nil,
                    title: "",
                    description: "",
                    city: city,
                    coordinate: touchMapCoordinate,
                    upvoteCount: 0,
                    imageUrl: nil
                )
                
                
                guard let productLocation = self.productLocation else {
                    return
                }
                
                // Creating a new product in the long press because we need to get the key
                APIClient.sharedInstance.createProduct(product: productLocation) { (key) in
                    self.productID = key
                }
                
                self.setCenter(
                    touchMapCoordinate,
                    animated: false
                )
                self.addAnnotation(productLocation)
                self.isUserInteractionEnabled = false
                // Show view to insert product information
                self.showAddProductView()
                
                let notificationName = NSNotification.Name("DismissTopBarNotification")
                NotificationCenter.default.post(
                    name: notificationName,
                    object: nil
                )

        }
        
    }
    
    
    func addPin() {
        
        cancelAddFoodButton.alpha = 0
        
        // TODO: Reuse code
        
        let crosshairPoint = mapCrosshair.center
        
        // Converts the touch point to a coordinate
        let crosshairCoordinate = self.convert(
            crosshairPoint,
            toCoordinateFrom: self
        )
        
        productCoordinate = crosshairCoordinate
        
        guard let productCoordinate = productCoordinate else {
            return
        }
        
        let clLocation = CLLocation(
            latitude: productCoordinate.latitude,
            longitude: productCoordinate.longitude
        )
        
        DataManager.shared.getCityByCoordinates(
        location: clLocation) { (city) in
            
            self.currentCity = city
            
            self.productLocation = Product(
                id: nil,
                title: "",
                description: "",
                city: city,
                coordinate: crosshairCoordinate,
                upvoteCount: 0,
                imageUrl: nil
            )
            
            
            guard let productLocation = self.productLocation else {
                return
            }
            
            // Creating a new product in the long press because we need to get the key
            APIClient.sharedInstance.createProduct(product: productLocation) { (key) in
                self.productID = key
            }
            
            self.setCenter(
                crosshairCoordinate,
                animated: false
            )
            self.addAnnotation(productLocation)
            self.isUserInteractionEnabled = false
            // Show view to insert product information
            self.showAddProductView()
            
            let notificationName = NSNotification.Name("DismissTopBarNotification")
            NotificationCenter.default.post(
                name: notificationName,
                object: nil
            )
            
        }
        
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
        
        // Resize button
        addFoodButton.resizeToOriginal()
        
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
                
                // Used to prevent using bang operators
                guard let productID = self.productID else {
                    return
                }
                guard let currentCity = self.currentCity else {
                    return
                }
                // Delete the product when we cancel the add
                APIClient.sharedInstance.deleteProduct(
                    id: productID,
                    city: currentCity
                )
                
                // Remove the annotation because it's cancelled
                self.removeAnnotation(productLocation)
            }
            
        }) { (_) in
            self.isUserInteractionEnabled = true
        }
    }
    
    
    func createProduct(title: String, description: String, image: UIImage?) {
        
        guard let productID = productID else {
            return
        }
        
        guard let currentCity = currentCity else {
            return
        }
    
        // Assigning the product ID because it's set to nil by default
        productLocation?.id = productID
        // Updating the product with the ID with the new information
        APIClient.sharedInstance.updateProduct(
            id: productID,
            title: title,
            city: currentCity,
            description: description
        )
        
    }
}
