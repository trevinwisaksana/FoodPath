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
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "bla bla bla bla"
        tv.font = UIFont.systemFont(ofSize: 14)
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
    
    var descriptionString: String? {
        didSet{
            textView.text = descriptionString
            adjustFrameToDescription(description: descriptionString!)
        }
    }
    
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
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        dividerLineView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        dividerLineView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        dividerLineView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        dividerLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        textView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        textView.topAnchor.constraint(equalTo: dividerLineView.bottomAnchor, constant: 5).isActive = true
        textView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
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
    
    fileprivate func adjustFrameToDescription(description: String){
        let height = description.height(withConstrainedWidth: textView.frame.width, font: UIFont.systemFont(ofSize: 14))
        var frame = self.frame
        frame.size.height = 50 + height
        self.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
