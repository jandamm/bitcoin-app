//
//  BitcoinService.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import Alamofire

class BitcoinService: NSObject, Webservice {
    
    private var timer: Timer?
    private weak var tickerObserver: WebserviceObserver?
    
    func startTicker(for conversion: BitcoinConversion, withObserver observer: WebserviceObserver?, successCompletion: @escaping Webservice.BitcoinTickerSuccess, failureCompletion: @escaping Webservice.BitcoinTickerFailure) {
        if let observer = observer {
            tickerObserver = observer
        }

        let url = Api.Url.forTicker(with: conversion)
        
        getTickerData(for: url, successCompletion: successCompletion, failureCompletion: failureCompletion)
    }

    func getHistoryData(for conversion: BitcoinConversion, completion: @escaping Webservice.BitcoinHistoryCompletion) {
        
    }
    
    private func getTickerData(for url: URL, successCompletion: @escaping Webservice.BitcoinTickerSuccess, failureCompletion: @escaping Webservice.BitcoinTickerFailure) {
        Alamofire.request(url).responseJSON { response in
            
            if let error = response.error {
                failureCompletion(error)
                return
            }

            guard let jsonData = response.data else {
                return
            }

            do {
                let decoder = BitcoinApiDecoder()
                let ticker = try decoder.decode(BitcoinTicker.self, from: jsonData)
                successCompletion(ticker)
            } catch {
                failureCompletion(error)
            }
        }
    }
}
