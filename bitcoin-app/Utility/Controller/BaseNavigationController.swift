//
//  BaseNavigationController.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import UIKit

/// A NavigationController that will layout the navigationBar.
class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = .primary
        navigationBar.isTranslucent = false
    }
}
