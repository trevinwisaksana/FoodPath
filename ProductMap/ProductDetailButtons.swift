//
//  ProductDetailButtons.swift
//  ProductMap
//
//  Created by Bob De Kort on 4/23/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import Foundation
import UIKit

class ProductDetailButtons: BaseCell {
    
    let navigationButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Get directions", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return btn
    }()
    
    let contactButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Contact", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return btn
    }()
    
    let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupViews() {
        
        let stackView = UIStackView(arrangedSubviews: [navigationButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        addSubview(dividerLine)
        
        dividerLine.topAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        dividerLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        dividerLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        dividerLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
