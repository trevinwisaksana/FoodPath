//
//  Category.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/15/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

struct Category {
    
    var title: String
    var icon: UIImage?
    
    /* 
     Uses failable initializer to assure each
     category has a title and an icon
     */
    init?(title: String, icon: UIImage) {
        self.title = title
        self.icon = icon
    }
}
