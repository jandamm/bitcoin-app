//
//  BitcoinService.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import Foundation

class BitcoinService: NSObject, Webservice {
    
    func startTicker(for conversion: BitcoinConversion, withObserver observer: WebserviceObserver, firstValue: @escaping (BitcoinTicker?) -> Void) {
        
    }

    func getHistoryData(for conversion: BitcoinConversion, completion: @escaping ([BitcoinHistory]) -> Void) {
        
    }
}
