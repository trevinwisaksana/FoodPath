//
//  SearchTextField.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/15/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

class SearchTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        self.layer.cornerRadius = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
