//
//  ProductDescriptionView.swift
//  ProductMap
//
//  Created by Bob De Kort on 4/22/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

class ProductDescriptionView: UIView {

    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Description"
        lbl.font = UIFont.systemFont(ofSize: 16)
        return lbl
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = ""
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        addSubview(titleLabel)
        addSubview(dividerLineView)
        addSubview(textView)
        
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        
        dividerLineView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        dividerLineView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        dividerLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        textView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        textView.topAnchor.constraint(equalTo: dividerLineView.bottomAnchor, constant: 5).isActive = true
        
//        addConstraintsWithFormat("H:|-14-[v0]-8-|", views: titleLabel)
//        addConstraintsWithFormat("H:|-14-[v0]-14-|", views: dividerLineView)
//        addConstraintsWithFormat("H:|-8-[v0]-20-|", views: textView)
//        
//        addConstraintsWithFormat("V:|-4-[v0]-4-[v1(1)]-4-[v2]|", views: titleLabel, dividerLineView, textView)
    }
    
    public func setupDescriptionView(){
        guard let windowFrame = keyWindow?.frame else {
            return
        }
        
        let frame = CGRect(
            x: 0,
            y: windowFrame.height * 0.45,
            width: windowFrame.width,
            height: windowFrame.height * 0.3
        )
        self.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
