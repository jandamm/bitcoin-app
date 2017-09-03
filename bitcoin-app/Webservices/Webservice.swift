//
//  Webservice.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import Foundation

protocol Webservice: class {
    typealias BitcoinTickerSuccess = (BitcoinTicker) -> Void
    typealias BitcoinTickerFailure = (Error) -> Void
    
    typealias BitcoinHistoryCompletion = ([BitcoinHistory]) -> Void
    
    func startTicker(for conversion: BitcoinConversion, withObserver observer: WebserviceObserver, successCompletion: @escaping BitcoinTickerSuccess, failureCompletion: @escaping BitcoinTickerFailure)
    func getHistoryData(for conversion: BitcoinConversion, completion: @escaping BitcoinHistoryCompletion)
}

protocol WebserviceObserver: class {
    func webservice(_ webservice: Webservice, updatedTicker ticker: BitcoinTicker)
    func webservice(_ webservice: Webservice, failedToUpdateTickerWithError error: Error)
}
