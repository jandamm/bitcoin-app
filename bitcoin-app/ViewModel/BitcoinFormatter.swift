//
//  BitcoinFormatter.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import UIKit

struct BitcoinFormatter<Base> {
    private let base: Base
    init(_ base: Base) { self.base = base }

    /// Formats the given keyPath to currency
    /// - parameters:
    ///     - keyPath: KeyPath to the value you need
    ///     - conversion: give the needed conversion
    ///     - prefix: give a prefix
    /// - returns: A string if the conversion has been successful
    func currency(for keyPath: KeyPath<Base, Double>, with conversion: BitcoinConversion = BitcoinConversion.get(), prefix: String = "") -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.currencySymbol = conversion.currency
        numberFormatter.numberStyle = .currency

        return format(keyPath: keyPath, prefix: prefix, formatter: numberFormatter)
    }

    /// Formats the given keyPath to a percentage
    /// - parameters:
    ///     - keyPath: KeyPath to the value you need
    ///     - prefix: give a prefix
    /// - returns: A string if the conversion has been successful
    func percent(for keyPath: KeyPath<Base, Double>, prefix: String = "") -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        numberFormatter.minimumFractionDigits = 2

        return format(keyPath: keyPath, prefix: prefix, formatter: numberFormatter)
    }

    /// Converts a number into a color (green for positive, red for negative)
    /// - parameters:
    ///     - keyPath: KeyPath to the value you need
    ///     - threshold: give a threshold that should not return a color
    /// - returns: Color for the given number. Zero will always return nil.
    func color(for keyPath: KeyPath<Base, Double>, threshold: Double = 0) -> UIColor? {
        let value = base[keyPath: keyPath]

        let isWithinThreshold = abs(value) <= abs(threshold)

        if isWithinThreshold {
            return nil
        } else if value < 0 {
            return .error
        } else {
            return .success
        }
    }

    private func format(keyPath: KeyPath<Base, Double>, prefix: String = "", formatter: NumberFormatter) -> String? {
        let value = base[keyPath: keyPath] as NSNumber

        guard let currency = formatter.string(from: value) else {
            return nil
        }

        return "\(prefix)\(currency)"
    }
}
