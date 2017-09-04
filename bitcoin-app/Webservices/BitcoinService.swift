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

    private(set) var currentConversion: BitcoinConversion = .get()
    private(set) weak var tickerObserver: WebserviceObserver?

    private var historyData: [BitcoinConversion: [BitcoinHistory]] = [:]

    func stopTicker() {
        timer?.invalidate()
        timer = nil
    }

    func startTicker(for conversion: BitcoinConversion, withObserver observer: WebserviceObserver?, successCompletion: @escaping Webservice.BitcoinTickerSuccess, failureCompletion: @escaping Webservice.BitcoinTickerFailure) {

        if let observer = observer {
            tickerObserver = observer
        }

        currentConversion = conversion

        stopTicker()

        let url = Api.Url.forTicker(with: conversion)

        getTickerData(for: url, successCompletion: successCompletion, failureCompletion: failureCompletion)

        guard tickerObserver != nil else {
            return
        }

        timer = Timer.scheduledTimer(withTimeInterval: Api.refreshInterval, repeats: true) { [weak self] _ in
            guard self?.tickerObserver != nil else {
                self?.stopTicker()
                return
            }
            self!.getTickerData(for: url)
        }
    }

    func getHistoryData(for conversion: BitcoinConversion, completion: @escaping Webservice.BitcoinHistoryCompletion) {
        guard let data = historyData[conversion] else {
            downloadHistory(for: conversion, completion: completion)
            return
        }

        completion(data)
    }

    private func downloadHistory(for conversion: BitcoinConversion, completion: @escaping Webservice.BitcoinHistoryCompletion) {
        let url = Api.Url.forHistory(with: conversion)

        Alamofire.request(url).responseJSON { response in
            guard response.error == nil, let jsonData = response.data else {
                completion([])
                return
            }
            do {
                let decoder = BitcoinApiDecoder()
                var data = try decoder.decode([BitcoinHistory].self, from: jsonData)

                data.sort { $0.time < $1.time }
                completion(data)
                self.historyData[conversion] = data
            } catch {
                completion([])
            }
        }
    }

    private func getTickerData(for url: URL, successCompletion: Webservice.BitcoinTickerSuccess? = nil, failureCompletion: Webservice.BitcoinTickerFailure? = nil) {
        Alamofire.request(url).responseJSON { response in

            if let error = response.error {
                failureCompletion?(error)
                self.tickerObserver?.webservice(self, failedToUpdateTickerWithError: error)
                return
            }

            guard let jsonData = response.data else {
                return
            }

            do {
                let decoder = BitcoinApiDecoder()
                let ticker = try decoder.decode(BitcoinTicker.self, from: jsonData)
                successCompletion?(ticker)
                self.tickerObserver?.webservice(self, updatedTicker: ticker)
            } catch {
                failureCompletion?(error)
                self.tickerObserver?.webservice(self, failedToUpdateTickerWithError: error)
            }
        }
    }
}
