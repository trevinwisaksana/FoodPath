//
//  CustomCalloutView.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/16/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

class CustomCalloutView: UIView {
    
    var title: String?
    var address: String?
    
    // Product Name Label
    var productNameLabel: UILabel = {
        let label = UILabel()
        
        
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Setup tap gesture to present ProductViewController
        setupTapGesture()
        
        // Miscellaneous setup
        backgroundColor = .white
        layer.cornerRadius = 15
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// Handles the setup of the tap gesture for the Bottom Bar
    fileprivate func setupTapGesture() {
        isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(tapGestureHandler))
        addGestureRecognizer(tapGesture)
    }
    
    
    /// Handles the tap gesture of the calloutView
    @objc fileprivate func tapGestureHandler() {
        
        // Present the ProductViewController modally
        let mainViewController = UIApplication.shared.keyWindow?.rootViewController
        mainViewController?.present(
            ProductViewController(),
            animated: true,
            completion: nil
        )
        
    }
    
}
