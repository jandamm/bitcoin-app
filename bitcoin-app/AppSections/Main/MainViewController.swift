//
//  MainViewController.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet private weak var lastLabel: BaseLabel!
    @IBOutlet private weak var changePriceLabel: BaseLabel!
    @IBOutlet private weak var changePercentLabel: BaseLabel!

    @IBOutlet private weak var additionalInfoStackView: UIStackView!
    @IBOutlet private weak var averageView: LabelledView!
    @IBOutlet private weak var highView: LabelledView!
    @IBOutlet private weak var lowView: LabelledView!
    
    @IBOutlet private weak var lineChartView: HistoryChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = BitcoinConversion.conversion().title
//        additionalInfoStackView.isHidden = true
        
        averageView.title = "Average:".localized
        highView.title = "High:".localized
        lowView.title = "Low:".localized
        
        let historyData = [
            BitcoinHistory(time: Date(timeIntervalSinceNow: -1000), average: 1),
            BitcoinHistory(time: Date(timeIntervalSinceNow: -500), average: 2),
            BitcoinHistory(time: Date(), average: 1),
        ]
        
        lineChartView.setHistoryData(historyData)
    }
}

extension MainViewController: WebserviceObserver {

    func webservice(_ webservice: Webservice, updatedTicker ticker: BitcoinTicker) {
        
    }

    func webservice(_ webservice: Webservice, failedToUpdateTickerWithError error: Error) {
        
    }
}
