//
//  BitcoinConversionStorage.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import Foundation

protocol BitcoinConversionStorage {
    func string(forKey: String) -> String?
    func set(_: Any?, forKey: String)
}

extension UserDefaults: BitcoinConversionStorage {}
