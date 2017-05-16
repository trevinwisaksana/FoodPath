//
//  CancelAddFoodButton.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 5/11/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

protocol CancelAddFoodButtonDelegate: class {
    func dismissCrosshair()
}


class CancelAddFoodButton: UIButton {
    
    weak var delegate: CancelAddFoodButtonDelegate?
    private var mainView = UIView()
    
    /// Setup for add food button
    public func setupCancelAddFoodButton(superview: UIView) {
        mainView = superview
        
        alpha = 0
        
        let width = superview.frame.width * 0.15
        
        setTitle("x", for: .normal)
        titleLabel?.font = UIFont(name: "Avenir", size: 40)
        backgroundColor = .red
        layer.shadowOffset = CGSize(
            width: 0,
            height: 0
        )
        layer.shadowOpacity = 0.2
        frame = CGRect(
            x: superview.frame.width * 0.05,
            y: superview.frame.height * 0.05,
            width: width,
            height: width
        )
        layer.cornerRadius = frame.width / 2
        
        let gestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(cancelAddFoodButtonHandler)
        )
        addGestureRecognizer(gestureRecognizer)
        
        delegate = superview as? CancelAddFoodButtonDelegate
        
        superview.addSubview(self)
    }

    
    @objc fileprivate func cancelAddFoodButtonHandler() {
        
        let notificationName = NSNotification.Name("RevealTopBarNotification")
        NotificationCenter.default.post(
            name: notificationName,
            object: nil
        )

        delegate?.dismissCrosshair()
        
        UIView.animate(withDuration: 0.1) {
            self.alpha = 0
        }
        
        
    }
    
}
