//
//  ViewController.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/12/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController {
    
    let mainMapView = MainMapView()
    
    // MARK: Properties and Outlets
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup map view
        setupMapView()
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
        guard let annotation = annotation as? ProductLocation else { return nil }
        let id = annotation.identifier
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MKPinAnnotationView {
            // Set the view to the dequeued view
            view = dequeuedView
        } else {
            // Make a new view
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: id)
        }
        
        return view
    }
        
    // MARK: Life Cycle
   
}




