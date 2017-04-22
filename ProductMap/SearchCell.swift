//
//  SearchCell.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/18/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 0)
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func configure(with: Product) {
        
        
    }
    
}
