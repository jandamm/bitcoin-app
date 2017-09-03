//
//  MainViewController.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet private weak var contentControl: UIControl!
    @IBOutlet private weak var contentStackView: UIStackView!
    @IBOutlet private weak var lastLabel: BaseLabel!
    @IBOutlet private weak var changePriceLabel: BaseLabel!
    @IBOutlet private weak var changePercentLabel: BaseLabel!

    @IBOutlet private weak var additionalInfoStackView: UIStackView!
    @IBOutlet private weak var averageView: LabelledView!
    @IBOutlet private weak var highView: LabelledView!
    @IBOutlet private weak var lowView: LabelledView!
    
    @IBOutlet private weak var lineChartView: HistoryChartView!
    
    private var lastFormatter: BitcoinFormatter<BitcoinTicker>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = BitcoinConversion.get().title
        additionalInfoStackView.isHidden = true
        
        averageView.title = "Average:".localized
        highView.title = "High:".localized
        lowView.title = "Low:".localized
        
        contentControl.subviews.forEach { $0.isUserInteractionEnabled = false }
        
        let historyData = [
            BitcoinHistory(time: Date(timeIntervalSinceNow: -1000), average: 1),
            BitcoinHistory(time: Date(timeIntervalSinceNow: -500), average: 2),
            BitcoinHistory(time: Date(), average: 1),
        ]
        
        lineChartView.setHistoryData(historyData)
        updateView(with: lastFormatter)
    }
    
    @IBAction private func contentPressed(_: UIControl) {
        let isHidden = additionalInfoStackView.isHidden
        additionalInfoStackView.alpha = isHidden ? 0 : 1
        
        
        UIView.animate(withDuration: 0.4) {
            self.additionalInfoStackView.isHidden = !isHidden
            self.additionalInfoStackView.alpha = !isHidden ? 0 : 1
        }
    }
    
    private func updateView(with formatter: BitcoinFormatter<BitcoinTicker>?) {
        guard let formatter = formatter, lastLabel != nil else { return }
        
        lastLabel.text = formatter.currency(for: \.last)
        changePriceLabel.text = formatter.currency(for: \.valueChange)
        changePercentLabel.text = formatter.percent(for: \.percentChange)
        
        let color: UIColor = formatter.color(for: \.percentChange, threshold: 0.01) ?? .text
        
        changePercentLabel.textColor = color
        changePriceLabel.textColor = color
        
        averageView.content = formatter.currency(for: \.average)
        highView.content = formatter.currency(for: \.high)
        lowView.content = formatter.currency(for: \.low)
    }
}

extension MainViewController: WebserviceObserver {

    func webservice(_ webservice: Webservice, updatedTicker ticker: BitcoinTicker) {
        lastFormatter = BitcoinFormatter(ticker)

        updateView(with: lastFormatter)
    }

    func webservice(_ webservice: Webservice, failedToUpdateTickerWithError error: Error) {
        
    }
}
