//
//  CategoriesCollectionView.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/13/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//


import UIKit
import MapKit

class CategoriesCollectionView: UICollectionView {
    
    public let reusableCellID = "CategoryCell"
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        
        // Default background
        backgroundColor = .white
        layer.cornerRadius = 15
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
