//
//  CurrencyButton.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import UIKit

class CurrencyButton: UIControl {
    
    private lazy var imageView = UIImageView()

    private(set) var conversion: BitcoinConversion!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear

        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        let views = ["imageView": imageView]
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView]|", options: [], metrics: nil, views: views)
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView]|", options: [], metrics: nil, views: views)
        
        addConstraints(verticalConstraints)
        addConstraints(horizontalConstraints)
    }
    
    func setup(for conversion: BitcoinConversion) {
        guard self.conversion == nil else { return }
        
        self.conversion = conversion
        imageView.image = UIImage(named: conversion.imageName)
    }
}
