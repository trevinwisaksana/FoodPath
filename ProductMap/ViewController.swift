//
//  ViewController.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/12/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import MapKit

// For testing
let chicagoCoordinate = CLLocationCoordinate2DMake(41.8832301, -87.6278121)

class ViewController: UIViewController {
    
    let products = ProductLocationList().products
    
    let mainMapView = MainMapView()
    
    // MARK: Properties and Outlets
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup map view
        setupMapView()
        
        // Testing
        mainMapView.addAnnotations(products)
    }
    
    // MARK: - Map setup
    func setupMapView() {
        // Setting the size of the map view
        self.view.addSubview(mainMapView)
        mainMapView.frame = view.frame
        // Setting the delegate
        mainMapView.delegate = self
    }
    
    
    // MARK: - Annotations
    
    
    // MARK: - Overlays
    
    
}


extension ViewController: MKMapViewDelegate {
    
    // MARK: - Map View Method
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // View
        var view: MKPinAnnotationView
        // TODO: Change name to something clearer
        guard let annotate = annotation as? ProductLocation else { return nil }
        let id = annotate.identifier
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MKPinAnnotationView {
            // Set the view to the dequeued view
            view = dequeuedView
        } else {
            // Make a new view
            view = MKPinAnnotationView(annotation: annotate, reuseIdentifier: id)
        }
        // Pin tint color
        view.pinTintColor = mainMapView.pinColor(name: id)
        
        return view
    }
        
    // MARK: Life Cycle
   
}




