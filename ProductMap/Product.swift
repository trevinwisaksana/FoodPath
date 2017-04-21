//
//  Product.swift
//  ProductMap
//
//  Created by Bob De Kort on 4/17/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import Foundation
import MapKit

class Product: NSObject, MKAnnotation {
    
    var id: String?
    var identifier = "Product Location"
    var title: String?
    var productDescription: String
    var upvoteCount: Int?
    var city: String
    var imageUrl: String?
    var coordinate: CLLocationCoordinate2D

    
    init?(id: String?, title: String, description: String, city: String, coordinate: CLLocationCoordinate2D, upvoteCount: Int?) {
        self.title = title
        self.productDescription = description
        self.city = city
        self.coordinate = coordinate
        self.id = id
        self.upvoteCount = upvoteCount ?? 0
    }
    
    
    func toJson() -> [String: Any] {
        return [
            "title": title!,
            "description": productDescription,
            "upvoteCount": upvoteCount ?? 0,
            "coordinates": [
                "longitude": coordinate.longitude,
                "latitude": coordinate.latitude]
        ]
    }
    
    
    convenience init?(json: [String: AnyObject], city: String, id: String) {
        
        guard let title = json["title"] as? String,
            let description = json["description"] as? String,
            let coordinates = json["coordinates"] as? [String: AnyObject],
            let longitude = coordinates["longitude"] as? Double,
            let latitude = coordinates["latitude"] as? Double
            else {
                return nil
        }
        
        let upvoteCount = json["upvoteCount"] as? Int

        self.init(
            id: id,
            title: title,
            description: description,
            city: city,
            coordinate: CLLocationCoordinate2DMake(latitude, longitude),
            upvoteCount: upvoteCount
        )
    }
}
