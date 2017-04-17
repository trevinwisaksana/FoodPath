//
//  SearchBarView.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/13/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//


import UIKit
import MapKit


/// TopBarView contains the search bar along with the search collection view
class TopBarView: UIView {
    
    private let searchTextField = SearchTextField()
    private let searchView = SearchView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup
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
        
        
    }
    
    func showSearchView() {
        // If the user has tapped the search text field
        if searchTextField.isEditing {
            
        }
        
    }
    
}
