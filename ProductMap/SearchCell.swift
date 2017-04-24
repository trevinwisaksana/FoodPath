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
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 0)
        isUserInteractionEnabled = true
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
        productUpvoteLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 20).isActive = true
        productUpvoteLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        productUpvoteLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        let labelFrame = CGRect(
            x: self.frame.width * 0.8,
            y: self.frame.height * 0.02,
            width: self.frame.width * 0.2,
            height: self.frame.height
        )
        let labelFont = UIFont(
            name: "Avenir",
            size: 30
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
    }
    
}
