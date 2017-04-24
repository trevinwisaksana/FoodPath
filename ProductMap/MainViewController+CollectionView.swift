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
        return self.listOfProducts.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Check which is the collection view
     
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
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // If the collectionView is being scrolled, it resigns the keyboard
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if (offsetY > contentHeight - scrollView.frame.size.height) {
            searchTextField.resignFirstResponder()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Centers the screen on the coordinate
        let product = listOfProducts[indexPath.row]
        let productCoordinate = product.coordinate
        mainMapView.setCenter(
            productCoordinate,
            animated: true
        )
        // Dismisses the SearchView
        dismissSearchView()
        topBarContainer.hideCancelButton()
        // Clears text field
        searchTextField.text = ""
    }
    
    
    func updateSearchCollectionView(products: [Product]) {
        // Append the products downloaded
        listOfProducts = products
        // Refresh the collection view
        searchCollectionView.reloadData()
    }

    
}
