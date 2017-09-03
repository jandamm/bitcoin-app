//
//  BitcoinConversion.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import Foundation

enum BitcoinConversion: String {
    case euro = "EUR"
    case dollar = "USD"
    case pound = "GBP"

    private static let key = "ud_bitcoin_conversion"
}

// MARK: - Values
extension BitcoinConversion {

    var symbol: String {
        return "BTC\(rawValue)"
    }
    
    var title: String {
        return "BTC to \(rawValue)"
    }
    
    var currency: String {
        switch self {
        case .euro: return "€"
        case .dollar: return "$"
        case .pound: return "£"
        }
    }
}

// MARK: - Storage
extension BitcoinConversion {

    /// - returns: last stored conversion or default value
    static func get(from storage: BitcoinConversionStorage = UserDefaults.standard) -> BitcoinConversion {
        guard let value = storage.string(forKey: key),
              let conversion = BitcoinConversion(rawValue: value) else {
            return .euro
        }

        return conversion
    }

    /// Sets the conversion as the default conversion
    func save(to storage: BitcoinConversionStorage = UserDefaults.standard) {
        storage.set(rawValue, forKey: BitcoinConversion.key)
    }
}
