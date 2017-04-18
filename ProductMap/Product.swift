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
    var city: String
    var coordinates: CLLocationCoordinate2D
    
    init?(title: String, description: String, city: String, coordinates: CLLocationCoordinate2D) {
        self.title = title
        self.description = description
        self.city = city
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
    
    convenience init?(json: [String: AnyObject], city: String) {
        
        guard let title = json["title"] as? String,
            let description = json["description"] as? String,
            let coordinates = json["coordinates"] as? [String: AnyObject],
            let long = coordinates["longitude"] as? Double,
            let lat = coordinates["latitude"] as? Double
            else {
                return nil
        }

        self.init(title: title, description: description, city: city, coordinates: CLLocationCoordinate2DMake(long, lat))
    }
}
