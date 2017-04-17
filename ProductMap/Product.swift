//
//  Product.swift
//  ProductMap
//
//  Created by Bob De Kort on 4/17/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import Foundation
import CoreLocation

class Product {
    var title: String
    var description: String
    var coordinates: CLLocationCoordinate2D
    
    init(title: String, description: String, coordinates: CLLocationCoordinate2D) {
        self.title = title
        self.description = description
        self.coordinates = coordinates
    }
    
    func toJson() -> [String: Any]{
        return [
            "title": title,
            "description": description,
            "coordinates": [
                "longitude": coordinates.longitude,
                "latitude": coordinates.latitude]
        ]
    }
}
