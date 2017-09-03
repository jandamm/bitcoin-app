//
//  Extensions.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import Foundation

extension String {

    var localized: String {
        return localized(comment: "")
    }

    func localized(comment: String) -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
