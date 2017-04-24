//
//  SearchBarView.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/13/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit


class SearchView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup
        backgroundColor = UIColor(
            colorLiteralRed: 242/255,
            green: 237/255,
            blue: 217/255,
            alpha: 1
        )
    
        isUserInteractionEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setup searchView
    public func setupSearchView(_ viewController: UIViewController) {
        viewController.view.addSubview(self)
        
        let width = viewController.view.frame.width
        let frame = CGRect(x: viewController.view.frame.origin.x,
                           y: viewController.view.frame.origin.y,
                           width: width,
                           height: 0)
        self.frame = frame
        
    }
    
    
    public func showSearchView() {
        
        guard let keyWindow = keyWindow?.frame else {
            return
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseIn, animations: { 
            // Show search view when editting
            self.frame.size.height = keyWindow.height
        })
        
    }
    
    
    public func dismissSearchView() {
        UIView.animate(withDuration: 0.3, animations: {
            // Change the height to 0
            self.frame.size.height = 0
        })
    }
    
}
