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
        // Check which is the collection view
        if collectionView == self.categoriesCollectionView {
            return self.listOfCategories.count
        } else {
            return self.listOfProducts.count
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Check which is the collection view
        if collectionView == self.categoriesCollectionView {
            
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

        } else {
            
            guard let collectionView = collectionView as? SearchCollectionView else {
                fatalError("Collection View does not exist")
            }
            
            let id = collectionView.reusableCellID
            let product = listOfProducts[indexPath.row]
            
            collectionView.register(
                SearchCell.self,
                forCellWithReuseIdentifier: id
            )
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: id,
                for: indexPath) as! SearchCell
            
            // Configure the properties of the cell
            cell.configure(with: product)
            
            return cell
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    
    func updateSearchCollectionView(products: [Product]) {
        // Append the products downloaded
        listOfProducts = products
        // Refresh the collection view
        searchCollectionView.reloadData()
    }
    
    
}
