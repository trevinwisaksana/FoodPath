//
//  SignInButton.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/13/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

// TODO: Use this to call the SignInButton
class SignInButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitle("Login", for: .normal)
        setTitleColor(UIColor.blue, for: .normal)
        
        layer.cornerRadius = 25
        layer.borderWidth = 1
        layer.borderColor = UIColor.blue.cgColor
        
        backgroundColor = UIColor.white
        
        
        // Autolayout
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        widthAnchor.constraint(equalToConstant: 200).isActive = true
        bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
