//
//  ImageScrollerCell.swift
//  ProductMap
//
//  Created by Bob De Kort on 4/22/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import ImageSlideshow
import AlamofireImage

class ImageScrollerCollectionViewCell: BaseCell {
    
    let imageShow: ImageSlideshow = {
        let view = ImageSlideshow()
        view.contentScaleMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dismissButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "CloseButton"), for: .normal)
        btn.isUserInteractionEnabled = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var imagesUrls: [String]? {
        didSet{
            if let urls = imagesUrls {
                let inputs = makeImageShowInputs(urls: urls)
                imageShow.setImageInputs(inputs)
            }
        }
    }
    
    weak var delegate: TopSpaceViewDelegate!
    
    override func setupViews() {
        self.backgroundColor = .black
        
        addSubview(imageShow)
        imageShow.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageShow.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageShow.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imageShow.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        addGradientView()
        
        addSubview(dismissButton)
        dismissButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        dismissButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        dismissButton.addTarget(self, action: #selector(handleDismissButton), for: .touchUpInside)
        setNoImageImage()
    }
    
    func handleDismissButton(){
        delegate.dismissViewController()
    }
    
    func addGradientView(){
        let gradientView = GradientView(frame: CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: (self.frame.height * 0.4)))
        gradientView.topColor = UIColor.black
        gradientView.bottomColor = UIColor.clear
        gradientView.angle = 90.0
        addSubview(gradientView)
    }
    
    func setNoImageImage(){
        imageShow.setImageInputs([AlamofireSource(urlString: "https://placeholdit.imgix.net/~text?txtsize=15&txt=No+Image+available&w=350&h=200&txttrack=0")!])
    }
    
    func makeImageShowInputs(urls: [String]) -> [InputSource]{
        var inputs: [InputSource] = []
        for i in urls {
            let input = AlamofireSource(urlString: i)
            if let input = input {
                inputs.append(input)
            }
        }
        return inputs
    }
}
