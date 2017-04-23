//
//  TitleCell.swift
//  ProductMap
//
//  Created by Bob De Kort on 4/22/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import Foundation
import UIKit

class TitleCollectionViewCell: BaseCell {
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Test title"
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let cityLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "San Francisco"
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override func setupViews(){
        
        self.backgroundColor = .blue
        
        addSubview(titleLabel)
        addSubview(cityLabel)
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        
        cityLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        cityLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
    }
}
