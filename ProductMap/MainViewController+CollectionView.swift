//
//  MainViewController+CVDataSource.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/13/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//


import UIKit

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listOfCategories.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let reuseIdentifier = "CategoryCell"
        
        collectionView.register(
            CategoryCell.self,
            forCellWithReuseIdentifier: reuseIdentifier
        )
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath) as! CategoryCell
        
        let category = listOfCategories[indexPath.row]
        
        // Configure the cell
        cell.configure(with: category)
        
        return cell
    }
    
    
}
