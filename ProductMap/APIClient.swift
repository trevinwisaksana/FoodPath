//
//  APIClient.swift
//  ProductMap
//

import UIKit
import Firebase
import CoreLocation

class APIClient {
    
    static var sharedInstance = APIClient()
    
    static let reference = FIRDatabase.database().reference()
    static let productRef = reference.child("Products")
    
    public func firebaseSignUp(email: String, password: String, completion: (() -> Void)?) {
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            
            guard error == nil else {
                // TODO: Show please try again later
                return
            }
            
        }
        
    }
    
    
    public func firebaseSignIn(email: String, password: String, completion: (() -> Void)?) {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            guard error == nil else {
                // TODO: Show UIAlert
                return
            }
        }
        
    }
    
    public func firebaseCreateProduct(title: String, image: UIImage?, coordinates: CLLocationCoordinate2D) {
        let latitude = coordinates.latitude 
        let longitude = coordinates.longitude 
        let json: [String : Any] = [
            "title": title,
            "coordinates" : ["latitude" : latitude, "longitude" : longitude]
        ]
        
        APIClient.reference.child("Products").childByAutoId().setValue(json)
    }
    
    
    public func createNewProduct(product: Product){
        let productRef = APIClient.productRef.child(product.city).childByAutoId()
        productRef.setValue(product.toJson())
    }
    
    public func getProductsByCity(city: String, completionHandler: @escaping ([Product]) -> Void){
        APIClient.productRef.child(city).observe(.value, with: { (snapshot) in
            if snapshot.exists() {
                if let data = snapshot.value as? [String: AnyObject] {
                    print(data)
                    var products: [Product] = []
                    for i in data {
                        if let value = i.value as? [String: AnyObject] {
                            let product = Product(json: value, city: city)
                            if let product = product{
                                products.append(product)
                            }
                        }
                    }
                    completionHandler(products)
                }
            } else {
                // TODO: Handel no snapshot
            }
        })
    }
}

