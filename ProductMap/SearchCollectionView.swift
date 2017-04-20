//
//  SearchCollectionView.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/16/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import Firebase

class SearchCollectionView: UICollectionView {
    
    public let reusableCellID = "SearchCell"
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        backgroundColor = .white
        isScrollEnabled = true
        isUserInteractionEnabled = true
        alwaysBounceVertical = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Dipshit")
    }
    
    func setupSearchCollectionView() {
        

    }
    
    
    func showSearchCollectionView() {
        
        guard let keyWindow = keyWindow?.frame else {
            return
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            // Show search view when editting
            self.frame.size.height = keyWindow.height
        })
        
    }
    
    
    func dismissSearchCollectionView() {
        
        UIView.animate(withDuration: 0.2, animations: {
            // Create search view when editting
            self.frame.size.height = 0
        }, completion: { (_) in
            
        })
        
    }
    
}
