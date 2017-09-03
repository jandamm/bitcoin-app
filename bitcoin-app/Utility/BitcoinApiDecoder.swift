//
//  BitcoinApiDateFormatter.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import Foundation

/// A JSONDecoder with the correct dateFormatter for the Bitcoin REST Api.
class BitcoinApiDecoder: JSONDecoder {

    override init() {
        super.init()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        dateDecodingStrategy = .formatted(dateFormatter)
    }
}
