//
//  SearchTextField.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/15/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

protocol SearchProductDelegate: class {
    
    /// Updates the Search Collection View by passing the products array
    ///
    /// - Parameter products: An array of products
    func updateSearchCollectionView(products: [Product])
    func disableMapView()
    func enableMapView()
}


class SearchTextField: UITextField, UITextFieldDelegate {
    
    weak var searchProductDelegate: SearchProductDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Setting the textFieldDelegate to self
        self.delegate = self
        
        // Setting default placeholder
        placeholder = "   Search"
        
        // Font
        let font = UIFontDescriptor(
            name: "Avenir",
            size: 30
        )
        self.font = UIFont(descriptor: font, size: 30)
        
        // Corner radius
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // If the user has tapped the search text field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable map view
        searchProductDelegate?.disableMapView()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == "\n" {
            textField.resignFirstResponder()
            return false
        }
        
        APIClient.sharedInstance.searchForProduct(searchString: string, city: "San Francisco") { (products) in
            // Updates the search collection view
            self.searchProductDelegate?.updateSearchCollectionView(products: products)
        }
        
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchProductDelegate?.enableMapView()
    }


    
}
