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
    private var headerView = HeaderView()
    
    var product: Product? {
        didSet {
            topSpaceView.product = product
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Top space view
        setupTopSpaceView()
        
        setupHeaderView()
        
        // Miscellaneous setup
        self.view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
    
    
    fileprivate func setupTopSpaceView() {
        self.view.addSubview(topSpaceView)
        topSpaceView.delegate = self
        topSpaceView.setupTopSpaceView()
        topSpaceView.setupImageView()
        topSpaceView.setupDismissButton()
    }
    
    fileprivate func setupHeaderView() {
        self.view.addSubview(headerView)
        headerView.setupHeaderView()
        
    }
    
    
    func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
