//
//  AnnotationView.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/16/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import MapKit

class AnnotationView: MKPinAnnotationView {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        //
        if let hitView = super.hitTest(point, with: event) {
            // Show the annotation view
            self.superview?.bringSubview(toFront: self)
            return hitView
        }
        
        return nil
    }
    
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        // If the receive is inside the frame's bound
        var isInside: Bool = frame.contains(point)
        // Check if it's not inside
        if isInside == false {
            // Keep looping all the subviews
            for view in self.subviews {
                // Mutate the isInside value until it returns true
                isInside = view.frame.contains(point)
                if isInside == true {
                    break
                }
            }
        }
        
        return isInside
    }
    
}
