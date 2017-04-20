//
//  CustomCalloutView.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/16/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

class CustomCalloutView: UIView {
    
    // UIElements
    var productNameLabel = UILabel()
    // Button for upvoting
    var upvoteButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Setup tap gesture to present ProductViewController
        setupTapGesture()
        // Setup productNameLabel
        setupProductNameLabel()
        // Setup upvote button
        setupUpvoteButton()
        
        // Miscellaneous setup
        backgroundColor = .blue
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
    
    
    fileprivate func setupProductNameLabel() {
        self.addSubview(productNameLabel)
        
        guard let keyWindow = keyWindow?.frame else {
            return
        }
        
        let labelFrame = CGRect(
            x: keyWindow.width * 0.05,
            y: keyWindow.width * 0.03,
            width: keyWindow.width * 0.6,
            height: keyWindow.height * 0.06
        )
        let labelFont = UIFont(
            name: "Avenir",
            size: 30
        )
        productNameLabel.frame = labelFrame
        productNameLabel.font = labelFont
        productNameLabel.backgroundColor = .green
        
    }
    
    
    /// Encapsulates the CustomCalloutView UIElements to be configured
    ///
    /// - Parameter product: A custom Product model
    public func configure(with product: Product) {
        // Assigning properties
        productNameLabel.text = product.title
        
        
    }
    
    
    fileprivate func setupUpvoteButton() {
        self.addSubview(upvoteButton)
    
        // Window frame
        guard let windowFrame = keyWindow?.frame else {
            return
        }
        
        let buttonFrame = CGRect(
            x: windowFrame.width * 0.72,
            y: windowFrame.width * 0.03,
            width: 80,
            height: 80
        )
        upvoteButton.frame = buttonFrame
        upvoteButton.backgroundColor = .white
        upvoteButton.layer.cornerRadius = upvoteButton.frame.width / 2
        
        // Button label
        let buttonFont = UIFont(name: "Avenir", size: 35)
        upvoteButton.titleLabel?.font = buttonFont
        upvoteButton.titleLabel?.textColor = .black
        upvoteButton.titleLabel?.textAlignment = .center
        upvoteButton.setTitle("0", for: .normal)
        upvoteButton.setTitleColor(.black, for: .normal)
        
        // Button target action
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(upvoteButtonHandler)
        )
        upvoteButton.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    @objc fileprivate func upvoteButtonHandler() {
        // TODO: Firebase request to upvote
        upvoteButton.setTitle("\(1)", for: .normal)
    }
    
}
