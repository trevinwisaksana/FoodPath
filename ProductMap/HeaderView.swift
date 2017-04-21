//
//  HeaderView.swift
//  ProductMap
//
//  Created by Bob De Kort on 4/20/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup
        backgroundColor = .blue
        setupViews()
    }
    
    func setupViews(){
        addSubview(titleLabel)
        addSubview(cityLabel)
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        
    }
    
    public func setupHeaderView(){
        guard let windowFrame = keyWindow?.frame else {
            return
        }
        
        let frame = CGRect(
            x: 0,
            y: windowFrame.height * 0.35,
            width: windowFrame.width,
            height: windowFrame.height * 0.1
        )
        self.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
