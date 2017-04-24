//
//  CustomCalloutView.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/16/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

class CustomCalloutView: UIView {
    
    // MARK: - UIElements
    private var productNameLabel = UILabel()
    // Label for city
    private var productCityLabel = UILabel()
    // Upvote label
    private var upvoteTitleLabel = UILabel()
    // Button for upvoting
    private var upvoteButton = UIButton()
    // Selected product ID
    private var productID: String?
    // Product count
    private var upvoteCount: Int = 0
    
    private var product: Product? {
        didSet{
            if let product = product {
                // Update UI elements
                productNameLabel.text = product.title
                productCityLabel.text = product.city
                productID = product.id
                
                guard let productUpvoteCount = product.upvoteCount else {
                    fatalError()
                }
                
                upvoteCount = productUpvoteCount
                upvoteButton.setTitle("\(productUpvoteCount)", for: .normal)
                
                if upvoteCount > 1 {
                    upvoteTitleLabel.text = "Upvotes"
                } else {
                    upvoteTitleLabel.text = "Upvote"
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Setup tap gesture to present ProductViewController
        setupTapGesture()
        // Setup productNameLabel
        setupProductNameLabel()
        // Setup upvote button
        setupUpvoteButton()
        // Setup product city label
        setupProductCityLabel()
        // Setup upvote title label
        setupUpvoteTitleLabel()
        
        // Miscellaneous setup
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 2)
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
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let vc = ProductDetailController(collectionViewLayout: layout)
        if let product = product {
            vc.product = product
        }
        mainViewController?.present(
            vc,
            animated: true,
            completion: nil
        )
    }
    
    
    fileprivate func setupProductNameLabel() {
        self.addSubview(productNameLabel)
        productNameLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        productNameLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        productNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        productNameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
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
            size: 28
        )
        productNameLabel.frame = labelFrame
        productNameLabel.font = labelFont
        productNameLabel.backgroundColor = .white
    }
    

    /// Encapsulates the CustomCalloutView UIElements to be configured
    ///
    /// - Parameter product: A custom Product model
    public func configure(with product: Product) {
        // Assigning properties
        self.product = product
    }

    fileprivate func setupProductCityLabel() {
        self.addSubview(productCityLabel)
        productCityLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        productCityLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        productCityLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    
        guard let keyWindow = keyWindow?.frame else {
            return
        }
        
        let labelFrame = CGRect(
            x: keyWindow.width * 0.05,
            y: keyWindow.width * 0.15,
            width: keyWindow.width * 0.6,
            height: keyWindow.height * 0.06
        )
        let labelFont = UIFont(
            name: "Avenir",
            size: 20
        )
        productCityLabel.frame = labelFrame
        productCityLabel.font = labelFont
        productCityLabel.backgroundColor = .white
        
    }
    
    
    fileprivate func setupUpvoteTitleLabel() {
        self.addSubview(upvoteTitleLabel)
        
        guard let windowFrame = keyWindow?.frame else {
            return
        }
        
        let labelFrame = CGRect(
            x: windowFrame.width * 0.75,
            y: windowFrame.width * 0.225,
            width: windowFrame.width * 0.6,
            height: windowFrame.height * 0.03
        )
        let labelFont = UIFont(
            name: "Avenir",
            size: 15
        )
        upvoteTitleLabel.frame = labelFrame
        upvoteTitleLabel.font = labelFont
        upvoteTitleLabel.backgroundColor = .white
        
    }
    
    
    fileprivate func setupUpvoteButton() {
        self.addSubview(upvoteButton)
        upvoteButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        upvoteButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        upvoteButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        
        // Window frame
        guard let windowFrame = keyWindow?.frame else {
            return
        }
        
        let buttonFrame = CGRect(
            x: windowFrame.width * 0.72,
            y: windowFrame.width * 0.03,
            width: windowFrame.width * 0.19,
            height: windowFrame.width * 0.19
        )
        upvoteButton.frame = buttonFrame
        upvoteButton.backgroundColor = UIColor(
            colorLiteralRed: 248/255,
            green: 211/255,
            blue: 33/255,
            alpha: 1
        )
        upvoteButton.layer.cornerRadius = upvoteButton.frame.width / 2
        
        // Button label
        let buttonFont = UIFont(name: "Avenir", size: 35)
        upvoteButton.titleLabel?.font = buttonFont
        upvoteButton.titleLabel?.textColor = .white
        upvoteButton.titleLabel?.textAlignment = .center
        upvoteButton.setTitle("\(upvoteCount)", for: .normal)
        upvoteButton.setTitleColor(.black, for: .normal)
        
        // Button target action
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(upvoteButtonHandler)
        )
        upvoteButton.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc fileprivate func upvoteButtonHandler() {
        
        guard let productID = productID else {
            return
        }
        
        upvoteCount += 1
        
        upvoteButton.setTitle("\(upvoteCount)", for: .normal)
        
        APIClient.sharedInstance.upvoteRequest(
            with: productID,
            city: "San Francisco"
        )
        
    }
    
}
