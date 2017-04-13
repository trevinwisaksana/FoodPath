//
//  ViewController.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/12/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController {
    
    // MARK: - Views
    let mainMapView = MainMapView()
    let topBarView = TopBarView()
    let bottomBarView = BottomBarView()
    
    // MARK: Properties and Outlets
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup map view
        setupMapView()
        // Setup topBarView
        setupTopBarView()
        // Setup bottomBarView
        setupBottomBarView()
    
    }
    
    // MARK: - Map setup
    func setupMapView() {
        self.view.addSubview(mainMapView) 
        
        mainMapView.frame = view.frame
        // Setting the delegate
        mainMapView.delegate = self
    }
    
    // MARK: - Setup topBarView
    func setupTopBarView() {
        self.view.addSubview(topBarView)
    
        let width = self.view.frame.width
        let height = self.view.frame.height
        let frame = CGRect(x: 0, y: 0, width: width, height: height * 0.12)
        topBarView.frame = frame
    
    }
    
    // MARK: - Setup bottomBarView
    func setupBottomBarView() {
        self.view.addSubview(bottomBarView)
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        let frame = CGRect(x: 0,
                           y: height * 0.85,
                           width: width,
                           height: height * 0.5)
        bottomBarView.frame = frame
        
    }
    
    
    // MARK: - Annotations
    
    
    // MARK: - Overlays
    
    
    // MARK: Life Cycle
    
    
}


extension MainViewController: MKMapViewDelegate {
    
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
   
}




