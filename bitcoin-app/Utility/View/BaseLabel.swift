//
//  BaseLabel.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import UIKit

@IBDesignable
class BaseLabel: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()

        setup()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        setup()
    }

    private func setup() {
        textColor = .text
    }
}
