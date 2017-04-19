//
//  Product.swift
//  ProductMap
//
//  Created by Bob De Kort on 4/17/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class Product: NSObject, MKAnnotation {
    
    var identifier = "Product Location"
    var title: String?
    var productDescription: String
    var city: String
    var coordinate: CLLocationCoordinate2D
    
    init?(title: String, description: String, city: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.productDescription = description
        self.city = city
        self.coordinate = coordinate
    }
    
    
    func toJson() -> [String: Any] {
        return [
            "title": title!,
            "description": productDescription,
            "coordinates": [
                "longitude": coordinate.longitude,
                "latitude": coordinate.latitude]
        ]
    }
    
    
    convenience init?(json: [String: AnyObject], city: String) {
        
        guard let title = json["title"] as? String,
            let description = json["description"] as? String,
            let coordinates = json["coordinates"] as? [String: AnyObject],
            let longitude = coordinates["longitude"] as? Double,
            let latitude = coordinates["latitude"] as? Double
            else {
                return nil
        }

        self.init(
            title: title,
            description: description,
            city: city,
            coordinate: CLLocationCoordinate2DMake(latitude, longitude))
    }
}
