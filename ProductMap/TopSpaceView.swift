//
//  TopSpaceView.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/17/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit


protocol TopSpaceViewDelegate: class {
    func dismissViewController()
}


class TopSpaceView: UIView {
    
    private let dismissButton = UIButton()
    weak var delegate: TopSpaceViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup
        backgroundColor = .blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            x: self.frame.width * 0.05,
            y: self.frame.width * 0.08,
            width: self.frame.size.width * 0.1,
            height: self.frame.size.width * 0.1
        )
        dismissButton.frame = frame
        dismissButton.layer.cornerRadius = 10
        // Font setup
        let font = UIFont(
            name: "Avenir",
            size: 14
        )
        dismissButton.titleLabel?.font = font
        dismissButton.titleLabel?.text = "X"
        
        // Custom tap gesture setup
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissButtonHandler)
        )
        dismissButton.addGestureRecognizer(tapGestureRecognizer)
        
        // Miscellaneous setup
        dismissButton.backgroundColor = .yellow
        dismissButton.isUserInteractionEnabled = true
        
    }
    
    
    @objc fileprivate func dismissButtonHandler() {
        delegate.dismissViewController()
    }
    
    
}
