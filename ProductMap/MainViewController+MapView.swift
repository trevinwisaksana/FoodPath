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
        
        // TODO: Fix the calloutView
        // Prevents having two calloutView's appearing on top of each other
        if calloutViewIsVisible == true {
            calloutView.removeFromSuperview()
        }
        
        // let productAnnotation = view.annotation as? ProductLocation
        
        // TODO: Add in constants file
        let width = self.view.frame.width
        let height = self.view.frame.height
        let calloutViewHeight = self.view.frame.height * 0.2
        
        // Setup calloutView
        calloutView.frame = CGRect(
            x: 0,
            y: height,
            width: width,
            height: calloutViewHeight
        )
        // Animates the entry of the calloutView
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            // Animating the calloutView
            self.calloutView.frame = CGRect(
                x: 0,
                y: height * 0.84,
                width: width,
                height: calloutViewHeight
            )
        })  { (_) in
            self.calloutViewIsVisible = true
        }
    
        // Adding the calloutView to the Map View
        self.view.addSubview(calloutView)
    }
    
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        
        // TODO: Not DRY, add in constants file
        let width = self.view.frame.width
        let height = self.view.frame.height
        let calloutViewHeight = self.view.frame.height * 0.2
        
        // If the view is type AnnotationView
        if view.isKind(of: AnnotationView.self) {
            // Animating the removal of the calloutView
            UIView.animate(withDuration: 0.2, animations: { 
                self.calloutView.frame = CGRect(
                    x: 0,
                    y: height,
                    width: width,
                    height: calloutViewHeight
                )
            }, completion: { (_) in
                // Remove the calloutView
                self.calloutView.removeFromSuperview()
                // Reset the Bool
                self.calloutViewIsVisible = false
            })
            
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
