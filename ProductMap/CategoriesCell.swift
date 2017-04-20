//
//  CategoriesCell.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/13/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel?
    
    @IBOutlet weak var icon: UIImage?
    
    func configure(with category: Category) {
        
        self.title?.text = category.title
        self.icon = category.icon
        
        // Default background color
        backgroundColor = .green
        layer.cornerRadius = frame.size.width / 2
        layer.masksToBounds = true
        isUserInteractionEnabled = true
    }

}
