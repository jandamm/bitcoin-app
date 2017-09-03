//
//  MainViewController.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import UIKit

protocol HistoryDataReceiver: class {
    func updateChart(with historyData: [BitcoinHistory])
}

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
    
    @IBOutlet private var menuController: MenuController!
    
    private var lastFormatter: BitcoinFormatter<BitcoinTicker>?
    private var historyData: [BitcoinHistory] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        additionalInfoStackView.isHidden = true
        
        averageView.title = "Average:".localized
        highView.title = "High:".localized
        lowView.title = "Low:".localized
        
        contentControl.subviews.forEach { $0.isUserInteractionEnabled = false }

        menuController.set(for: .get())
        updateCurrencyValues()
        updateChart(with: historyData)
        updateContent(with: lastFormatter)
        
        NotificationCenter.default.addObserver(forName: Notification.currencyChanged, object: nil, queue: .main) { [weak self] _ in
            self?.updateCurrencyValues()
        }
    }
    
    @IBAction private func contentPressed(_: UIControl) {
        let isHidden = additionalInfoStackView.isHidden
        additionalInfoStackView.alpha = isHidden ? 0 : 1

        UIView.animate(withDuration: 0.4) {
            self.additionalInfoStackView.isHidden = !isHidden
            self.additionalInfoStackView.alpha = !isHidden ? 0 : 1
        }
    }
    
    private func updateContent(with formatter: BitcoinFormatter<BitcoinTicker>?) {
        guard let formatter = formatter, lastLabel != nil else { return }
        
        contentStackView.alpha = 1
        
        lastLabel.text = formatter.currency(for: \.last)
        changePriceLabel.text = formatter.currency(for: \.valueChange)
        changePercentLabel.text = formatter.percent(for: \.percentChange)
        
        let color: UIColor = formatter.color(for: \.percentChange, threshold: 0.005) ?? .text
        
        changePercentLabel.textColor = color
        changePriceLabel.textColor = color
        
        averageView.content = formatter.currency(for: \.average)
        highView.content = formatter.currency(for: \.high)
        lowView.content = formatter.currency(for: \.low)
    }
    
    private func updateCurrencyValues() {
        let conversion = BitcoinConversion.get()
        title = conversion.title
    }
}

extension MainViewController: HistoryDataReceiver {

    func updateChart(with historyData: [BitcoinHistory]) {
        var historyData = historyData

        if historyData.count > 365 {
            historyData = Array(historyData.suffix(365))
        }

        self.historyData = historyData
        lineChartView?.setHistoryData(historyData)
    }
}

extension MainViewController: WebserviceObserver {

    func webservice(_ webservice: Webservice, updatedTicker ticker: BitcoinTicker) {
        lastFormatter = BitcoinFormatter(ticker)

        updateContent(with: lastFormatter)
    }

    func webservice(_ webservice: Webservice, failedToUpdateTickerWithError error: Error) {
        contentStackView?.alpha = 0.7
    }
}
