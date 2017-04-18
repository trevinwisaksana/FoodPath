//
//  ProductViewController.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/16/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController, TopSpaceViewDelegate {
    
    private var topSpaceView = TopSpaceView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Top space view
        setupTopSpaceView()
        
        
        // Miscellaneous setup
        self.view.backgroundColor = .white
    }
    
    
    fileprivate func setupTopSpaceView() {
        self.view.addSubview(topSpaceView)
        topSpaceView.delegate = self
        topSpaceView.setupTopSpaceView()
        topSpaceView.setupDismissButton()
    }
    
    
    func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
