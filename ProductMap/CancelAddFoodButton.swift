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
        self.mainView = superview
        
        self.alpha = 0
        
        let width = superview.frame.width * 0.15
        
        self.setTitle("X", for: .normal)
        self.backgroundColor = .red
        self.layer.shadowOffset = CGSize(
            width: 0,
            height: 0
        )
        self.layer.shadowOpacity = 0.2
        self.frame = CGRect(
            x: superview.frame.width * 0.05,
            y: superview.frame.height * 0.05,
            width: width,
            height: width
        )
        self.layer.cornerRadius = self.frame.width / 2
        
        let gestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(cancelAddFoodButtonHandler)
        )
        self.addGestureRecognizer(gestureRecognizer)
        
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
