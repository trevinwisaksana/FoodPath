//
//  MainViewController+MapView.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/15/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import MapKit

extension MainViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    
    // MARK: - Map View Method
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        // View
        var annotationView: MKPinAnnotationView
        guard let annotation = annotation as? ProductLocation else {
            return nil
        }
        
        let id = annotation.identifier
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MKPinAnnotationView {
            // Set the view to the dequeued view
            annotationView = dequeuedView
        } else {
            // Make a new view
            annotationView = AnnotationView(
                annotation: annotation,
                reuseIdentifier: id
            )
            annotationView.canShowCallout = false
        }
        
        // Miscellaneous setup
        annotationView.animatesDrop = true
        // let customAnnotationView = annotation as? CustomPointAnnotation
        
        
        return annotationView
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // If view.annotation is type MKUserLocation
        if view.annotation is MKUserLocation {
            // Don't proceed with custom callout
            return
        }
        
        let productAnnotation = view.annotation as? ProductLocation
        
        guard let coordinate = view.annotation?.coordinate else {
            return
        }
        
        let calloutView = CustomCalloutView()
        calloutView.title = productAnnotation?.title
        calloutView.address = productAnnotation?.address
        calloutView.frame = CGRect(
            x: 0,
            y: 0,
            width: 100,
            height: 100
        )
        calloutView.center = CGPoint(
            x: view.bounds.size.width / 2,
            y: -calloutView.bounds.size.height * 0.52
        )
        
        // Adding the calloutView to the Map View
        view.addSubview(calloutView)
        mapView.setCenter(coordinate, animated: true)
    }
    
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        // If the view is type AnnotationView
        if view.isKind(of: AnnotationView.self) {
            // Remove all the subviews
            for subview in view.subviews {
                subview.removeFromSuperview()
            }
        }
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        // Dragging states
        switch newState {
        case .starting:
            view.dragState = .dragging
        case .ending, .canceling:
            view.dragState = .none
        default:
            break
        }
    }
    
    
    // MARK: - CLLocationManager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Print the error
        log.verbose(error)
    }
    
}
