//
//  TitleCell.swift
//  ProductMap
//
//  Created by Bob De Kort on 4/22/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//


import UIKit


class TitleCollectionViewCell: BaseCell {
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let cityLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var product: Product? {
        didSet{
            if let product = product {
                self.titleLabel.text = product.title
                self.cityLabel.text = product.city
                self.productID = product.id
                
                guard let productUpvoteCount = product.upvoteCount else {
                    return
                }
                
                upvoteCount = productUpvoteCount
                upvoteButton.setTitle("\(productUpvoteCount)", for: .normal)
                
                if upvoteCount > 1 {
                    upvoteTitleLabel.text = "Upvotes"
                } else {
                    upvoteTitleLabel.text = "Upvote"
                }
            }
        }
    }
    
    
    // Button for upvoting
    private var upvoteButton = UIButton()
    // Upvote label
    private var upvoteTitleLabel = UILabel()
    // Stack views
    private var upvoteContainer = UIStackView()
    private var productLabelContainer = UIStackView()
    // Product count
    private var upvoteCount: Int = 0
    // Selected product ID
    private var productID: String?
    
    
    override func setupViews() {
        
        self.backgroundColor = UIColor(
            red: 66/255,
            green: 133/255,
            blue: 255/255,
            alpha: 1
        )
        
        setupUpvoteContainer()
        setupProductLabelContainer()
    }
    
    
    fileprivate func setupUpvoteTitleLabel() {
        self.addSubview(upvoteTitleLabel)
        
        guard let windowFrame = keyWindow?.frame else {
            return
        }
        
        let labelFrame = CGRect(
            x: windowFrame.width * 0.75,
            y: windowFrame.width * 0.225,
            width: windowFrame.width * 0.6,
            height: windowFrame.height * 0.03
        )
        let labelFont = UIFont(
            name: "Avenir",
            size: windowFrame.height * 0.025
        )
        upvoteTitleLabel.frame = labelFrame
        upvoteTitleLabel.textColor = .white
        upvoteTitleLabel.font = labelFont
        upvoteTitleLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    
    fileprivate func setupUpvoteContainer() {
        self.addSubview(upvoteContainer)
        
        upvoteContainer.axis  = .vertical
        upvoteContainer.distribution  = .equalSpacing
        upvoteContainer.alignment = .center
        upvoteContainer.spacing   = 0
        
        // Setup upvote title label
        setupUpvoteTitleLabel()
        // Setup upvote button
        setupUpvoteButton()
        
        upvoteContainer.addArrangedSubview(upvoteButton)
        upvoteContainer.addArrangedSubview(upvoteTitleLabel)
        
        upvoteContainer.rightAnchor.constraint(
            equalTo: rightAnchor,
            constant: -25
            ).isActive = true
        upvoteContainer.centerYAnchor.constraint(
            equalTo: self.centerYAnchor,
            constant: 0
            ).isActive = true
        upvoteContainer.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    fileprivate func setupUpvoteButton() {
        self.addSubview(upvoteButton)
        
        
        // Window frame
        guard let windowFrame = keyWindow?.frame else {
            return
        }
        
        let buttonFrame = CGRect(
            x: windowFrame.width * 0.72,
            y: windowFrame.width * 0.03,
            width: windowFrame.width * 0.19,
            height: windowFrame.width * 0.19
        )
        upvoteButton.frame = buttonFrame
        upvoteButton.backgroundColor = UIColor(
            colorLiteralRed: 248/255,
            green: 211/255,
            blue: 33/255,
            alpha: 1
        )
        upvoteButton.layer.cornerRadius = upvoteButton.frame.width / 2
        
        // Button label
        let buttonFont = UIFont(
            name: "Avenir",
            size: windowFrame.height * 0.05
        )
        upvoteButton.titleLabel?.font = buttonFont
        upvoteButton.titleLabel?.textColor = .white
        upvoteButton.titleLabel?.textAlignment = .center
        upvoteButton.setTitle("\(upvoteCount)", for: .normal)
        upvoteButton.setTitleColor(.black, for: .normal)
        
        // Button target action
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(upvoteButtonHandler)
        )
        upvoteButton.addGestureRecognizer(tapGestureRecognizer)
        
        // Auto layout
        upvoteButton.widthAnchor.constraint(equalToConstant: windowFrame.width * 0.19).isActive = true
        upvoteButton.heightAnchor.constraint(equalToConstant: windowFrame.width * 0.19).isActive = true
        upvoteButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    fileprivate func setupProductLabelContainer() {
        self.addSubview(productLabelContainer)
        
        productLabelContainer.axis = .vertical
        productLabelContainer.distribution = .fillEqually
        productLabelContainer.alignment = .leading
        productLabelContainer.spacing = 5
        
        productLabelContainer.addArrangedSubview(titleLabel)
        productLabelContainer.addArrangedSubview(cityLabel)
        
        productLabelContainer.leftAnchor.constraint(
            equalTo: leftAnchor,
            constant: 20
            ).isActive = true
        productLabelContainer.centerYAnchor.constraint(
            equalTo: self.centerYAnchor,
            constant: 0
            ).isActive = true
        productLabelContainer.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    @objc fileprivate func upvoteButtonHandler() {
        
        guard let productID = productID else {
            return
        }
        
        upvoteCount += 1
        
        upvoteButton.setTitle("\(upvoteCount)", for: .normal)
        
        APIClient.sharedInstance.upvoteRequest(
            with: productID,
            city: "San Francisco"
        )
        
    }

}
