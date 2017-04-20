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
    
    // Used to check whether the UIView has animated or not
    var hasExpanded = false

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Setup
        backgroundColor = .white
        layer.cornerRadius = 15
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 2)
        
        // Sets up tap gesture
        setupTapGesture()
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
    
    
    /// Handles the tap gesture of the Bottom Bar
    @objc fileprivate func tapGestureHandler() {
        
        guard let keyWindow = UIApplication.shared.keyWindow else {
            fatalError()
        }
        
        let positionToMove = keyWindow.frame.midY * 0.8
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            // Move bottom bar upwards and downwards
            if self.hasExpanded == false {
                self.frame.origin.y = positionToMove
                self.hasExpanded = true
            } else {
                // 2.175 = (positionToMove - originalPosition) / positionToMove + 2
                self.frame.origin.y = positionToMove * 2.11
                self.hasExpanded = false
            }
        }) { (_) in
            // Maybe add something later
        }
    }
}
