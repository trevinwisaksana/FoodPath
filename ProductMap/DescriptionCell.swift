//
//  DescriptionCell.swift
//  ProductMap
//
//  Created by Bob De Kort on 4/22/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import Foundation
import UIKit

class ProductDescriptionCell: BaseCell {
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Description"
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "SAMPLE DESCRIPTION"
        tv.font = UIFont.systemFont(ofSize: 15)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(titleLabel)
        addSubview(dividerLineView)
        addSubview(textView)
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        
        dividerLineView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        dividerLineView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        dividerLineView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        dividerLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        textView.topAnchor.constraint(equalTo: dividerLineView.bottomAnchor, constant: 0).isActive = true
        textView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        textView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
//        addConstraintsWithFormat("H:|-10-[v0]-8-|", views: titleLabel)
//        addConstraintsWithFormat("H:|-10-[v0]-10-|", views: dividerLineView)
//        addConstraintsWithFormat("H:|-8-[v0]-20-|", views: textView)
//        
//        addConstraintsWithFormat("V:|-4-[v0]-4-[v1(1)]-4-[v2]|", views: titleLabel, dividerLineView, textView)
    }   
}
