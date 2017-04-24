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
        lbl.text = ""
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let cityLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // Button for upvoting
    private var upvoteButton = UIButton()
    // Upvote label
    private var upvoteTitleLabel = UILabel()
    // Stack views
    private var upvoteContainer = UIStackView()
    // Product count
    private var upvoteCount: Int = 0
    // Selected product ID
    private var productID: String?
    
    
    override func setupViews() {
        
        self.backgroundColor = UIColor(red: 66/255, green: 133/255, blue: 255/255, alpha: 1)
        
        addSubview(titleLabel)
        addSubview(cityLabel)
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        
        cityLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        cityLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        
        // Setup upvote container
        setupUpvoteContainer()
        
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
        upvoteTitleLabel.font = labelFont
        // upvoteTitleLabel
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
            constant: -10
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
