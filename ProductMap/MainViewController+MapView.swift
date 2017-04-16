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
        var view: MKPinAnnotationView
        guard let annotation = annotation as? ProductLocation else {
            return nil
        }
        
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
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        switch newState {
        case .starting:
            view.dragState = .dragging
        case .ending, .canceling:
            view.dragState = .none
        default:
            break
        }
    }
    
}
