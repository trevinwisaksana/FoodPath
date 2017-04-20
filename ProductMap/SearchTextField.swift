//
//  SearchTextField.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/15/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

protocol SearchTextFieldDelegate: class {
    
    /// Updates the Search Collection View by passing the products array
    ///
    /// - Parameter products: An array of products
    func updateSearchCollectionView(products: [Product])
    func revealSearchView()
}


class SearchTextField: UITextField, UITextFieldDelegate {
    
    weak var searchTextFieldDelegate: SearchTextFieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Setting the textFieldDelegate to self
        delegate = self
        
        // Setting default placeholder
        placeholder = "   Search"
        
        // Font
        let font = UIFontDescriptor(
            name: "Avenir",
            size: 30
        )
        self.font = UIFont(descriptor: font, size: 30)
        
        // Corner radius
        clipsToBounds = true
        layer.cornerRadius = 5
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // If the user has tapped the search text field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable map view
        searchTextFieldDelegate?.revealSearchView()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == "\n" {
            textField.resignFirstResponder()
            return false
        }
        
        
        APIClient.sharedInstance.searchForProduct(searchString: string, city: "San Francisco") { (products) in
            // Updates the search collection view
            self.searchTextFieldDelegate?.updateSearchCollectionView(products: products)
        }
        
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // searchProductDelegate?.dismissSearchView()
    }

}
