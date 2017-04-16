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
        
        guard let collectionView = collectionView as? CategoriesCollectionView else {
            fatalError("Collection View does not exist")
        }
        
        let id = collectionView.reusableCellID
        let category = listOfCategories[indexPath.row]
        
        collectionView.register(
            CategoryCell.self,
            forCellWithReuseIdentifier: id
        )
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: id,
            for: indexPath) as! CategoryCell
    
        // Configure the cell
        cell.configure(with: category)
        
        return cell
    }
    
    
}
