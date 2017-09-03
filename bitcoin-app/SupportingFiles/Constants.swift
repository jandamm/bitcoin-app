//
//  Constants.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import Foundation

extension Notification {
    static let currencyChanged: Name = Name(rawValue: "nc_currency_changed")
}

enum Api {

    static let refreshInterval: TimeInterval = 15

    enum Url {
        private static let baseUrl = "https://apiv2.bitcoinaverage.com/indices/global/"
        private static let tickerUrl = "ticker/"
        private static let historyUrl = "history/"

        static func forTicker(with conversion: BitcoinConversion) -> URL {
            return getURL(path: tickerUrl, conversion: conversion)
        }

        static func forHistory(with conversion: BitcoinConversion) -> URL {
            return getURL(path: historyUrl, conversion: conversion)
        }

        private static func getURL(path: String, conversion: BitcoinConversion) -> URL {
            let fullPath = "\(baseUrl)\(path)\(conversion.symbol)"

            guard let url = URL(string: fullPath) else {
                fatalError("The given Strings should always generate a valid URL")
            }

            return url
        }
    }
}
