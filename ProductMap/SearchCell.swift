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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Setup product title label
        setupProductTitleLabel()
        // Setup product city label
        setupProductCityLabel()
        // Setup label
        setupProductUpvoteLabel()
        // Setup itself
        setupCell()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setupCell() {
        backgroundColor = .white
    }
    
    
    public func configure(with product: Product) {
        productCityLabel.text = product.city
        productTitleLabel.text = product.title
        
        
        guard let upvoteCount = product.upvoteCount else {
            return
        }
        productUpvoteLabel.text = "\(upvoteCount)"
    }
    
    
    fileprivate func setupProductTitleLabel() {
        self.addSubview(productTitleLabel)
        productTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        productTitleLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        productTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
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
            size: 20
        )
        productTitleLabel.frame = labelFrame
        productTitleLabel.font = labelFont
    }
    
    
    fileprivate func setupProductCityLabel() {
        self.addSubview(productCityLabel)
        productCityLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        productCityLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        productCityLabel.topAnchor.constraint(equalTo: productTitleLabel.bottomAnchor, constant: -5).isActive = true
        // productCityLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5).isActive = true
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
            size: 15
        )
        productCityLabel.frame = labelFrame
        productCityLabel.font = labelFont
        productCityLabel.adjustsFontSizeToFitWidth = true
    }
    
    
    fileprivate func setupProductUpvoteLabel() {
        self.addSubview(productUpvoteLabel)
        
        let labelFrame = CGRect(
            x: self.frame.width * 0.75,
            y: self.frame.height * 0.105,
            width: self.frame.width * 0.18,
            height: self.frame.width * 0.18
        )
        let labelFont = UIFont(
            name: "Avenir",
            size: 25
        )
        productUpvoteLabel.frame = labelFrame
        productUpvoteLabel.backgroundColor = UIColor(
            colorLiteralRed: 166/255,
            green: 159/255,
            blue: 135/255,
            alpha: 1
        )
        productUpvoteLabel.font = labelFont
        productUpvoteLabel.textAlignment = .center
        productUpvoteLabel.clipsToBounds = true
        productUpvoteLabel.layer.cornerRadius = productUpvoteLabel.frame.width / 2
        
        // Auto layout
        /*
        productUpvoteLabel.translatesAutoresizingMaskIntoConstraints = false
        productUpvoteLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        productUpvoteLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        productUpvoteLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        productUpvoteLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        productUpvoteLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        */
        
    }
    
}
