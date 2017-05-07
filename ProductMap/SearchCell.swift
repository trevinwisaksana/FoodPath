//
//  SearchCell.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/18/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit


class SearchCell: UICollectionViewCell {
    
    // UIElements
    private var productTitleLabel = UILabel()
    private var productCityLabel = UILabel()
    private var productUpvoteLabel = UILabel()
    private var productLabelContainer = UIStackView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Setup itself
        setupCell()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setupCell() {
        backgroundColor = .white
        
        // Setup product title label
        setupProductTitleLabel()
        // Setup product city label
        setupProductCityLabel()
        // Setup label
        setupProductUpvoteLabel()
        // setup container
        setupProductLabelContainer()
    }
    
    
    public func configure(with product: Product) {
        productCityLabel.text = "in \(product.city)"
        productTitleLabel.text = product.title
        
        
        guard let upvoteCount = product.upvoteCount else {
            return
        }
        productUpvoteLabel.text = "\(upvoteCount)"
    }
    
    
    fileprivate func setupProductTitleLabel() {
        self.addSubview(productTitleLabel)
        productTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    
        guard let windowFrame = keyWindow?.frame else {
            return
        }
        
        let labelFrame = CGRect(
            x: self.frame.width * 0.05,
            y: self.frame.height * 0.15,
            width: windowFrame.width * 0.6,
            height: self.frame.height * 0.5
        )
        let labelFont = UIFont(
            name: "Avenir",
            size: windowFrame.height * 0.032
        )
        productTitleLabel.frame = labelFrame
        productTitleLabel.font = labelFont
    }
    
    
    fileprivate func setupProductCityLabel() {
        self.addSubview(productCityLabel)
        productCityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        guard let windowFrame = keyWindow?.frame else {
            return
        }
        
        let labelFrame = CGRect(
            x: self.frame.width * 0.05,
            y: self.frame.height * 0.6,
            width: windowFrame.width * 0.6,
            height: windowFrame.height * 0.03
        )
        let labelFont = UIFont(
            name: "Avenir",
            size: windowFrame.height * 0.025
        )
        productCityLabel.frame = labelFrame
        productCityLabel.font = labelFont
        productCityLabel.adjustsFontSizeToFitWidth = true
    }
    
    
    fileprivate func setupProductUpvoteLabel() {
        self.addSubview(productUpvoteLabel)
        
        guard let windowFrame = keyWindow?.frame else {
            return
        }
        
        let labelFrame = CGRect(
            x: self.frame.width * 0.75,
            y: self.frame.height * 0.105,
            width: self.frame.width * 0.18,
            height: self.frame.width * 0.18
        )
        let labelFont = UIFont(
            name: "Avenir",
            size: windowFrame.height * 0.04
        )
        productUpvoteLabel.frame = labelFrame
        productUpvoteLabel.backgroundColor = UIColor(
            colorLiteralRed: 248/255,
            green: 211/255,
            blue: 33/255,
            alpha: 1
        )
        
        productUpvoteLabel.font = labelFont
        productUpvoteLabel.textAlignment = .center
        productUpvoteLabel.clipsToBounds = true
        productUpvoteLabel.layer.cornerRadius = productUpvoteLabel.frame.width / 2
        
        // Auto layout
        productUpvoteLabel.translatesAutoresizingMaskIntoConstraints = false
        productUpvoteLabel.widthAnchor.constraint(
            equalToConstant: windowFrame.width * 0.18
            ).isActive = true
        
        productUpvoteLabel.heightAnchor.constraint(
            equalTo: productUpvoteLabel.widthAnchor
            ).isActive = true
        
        productUpvoteLabel.rightAnchor.constraint(
            equalTo: rightAnchor,
            constant: -8
            ).isActive = true
        
        productUpvoteLabel.topAnchor.constraint(
            equalTo: topAnchor,
            constant: 4
            ).isActive = true
 
    }
    
    
    fileprivate func setupProductLabelContainer() {
        self.addSubview(productLabelContainer)
        
        productLabelContainer.axis = .vertical
        productLabelContainer.distribution = .equalSpacing
        productLabelContainer.alignment = .leading
        productLabelContainer.spacing = 0
        
        // Setup product city label
        setupProductCityLabel()
        // Setup product name button
        setupProductTitleLabel()
        
        productLabelContainer.addArrangedSubview(productTitleLabel)
        productLabelContainer.addArrangedSubview(productCityLabel)
        
        productLabelContainer.leftAnchor.constraint(
            equalTo: leftAnchor,
            constant: 20
            ).isActive = true
        productLabelContainer.centerYAnchor.constraint(
            equalTo: self.centerYAnchor,
            constant: 0
            ).isActive = true
        productLabelContainer.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
