//
//  Data Manager.swift
//  ProductMap
//
//  Created by Bob De Kort on 4/24/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import CoreLocation

class DataManager {
    
    static var shared = DataManager()
    
    func getCityByCoordinates(location: CLLocation, completion: @escaping (String) -> Void){
        // Add below code to get address for touch coordinates.
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(
            location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]

            // City
            if let city = placeMark.addressDictionary!["City"] as? String {
                completion(city)
            }
        })
    }
}

