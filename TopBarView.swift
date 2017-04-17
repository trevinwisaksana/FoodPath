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
    
    let searchTextField = SearchTextField()
    
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
            y: frame.height * 0.3,
            width: frame.width * 0.9,
            height: frame.height * 0.8
        )
        
        searchTextField.frame = textFieldFrame
        searchTextField.backgroundColor = UIColor.white
    }
    
}
