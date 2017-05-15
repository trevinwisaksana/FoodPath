//
//  AddFoodButton.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 5/11/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

@objc protocol AddFoodButtonDelegate {
    func displayCrosshair()
    func addPin()
}


class AddFoodButton: UIButton {
    
    weak var delegate: AddFoodButtonDelegate?
    private var crosshairIsHidden = true
    private var mainView = UIView()
    
    /// Setup for add food button
    public func setupAddFoodButton(superview: UIView) {
        mainView = superview
        
        let width = superview.frame.width * 0.2
        
        frame = CGRect(
            x: superview.frame.width * 0.73,
            y: superview.frame.height * 0.85,
            width: width,
            height: width
        )
        
        // Attributes setup
        setTitle("+", for: .normal)
        titleLabel?.font = UIFont(name: "Averta", size: 30)
        backgroundColor = .blue
        layer.shadowOffset = CGSize(
            width: 0,
            height: 0
        )
        layer.shadowOpacity = 0.2
        layer.cornerRadius = frame.width / 2
        
        let gestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(addFoodButtonHandler)
        )
        addGestureRecognizer(gestureRecognizer)
        
        delegate = superview as? AddFoodButtonDelegate
        
        superview.addSubview(self)
    }
    
    
    @objc fileprivate func addFoodButtonHandler() {
        
        let width = mainView.frame.width * 0.2
        
        // Check if the crosshair is hidden or not
        if crosshairIsHidden == true {
            crosshairIsHidden = false
            
            let notificationName = NSNotification.Name("DismissTopBarNotification")
            NotificationCenter.default.post(
                name: notificationName,
                object: nil
            )
            
            delegate?.displayCrosshair()
            
            // self.titleLabel?.isHidden = true
        
            UIView.animate(withDuration: 0.2, animations: {
                
                self.frame = CGRect(
                    x: self.mainView.frame.width * 0.93,
                    y: self.mainView.frame.height * 0.85,
                    width: -self.frame.width * 4.27,
                    height: width
                )
                
            }, completion: { (_) in
                // Change title
                self.setTitle("Add food location", for: .normal)
                self.titleLabel?.font = UIFont(name: "Averta", size: 30)
            })
            
        } else {
            
            // Sets to true to have other portion of code to run
            crosshairIsHidden = true
            // Add pin
            delegate?.addPin()
            
        }
        
    }
    
    
    public func resizeToOriginal() {
        
        let width = mainView.frame.width * 0.2
        crosshairIsHidden = true
        
        let notificationName = NSNotification.Name("RevealTopBarNotification")
        NotificationCenter.default.post(
            name: notificationName,
            object: nil
        )
        
        UIView.animate(withDuration: 0.2, animations: {
            self.frame = CGRect(
                x: self.mainView.frame.width * 0.73,
                y: self.mainView.frame.height * 0.85,
                width: width,
                height: width
            )
            
            // Change title
            self.setTitle("+", for: .normal)
            self.titleLabel?.font = UIFont(name: "Averta", size: 30)
            
        })
        
    }

    
}
