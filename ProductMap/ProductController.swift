//
//  ProductController.swift
//  ProductMap
//
//  Created by Bob De Kort on 4/22/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

class ProductDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: Fileprivate Variables
    
    fileprivate let reuseIdentifier = "Cell"
    fileprivate let descriptionId = "descriptionId"
    fileprivate let imageCellId = "imageCellId"
    fileprivate let titleCellId = "titleCellId"
    
    // MARK: Variables
    
    let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        return ai
    }()
    
    var product: Product?
    
    // MARK: ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .white
        // Register cell classes
        collectionView?.register(ImageScrollerCollectionViewCell.self, forCellWithReuseIdentifier: imageCellId)
        collectionView?.register(ProductDescriptionCell.self, forCellWithReuseIdentifier: descriptionId)
        collectionView?.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: titleCellId)
        
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        
        setupActivityMonitor()
    }
    
    func setupActivityMonitor(){
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        // With map
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCellId, for: indexPath) as! ImageScrollerCollectionViewCell
            if let url = product?.imageUrl {
                cell.imagesUrls = [url]
            }
            
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: titleCellId, for: indexPath) as! TitleCollectionViewCell
            
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptionId, for: indexPath) as! ProductDescriptionCell
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            return cell
        }
    }
    
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
////        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! TourDetailHeader
////        header.tour = tour
////        header.parent = self
////        return header
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.item {
        case 0:
            return CGSize(width: view.frame.width, height: 200)
        case 1:
            return CGSize(width: view.frame.width, height: 50)
        case 2:
            return CGSize(width: view.frame.width, height: 200)
        default:
            return CGSize(width: view.frame.width, height: 170)
        }
    }
}
