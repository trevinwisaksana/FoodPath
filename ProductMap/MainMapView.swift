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
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func resetRegion() {
        let region = MKCoordinateRegionMakeWithDistance(chicagoCoordinate, 5000, 5000)
        self.setRegion(region, animated: true)
    }
    
    
    func pinColor(name: String) -> UIColor {
        // Default color
        var color = UIColor.blue
        
        switch name {
        case "Connie's Pizza":
            color = UIColor.blue
        case "Lou Malnati's":
            color = UIColor.green
        case "Giordano's":
            color = UIColor.yellow
        default:
            color = UIColor.orange
        }
        
        return color
    }
    
}
