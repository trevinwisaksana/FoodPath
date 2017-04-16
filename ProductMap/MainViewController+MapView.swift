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
            annotationView = MKPinAnnotationView(
                annotation: annotation,
                reuseIdentifier: id
            )
            annotationView.canShowCallout = true
        }
        
        // Miscellaneous setup
        annotationView.animatesDrop = true
        // let customAnnotationView = annotation as? CustomPointAnnotation
        
        
        return annotationView
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
