//
//  TopSpaceView.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/17/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import SDWebImage

protocol TopSpaceViewDelegate: class {
    func dismissViewController()
}

class TopSpaceView: UIView {
    
    private let dismissButton = UIButton()
    weak var delegate: TopSpaceViewDelegate!
    private let imageView = UIImageView()
    
    var product: Product?{
        didSet{
            if let urlString = product?.imageUrl {
                if let url = URL(string: urlString) {
                    imageView.sd_setImage(with: url)
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup
        backgroundColor = .blue
        setupImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupImageView(){
        addSubview(imageView)
        imageView.frame = self.frame
        let url1 = URL(string: "https://lh5.googleusercontent.com/-4KFXQTbmqco/V6wlexPoNcI/AAAAAAAAUGA/oOCq2NXrbsAOK08hWieIkhylwv0nu0KEwCLIB/w400-k/")
        imageView.sd_setImage(with: url1)
        
        let gradientView = GradientView(frame: CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: (self.frame.height * 0.4)))
        gradientView.topColor = UIColor.black
        gradientView.bottomColor = UIColor.clear
        gradientView.angle = 90.0
        addSubview(gradientView)
    }
    
    /// Setup the frame size
    public func setupTopSpaceView() {
        
        guard let windowFrame = keyWindow?.frame else {
            return
        }
        
        let frame = CGRect(
            x: 0,
            y: 0,
            width: windowFrame.width,
            height: windowFrame.height * 0.35
        )
        self.frame = frame
    }
    
    
    func setupDismissButton() {
        self.addSubview(dismissButton)
        // Frame setup
        let frame = CGRect(
            x: self.frame.width * 0.03,
            y: self.frame.width * 0.06,
            width: self.frame.size.width * 0.1,
            height: self.frame.size.width * 0.1
        )
        dismissButton.frame = frame
        
        
        // Custom tap gesture setup
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissButtonHandler)
        )
        dismissButton.addGestureRecognizer(tapGestureRecognizer)
        
        // Miscellaneous setup
        dismissButton.layer.cornerRadius = 10
        dismissButton.setImage(UIImage(named: "CloseButton"), for: .normal)
        dismissButton.isUserInteractionEnabled = true
    }
    
    
    @objc fileprivate func dismissButtonHandler() {
        delegate.dismissViewController()
    }
    
    
}
