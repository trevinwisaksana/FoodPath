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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Setup product title label
        setupProductTitleLabel()
        // Setup product city label
        setupProductCityLabel()
        // Setup itself
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setupCell() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 0)
        isUserInteractionEnabled = true
    }
    
    
    public func configure(with product: Product) {
        productCityLabel.text = product.city
        productTitleLabel.text = product.title
        
    }
    
    
    fileprivate func setupProductTitleLabel() {
        self.addSubview(productTitleLabel)
        
        guard let windowFrame = keyWindow?.frame else {
            return
        }
        
        let labelFrame = CGRect(
            x: 20,
            y: 20,
            width: windowFrame.width * 0.6,
            height: windowFrame.height * 0.03
        )
        let labelFont = UIFont(
            name: "Avenir",
            size: 30
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
            x: 20,
            y: 40,
            width: windowFrame.width * 0.6,
            height: windowFrame.height * 0.03
        )
        let labelFont = UIFont(
            name: "Avenir",
            size: 15
        )
        productCityLabel.frame = labelFrame
        productCityLabel.font = labelFont
    }
    
}
