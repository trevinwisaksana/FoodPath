//
//  ProductLocation.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/12/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import MapKit

class ProductLocation: NSObject, MKAnnotation {
    
    var identifier = "Product Location"
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var pinCustomImageName: String?
    
    init(name: String,
         latitude: CLLocationDegrees,
         longitude: CLLocationDegrees) {
        
        self.title = name
        self.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        
    }
    
}
