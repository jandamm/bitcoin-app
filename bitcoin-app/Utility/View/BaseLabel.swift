//
//  BaseLabel.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import UIKit

class BaseLabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textColor = .text
    }
}