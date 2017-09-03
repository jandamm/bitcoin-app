//
//  BitcoinTicker.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import Foundation

struct BitcoinTicker: Codable {
    let time: Date

    let last: Double
    let high: Double
    let low: Double
    
    var average: Double {
        return averages.day
    }
    
    var percentChange: Double {
        return changes.percent.day / 100
    }
    
    var valueChange: Double {
        return changes.price.day
    }
    
    private let averages: TimedValues
    private let changes: Changes
    
    private struct Changes: Codable {
        let percent: TimedValues
        let price: TimedValues
    }
    
    private struct TimedValues: Codable {
        let day: Double
    }
    
    enum CodingKeys: String, CodingKey {
        case last, high, low, averages, changes
        case time = "display_timestamp"
    }
}
