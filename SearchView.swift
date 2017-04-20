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
        backgroundColor = .white
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func showSearchView() {
        
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
        }, completion: { (_) in
            
        })
        
    }
    
    
    fileprivate func setupCancelSearchButton() {
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(cancelSearchButtonHandler)
        )
        cancelSearchButton.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    
    @objc fileprivate func cancelSearchButtonHandler() {
        searchViewDelegate?.dismissSearchView()
    }
    
}
