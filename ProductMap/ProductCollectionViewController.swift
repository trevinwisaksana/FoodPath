//
//  ProductController.swift
//  ProductMap
//
//  Created by Bob De Kort on 4/22/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import MapKit

class ProductDetailCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, TopSpaceViewDelegate {
    
    // MARK: Fileprivate Variables
    
    fileprivate let reuseIdentifier = "Cell"
    fileprivate let descriptionId = "descriptionId"
    fileprivate let imageCellId = "imageCellId"
    fileprivate let titleCellId = "titleCellId"
    fileprivate let buttonsCellId = "buttonsCellId"
    
    // MARK: Variables
    
    let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(
            activityIndicatorStyle: UIActivityIndicatorViewStyle.gray
        )
        return ai
    }()
    
    var product: Product?
    
    // MARK: ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        // Register cell classes
        collectionView?.register(
            ImageScrollerCollectionViewCell.self,
            forCellWithReuseIdentifier: imageCellId
        )
        collectionView?.register(
            ProductDescriptionCell.self,
            forCellWithReuseIdentifier: descriptionId
        )
        collectionView?.register(
            TitleCollectionViewCell.self,
            forCellWithReuseIdentifier: titleCellId
        )
        collectionView?.register(
            ProductDetailButtons.self,
            forCellWithReuseIdentifier: buttonsCellId
        )
        
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        
        setupActivityMonitor()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
    
    
    /// Used to open either Google Maps or Apple Maps when looking for directions
    @objc fileprivate func handleDirections(){
        
        let googleMapsURL = URL(string:"comgooglemaps://")
        
        if let product = product {
            
            let latitude = product.coordinate.latitude
            let longitude = product.coordinate.longitude
            
            if UIApplication.shared.canOpenURL(googleMapsURL!) {
                let url = URL(string:
                    "comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=walking")!
                
                UIApplication.shared.open(url,
                                          options: [:],
                                          completionHandler: nil)
            } else {
                
                let latitude:CLLocationDegrees =  CLLocationDegrees(product.coordinate.latitude)
                let longitude:CLLocationDegrees =  CLLocationDegrees(product.coordinate.longitude)
                
                let regionDistance:CLLocationDistance = 10000
                let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
                let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
                let options = [
                    MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                    MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
                ]
                let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
                let mapItem = MKMapItem(placemark: placemark)
                mapItem.name = product.title
                mapItem.openInMaps(launchOptions: options)
            }
        }
    }
    
    
    @objc fileprivate func handleContact() {
        // Previously used for testing
        let hardcodedNumber = "///////////////////"
        
        guard let number = URL(string: "telprompt://" + hardcodedNumber) else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    
    
    fileprivate func setupActivityMonitor(){
        activityIndicator.center = self.view.center
        view.addSubview(activityIndicator)
    }
    
    
    func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        // With map
        switch indexPath.item {
            
        case 0: // Image scroller
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: imageCellId,
                for: indexPath) as! ImageScrollerCollectionViewCell
            
            if let url = product?.imageUrl {
                cell.imagesUrls = [url]
            }
            
            cell.delegate = self
            
            return cell
            
        case 1: // Title and city Label cell
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: titleCellId,
                for: indexPath) as! TitleCollectionViewCell
            
            if let product = product {
                cell.configure(with: product)
            }
            
            return cell
            
        case 2: // Navigation and contact buttons
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: buttonsCellId, for: indexPath) as! ProductDetailButtons
            
            cell.navigationButton.addTarget(self, action: #selector(handleDirections), for: .touchUpInside)
            cell.contactButton.addTarget(self, action: #selector(handleContact), for: .touchUpInside)
            
            return cell
            
        case 3: // Description Cell
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptionId, for: indexPath) as! ProductDescriptionCell
            cell.textView.text = product?.productDescription
            
            return cell
        default:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        let height = view.frame.height * 0.315
        
        switch indexPath.item {
        case 0: // Image Scroller
            return CGSize(
                width: width,
                height: height
            )
        case 1: // Title and city label
            return CGSize(
                width: view.frame.width,
                height: height * 0.5
            )
        case 2: // Navigation and contact Button
            return CGSize(
                width: width,
                height: 40
            )
        case 3: // Description
            let dummySize = CGSize(
                width: width - 16,
                height: 1000
            )
            
            let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
            let rect = descriptionAttributedText().boundingRect(
                with: dummySize,
                options: options,
                context: nil
            )
            
            return CGSize(
                width: width,
                height: rect.height + 60
            )
            
        default:
            return CGSize(
                width: width,
                height: 0
            )
        }
    }
    
    
    fileprivate func descriptionAttributedText() -> NSAttributedString {
        
        let attributedText = NSMutableAttributedString(
            string: "",
            attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)]
        )
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        
        let range = NSMakeRange(
            0,
            attributedText.string.characters.count
        )
        
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: style, range: range)
        
        
        
        if let desc = product?.productDescription {
            
            let attributedString = NSAttributedString(
                string: desc,
                attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName: UIColor.darkGray]
            )
            
            attributedText.append(attributedString)
        }
        
        return attributedText
    }
}
