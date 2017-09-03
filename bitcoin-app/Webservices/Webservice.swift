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
    
    var currentConversion: BitcoinConversion { get }
    var tickerObserver: WebserviceObserver? { get }

    /// Omit the observer if you don't need an observer or you want to use the old one.
    func startTicker(for conversion: BitcoinConversion, withObserver observer: WebserviceObserver?, successCompletion: @escaping BitcoinTickerSuccess, failureCompletion: @escaping BitcoinTickerFailure)
    func getHistoryData(for conversion: BitcoinConversion, completion: @escaping BitcoinHistoryCompletion)
    
    func stopTicker()
}

protocol WebserviceObserver: class {
    func webservice(_ webservice: Webservice, updatedTicker ticker: BitcoinTicker)
    func webservice(_ webservice: Webservice, failedToUpdateTickerWithError error: Error)
}

extension Webservice {

    func restartTicker() throws {
        guard tickerObserver != nil else {
            throw WebserviceError.noObserver
        }
        startTicker(for: currentConversion, withObserver: tickerObserver, successCompletion: { _ in }, failureCompletion: { _ in })
    }
}

enum WebserviceError: Error {
    case noObserver
}
