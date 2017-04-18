//
//  SearchBarView.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/13/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//


import UIKit
import MapKit

protocol SearchProductDelegate {
    func retrieveUserLocation()
}


/// TopBarView contains the search bar along with the search collection view
class TopBarView: UIView, UITextFieldDelegate {
    
    private var searchTextField = SearchTextField()
    let searchView = SearchView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup
        searchTextField.delegate = self
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupSearchTextField() {
        self.addSubview(searchTextField)
        
        // SearchTextField setup
        let textFieldFrame = CGRect(
            x: frame.width * 0.05,
            y: frame.height * 0.35,
            width: frame.width * 0.9,
            height: frame.height * 0.6
        )
        
        searchTextField.frame = textFieldFrame
        searchTextField.backgroundColor = UIColor.white
    }
    
    
    func setupSearchView() {
        self.addSubview(searchView)
        
        // SearchTextField setup
        let viewFrame = CGRect(
            x: searchTextField.frame.origin.x,
            y: searchTextField.frame.origin.y,
            width: searchTextField.frame.width,
            height: 0
        )
        
        searchView.frame = viewFrame
        searchView.layer.cornerRadius = 10
        searchView.backgroundColor = UIColor.white
    }
    
    
    // If the user has tapped the search text field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showSearchView()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if text == "\n" {
            textField.resignFirstResponder()
            return false
        }
        
        let filteredDataSet = Set<Product>()
        
        APIClient.sharedInstance.searchForProduct(searchString: string, city: "San Francisco") { (products) in
            
        }
        
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        dismissSearchView()
    }
    
    
    func showSearchView() {
        self.setupSearchView()
        
        guard let keyWindow = keyWindow?.frame else {
            return
        }
            
        UIView.animate(withDuration: 0.4, animations: {
            // Create search view when editting
            self.searchView.frame.size.height = keyWindow.height * 0.6
        }, completion: { (_) in
            self.sendSubview(toBack: self.searchView)
        })
        
    }
    
    
    func dismissSearchView() {
        
        UIView.animate(withDuration: 0.4, animations: {
            // Create search view when editting
            self.searchView.frame.size.height = 0
        }, completion: { (_) in
            self.searchView.removeFromSuperview()
        })
        
    }
    
}
