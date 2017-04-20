//
//  SearchBarView.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/13/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//


import UIKit

protocol SearchViewDelegate: class {
    func dismissSearchView()
}


class SearchView: UIView {
    
    weak var searchViewDelegate: SearchViewDelegate?
    var cancelSearchButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup
        /*
        backgroundColor = UIColor(
            colorLiteralRed: 255/255,
            green: 252/255,
            blue: 236/255,
            alpha: 1
        )
        */
        backgroundColor = .white
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func showSearchView() {
        // Setup button
        setupCancelSearchButton()
        
        guard let keyWindow = keyWindow?.frame else {
            return
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseIn, animations: { 
            // Show search view when editting
            self.frame.size.height = keyWindow.height
        })
        
    }
    
    
    func dismissSearchView() {
        UIView.animate(withDuration: 0.3, animations: {
            // Create search view when editting
            self.frame.size.height = 0
            // Hide cancel button
            self.cancelSearchButton.removeFromSuperview()
        })
        
    }
    
    
    fileprivate func setupCancelSearchButton() {
        self.addSubview(cancelSearchButton)
        
        guard let windowFrame = keyWindow?.frame else {
            return
        }
        
        let buttonFrame = CGRect(
            x: windowFrame.width * 0.001,
            y: windowFrame.width * 0.03,
            width: windowFrame.size.width * 0.2,
            height: windowFrame.size.width * 0.2
        )
        cancelSearchButton.frame = buttonFrame
        
        cancelSearchButton.layer.shadowOffset = CGSize(
            width: 0,
            height: 0
        )
        cancelSearchButton.layer.shadowRadius = 1
        cancelSearchButton.layer.shadowOpacity = 0.2
        cancelSearchButton.clipsToBounds = false
        
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(cancelSearchButtonHandler)
        )
        cancelSearchButton.addGestureRecognizer(tapGestureRecognizer)
        cancelSearchButton.setImage(
            UIImage(named: "CloseButton"),
            for: .normal
        )
        
    }
    
    
    @objc fileprivate func cancelSearchButtonHandler() {
        searchViewDelegate?.dismissSearchView()
    }
    
}
