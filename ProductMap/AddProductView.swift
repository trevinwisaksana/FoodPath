//
//  AddProductView.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/16/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import MapKit
import Firebase

enum addProductViewState {
    case cancelAdd, addProduct
}


protocol AddProductViewDelegate: class {
    
    /// Resizes the MainMapView
    func resizeMapView(for state: addProductViewState)
    
    /// Sends a Firebase request to create a Product model
    ///
    /// - Parameters:
    ///   - title: A String that stores the product name
    ///   - image: An image of the product
    func createProduct(
        title: String,
        description: String,
        image: UIImage
    )
}

class AddProductView: UIView, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let productNameTextField = UITextField()
    private let productDescriptionTextField = UITextField()
    
    private let instructionLabel = UILabel()
    private let pleaseInsertTitleLabel = UILabel()
    private let productDescriptionLabel = UILabel()
    
    private let cancelButton = UIButton()
    private let addProductButton = UIButton()
    
    private let addImageButton = UIButton()
    private var product: Product?
    
    weak var delegate: AddProductViewDelegate!
    var mainViewController: MainViewController?
    
    private var seletedImage: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Setup
        setupProductNameTextField()
        setupProductDescriptionTextField()
        setupCancelButton()
        setupAddProductButton()
        setupInstructionLabel()
        setupPleaseInsertLabel()
        setupProductDescriptionLabel()
        
        setupAddImageButton()
        
    
        // Miscellaneaous setup
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(
            width: 0,
            height: 2
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Product Name
    
    fileprivate func setupProductNameTextField() {
        self.addSubview(productNameTextField)
        
        // Label size
        let labelFrame = CGRect(
            x: frame.width * 0.096,
            y: frame.height * 0.225,
            width: frame.size.width * 0.9,
            height: frame.size.height * 0.1
        )
        productNameTextField.frame = labelFrame
        productNameTextField.layer.cornerRadius = 10
        
        let font = UIFont(
            name: "Avenir",
            size: frame.height * 0.04
        )
        productNameTextField.font = font
        productNameTextField.placeholder = "Product name"
        
        productNameTextField.backgroundColor = .white
        
    }
    
    fileprivate func setupPleaseInsertLabel() {
        self.addSubview(pleaseInsertTitleLabel)
        
        // Label size
        let labelFrame = CGRect(
            x: frame.width * 0.1,
            y: frame.height * 0.16,
            width: frame.size.width * 0.9,
            height: frame.size.height * 0.1
        )
        pleaseInsertTitleLabel.frame = labelFrame
        
        let font = UIFont(
            name: "Avenir",
            size: frame.height * 0.04
        )
        pleaseInsertTitleLabel.font = font
        pleaseInsertTitleLabel.text = "Please insert the product name"
        
    }
    
    // MARK: Product Description
    
    fileprivate func setupProductDescriptionTextField() {
        self.addSubview(productDescriptionTextField)
        // Label size
        let labelFrame = CGRect(
            x: frame.width * 0.096,
            y: frame.height * 0.385,
            width: frame.size.width * 0.9,
            height: frame.size.height * 0.1
        )
        productDescriptionTextField.frame = labelFrame
        productDescriptionTextField.layer.cornerRadius = 10
        
        let font = UIFont(
            name: "Avenir",
            size: frame.height * 0.04
        )
        productDescriptionTextField.font = font
        productDescriptionTextField.placeholder = "Product description"
        
        productDescriptionTextField.backgroundColor = .white
        
    }
    
    fileprivate func setupProductDescriptionLabel() {
        self.addSubview(productDescriptionLabel)
        
        // Label size
        let labelFrame = CGRect(
            x: frame.width * 0.1,
            y: frame.height * 0.32,
            width: frame.size.width * 0.9,
            height: frame.size.height * 0.1
        )
        productDescriptionLabel.frame = labelFrame
        
        let font = UIFont(
            name: "Avenir",
            size: frame.height * 0.04
        )
        productDescriptionLabel.font = font
        productDescriptionLabel.text = "Product description"
        
    }
    
    fileprivate func setupInstructionLabel() {
        self.addSubview(instructionLabel)
        
        // Label size
        let labelFrame = CGRect(
            x: frame.width * 0.2,
            y: frame.height * 0.03,
            width: frame.size.width * 0.9,
            height: frame.size.height * 0.1
        )
        instructionLabel.frame = labelFrame
        
        let font = UIFont(
            name: "Avenir",
            size: frame.height * 0.05
        )
        instructionLabel.font = font
        instructionLabel.text = "Add new product"
        
    }
    
    // MARK: Cancel Button
    
    fileprivate func setupCancelButton() {
        self.addSubview(cancelButton)
        
        let labelFrame = CGRect(
            x: frame.width * 0.05,
            y: frame.height * 0.04,
            width: frame.size.width * 0.1,
            height: frame.size.width * 0.1
        )
        cancelButton.frame = labelFrame
        cancelButton.clipsToBounds = false
        cancelButton.backgroundColor = UIColor(
            colorLiteralRed: 248/255,
            green: 211/255,
            blue: 33/255,
            alpha: 1
        )
        cancelButton.layer.cornerRadius = cancelButton.frame.width / 2
        
        let image = UIImage(named: "CloseButton")
        cancelButton.setImage(image, for: .normal)
    
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(cancelTapGestureHandler)
        )
        cancelButton.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    @objc fileprivate func cancelTapGestureHandler() {
        // Dismiss the Add Product View
        dismissAddProductView(for: .cancelAdd)
        
        let notificationName = NSNotification.Name("RevealTopBarNotification")
        NotificationCenter.default.post(
            name: notificationName,
            object: nil
        )
    }
    
    // MARK: AddImage Button
    
    fileprivate func setupAddImageButton(){
        self.addSubview(addImageButton)
        
        let frame = CGRect(
            x: self.frame.width * 0.25,
            y: self.frame.height * 0.60,
            width: self.frame.size.width * 0.5,
            height: self.frame.size.height * 0.07
        )
        
        addImageButton.frame = frame
        
        // Font setup
        let font = UIFont(
            name: "Avenir",
            size: self.frame.height * 0.05
        )
        
        addImageButton.titleLabel?.font = font
        addImageButton.setTitle("Add Image", for: .normal)
        addImageButton.layer.cornerRadius = self.frame.width * 0.05
        
        // Custom tap gesture setup
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(addImageHandler)
        )
        addImageButton.addGestureRecognizer(tapGestureRecognizer)
        
        // Miscellaneous setup
        addImageButton.backgroundColor = UIColor(
            colorLiteralRed: 248/255,
            green: 211/255,
            blue: 33/255,
            alpha: 1
        )
        addImageButton.isUserInteractionEnabled = true
    }
    
    func addImageHandler(){
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        if let mainVC = mainViewController {
            mainVC.present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        if let mainVC = mainViewController {
            mainVC.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImageFromPicker = selectedImageFromPicker {
            print("Got an image to assign")
            self.seletedImage = selectedImageFromPicker
            self.addImageButton.titleLabel?.adjustsFontSizeToFitWidth = true
            self.addImageButton.setTitle("Image added!", for: .normal)
            self.addImageButton.setTitleColor(.green, for: .normal)
        }
        
        if let mainVC = mainViewController {
            mainVC.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: AddProduct Button
    
    fileprivate func setupAddProductButton() {
        self.addSubview(addProductButton)
        // Frame setup
        let frame = CGRect(
            x: self.frame.width * 0.05,
            y: self.frame.height * 0.75,
            width: self.frame.size.width * 0.9,
            height: self.frame.size.height * 0.12
        )
        addProductButton.frame = frame
        addProductButton.layer.cornerRadius = self.frame.width * 0.08
        // Font setup
        let font = UIFont(
            name: "Avenir",
            size: self.frame.height * 0.05
        )
        addProductButton.titleLabel?.font = font
        addProductButton.setTitle("Add product", for: .normal)
        
        // Custom tap gesture setup
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(addProductButtonHandler)
        )
        addProductButton.addGestureRecognizer(tapGestureRecognizer)
        
        // Miscellaneous setup
        addProductButton.backgroundColor = UIColor(
            colorLiteralRed: 248/255,
            green: 211/255,
            blue: 33/255,
            alpha: 1
        )
        addProductButton.isUserInteractionEnabled = true
        
    }
    
    
    @objc fileprivate func addProductButtonHandler() {
        // Reveal the top bar view again
        let notificationName = NSNotification.Name("RevealTopBarNotification")
        NotificationCenter.default.post(
            name: notificationName,
            object: nil
        )
        
        guard let image = self.seletedImage else {
            // TODO: Present alert please select an image
            addImageButton.titleLabel?.adjustsFontSizeToFitWidth = true
            addImageButton.setTitle("Please add an image", for: .normal)
            addImageButton.setTitleColor(.red, for: .normal)
            print("no image selected")
            return
        }
        
        // Check if the text field is empty
        if productNameTextField.text == "" {
            
            productNameTextField.placeholder = "Product title missing"
            
        } else {
            // Dismiss the view
            dismissAddProductView(for: .addProduct)
            
            guard let productTitle = productNameTextField.text else {
                return
            }
            
            guard let productDescription = productDescriptionTextField.text else {
                return
            }
      
            product?.title = productTitle
            product?.productDescription = productDescription
            
            // Sends this information to the MainMapView
            delegate.createProduct(
                title: productTitle,
                description: productDescription,
                image: image
            )
        }
    }
    
    
    /// Dismisses the Add Product View and removes it from the superview
    func dismissAddProductView(for state: addProductViewState) {
    
        guard let keyWindow = keyWindow else {
            return
        }
    
        UIView.animate(withDuration: 0.2, animations: {
            // Move the view downwards
            self.frame.origin.y = keyWindow.frame.height
            // Resize the MapView
            self.delegate.resizeMapView(for: state)
            
        }) { (_) in
            self.removeFromSuperview()
        }
    
    }

}
