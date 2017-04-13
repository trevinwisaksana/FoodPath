//
//  BottomBarView.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/13/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import MapKit

class BottomBarView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Setup
        backgroundColor = .white
        layer.cornerRadius = 15
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
