//
//  APIClient.swift
//  ProductMap
//
//  Created by Bob De Kort on 4/16/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import Foundation
import FirebaseDatabase
import CoreLocation

class APIClient {
    
    static var sharedInstance = APIClient()
    
    static let rootRef = FIRDatabase.database().reference()
    static let productRef = rootRef.child("Products")
    
    func makeNewProduct(product: Product){
        let productRef = APIClient.productRef.childByAutoId()
        
        productRef.setValue(product.toJson())
    }
    
    
}

