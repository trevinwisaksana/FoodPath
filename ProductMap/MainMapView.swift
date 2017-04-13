//
//  MainMapView.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/12/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//


import UIKit
import MapKit

class MainMapView: MKMapView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        resetRegion()
        // Cleans the map
        showsPointsOfInterest = false
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    /// Starts the map with a location in Chicago.
    /// It is sed for testing.
    func resetRegion() {
        // For testing
        let chicagoCoordinate = CLLocationCoordinate2DMake(41.8832301, -87.6278121)
        let region = MKCoordinateRegionMakeWithDistance(chicagoCoordinate, 5000, 5000)
        self.setRegion(region, animated: true)
    }
    
}
