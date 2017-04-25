//
//  CategoriesCell.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/13/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    private var title = UILabel()
    private var icon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupIcon()
        
        isUserInteractionEnabled = true
    }
 
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with category: Category) {
        
        self.title.text = category.title
        self.icon.image = category.icon!
        
        // Default background color
        backgroundColor = .green
        layer.cornerRadius = frame.size.width / 2
        layer.masksToBounds = true
        isUserInteractionEnabled = true
    }
    
    
    fileprivate func setupTitle() {
        
        
    }
    
    
    fileprivate func setupIcon() {
        self.addSubview(icon)
        
        let iconFrame = CGRect(
            x: -2,
            y: -1,
            width: 90,
            height: 90
        )
        icon.frame = iconFrame
        // icon.center = self.center
        
    }

}
