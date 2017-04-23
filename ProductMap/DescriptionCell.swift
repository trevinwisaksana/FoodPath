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
        return lbl
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "SAMPLE DESCRIPTION"
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(titleLabel)
        addSubview(dividerLineView)
        addSubview(textView)
        
        addConstraintsWithFormat("H:|-10-[v0]-8-|", views: titleLabel)
        addConstraintsWithFormat("H:|-10-[v0]-10-|", views: dividerLineView)
        addConstraintsWithFormat("H:|-8-[v0]-20-|", views: textView)
        
        addConstraintsWithFormat("V:|-4-[v0]-4-[v1(1)]-4-[v2]|", views: titleLabel, dividerLineView, textView)
    }   
}
