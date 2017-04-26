//
//  APIClient.swift
//  ProductMap
//

import UIKit
import Firebase
import CoreLocation
import SwiftyJSON


class APIClient {
    static var sharedInstance = APIClient()
    
    static let reference = FIRDatabase.database().reference()
    static let productRef = reference.child("Products")
    
    // USED FOR TESTING
    public func firebaseCreateProduct(title: String, image: UIImage?, coordinates: CLLocationCoordinate2D) {
        
        let latitude = coordinates.latitude 
        let longitude = coordinates.longitude
        
        let json: [String : Any] = [
            "title": title,
            "id": "",
            "coordinates" :
                ["latitude" : latitude,
                 "longitude" : longitude]
        ]
        
        APIClient.reference.child("Products").childByAutoId().setValue(json)
    }
    
    
    public func createProduct(product: Product, completion: @escaping (String) -> Void) {
        // Retrieving product reference
        let productRef = APIClient.productRef.child(product.city).childByAutoId()
        
        // Modify database in Firebase
        productRef.setValue(product.toJson()){ (error, ref) -> Void in
            if error == nil {
                completion(ref.key)
            }
        }
    }
    
    public func updateProduct(id: String, title: String, city: String, description: String) {
        
        let productRef = APIClient.productRef.child(city).child(id)
        
        productRef.child("title").setValue(title)
        productRef.child("description").setValue(description)
    }
    
    func updateProductUpvoteCount(id: String, city: String, upvoteCount: Int) {
        APIClient.productRef.child(city).child(id).child("upvoteCount").setValue(upvoteCount)
    }
    
    
    
    public func getProductsByCity(city: String, completionHandler: @escaping ([Product]) -> Void){
        
        APIClient.productRef.child(city).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                
                if let data = snapshot.value as? [String: AnyObject] {
                    
                    var products: [Product] = []
                    
                    for i in data {
                        if let value = i.value as? [String: AnyObject] {
                            let product = Product(json: value, city: city, id: i.key)
                            if let product = product {
                                products.append(product)
                            }
                        }
                    }
                    
                    completionHandler(products)
                    
                }
            } else {
                // TODO: Handle no snapshot
            }
        })
    }
    
    public func searchForProduct(searchString: String, city: String, completion: @escaping ([Product]) -> Void){
        
        let query = APIClient.productRef.child(city).queryOrdered(byChild: "title")
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let data = snapshot.value as? [String: AnyObject] {
                    
                    var filteredProducts = Set<Product>()
                    
                    for i in data {
                        
                        if let value = i.value as? [String: AnyObject] {
                            
                            if let product = Product(json: value, city: city, id: i.key) {
                                
                                if product.title?.lowercased().range(of: searchString.lowercased()) != nil {
                                    filteredProducts.insert(product)
                                }
                            }
                                
                        }
                    }
                    
                    if searchString.isEmpty {
                        filteredProducts.removeAll()
                        completion([])
                    }
                    
                    if filteredProducts.isEmpty {
                        return
                    }
                    
                    completion(Array(filteredProducts))
                }
            }
        })
    }
    
    // MARK: Up and down vote requests
    public func downvoteRequest(with id: String, city: String) {
        getProduct(with: id, city: city) { (product) in
            if var upvoteCount = product.upvoteCount {
                if upvoteCount == 0 {
                    self.updateProductUpvoteCount(id: id, city: city, upvoteCount: 0)
                } else {
                    upvoteCount -= 1
                    self.updateProductUpvoteCount(id: id, city: city, upvoteCount: upvoteCount)
                }
            }
        }
    }
    
    
    public func upvoteRequest(with id: String, city: String) {
        
        getProduct(with: id, city: city) { (product) in
            if var upvoteCount = product.upvoteCount {
                upvoteCount += 1
                self.updateProductUpvoteCount(id: id, city: city, upvoteCount: upvoteCount)
            }
        }
    }
    
    
    func getProduct(with id: String, city: String, completionHandler: @escaping (Product) -> Void) {
        APIClient.productRef.child(city).child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let data = snapshot.value as? [String: AnyObject] {
                    let product = Product(json: data, city: city, id: id)
                    if let product = product {
                        completionHandler(product)
                    }
                }
            }
        })
    }
    
    // MARK: Login and Signup requests
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
}

