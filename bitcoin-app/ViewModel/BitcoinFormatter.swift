//
//  BitcoinFormatter.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import Foundation

struct BitcoinFormatter<Base> {
    private let base: Base
    init(_ base: Base) { self.base = base }
    
    func currency(for keyPath: KeyPath<Base, Double>, with conversion: BitcoinConversion = BitcoinConversion.get(), signage: String = "") -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.currencySymbol = conversion.currency
        numberFormatter.numberStyle = .currency

        return format(keyPath: keyPath, signage: signage, formatter: numberFormatter)
    }
    
    func percent(for keyPath: KeyPath<Base, Double>, signage: String = "") -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        numberFormatter.minimumFractionDigits = 2
        
        return format(keyPath: keyPath, signage: signage, formatter: numberFormatter)
    }
    
    private func format(keyPath: KeyPath<Base, Double>, signage: String = "", formatter: NumberFormatter) -> String? {
        let value = base[keyPath: keyPath] as NSNumber
        
        guard let currency = formatter.string(from: value) else {
            return nil
        }
        
        return "\(signage)\(currency)"
    }
}
