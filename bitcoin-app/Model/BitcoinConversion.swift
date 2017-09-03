//
//  BitcoinConversion.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import Foundation

enum BitcoinConversion: String {
    case euro
    case dollar
    case pound
    
    private static let key = "ud_bitcoin_conversion"
}

// MARK: - Values
extension BitcoinConversion {

    var symbol: String {
        switch self {
        case .euro: return "BTCEUR"
        case .dollar: return "BTCUSD"
        case .pound: return "BTCGBP"
        }
    }
}

// MARK: - Storage
extension BitcoinConversion {

    /// - returns: last stored conversion or default value
    static func conversion(from storage: BitcoinConversionStorage = UserDefaults.standard) -> BitcoinConversion {
        guard let value = storage.string(forKey: key),
              let conversion = BitcoinConversion(rawValue: value) else {
            return .euro
        }

        return conversion
    }

    /// Sets the conversion as the default conversion
    func save(to storage: BitcoinConversionStorage = UserDefaults.standard) {
        storage.set(self.rawValue, forKey: BitcoinConversion.key)
    }
}
