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
        placeholder = "Search"
        
        // Font
        font = UIFont(name: "Avenir", size: 25)
        
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.1
        backgroundColor = .white
        textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func setupSearchTextField(_ viewController: UIViewController, _ superview: UIView) {
        superview.addSubview(self)
        
        // Using this update products
        self.searchTextFieldDelegate = viewController as? SearchTextFieldDelegate
        
        // SearchTextField setup
        let textFieldFrame = CGRect(
            x: 0,
            y: 0,
            width: superview.frame.width,
            height: superview.frame.height
        )
        
        self.frame = textFieldFrame
        
        // Corner radius
        layer.cornerRadius = superview.layer.cornerRadius
    }
    
    
    // If the user has tapped the search text field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Clear the text field
        textField.text = ""
        // Disable map view
        searchTextFieldDelegate?.revealSearchView()
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == "\n" {
            textField.resignFirstResponder()
            return false
        }
        
        // TODO: Change the city
        APIClient.sharedInstance.searchForProduct(searchString: string, city: "San Francisco") { (products) in
            // Updates the search collection view
            self.searchTextFieldDelegate?.updateSearchCollectionView(products: products)
        }
        
        return true
    }

}
