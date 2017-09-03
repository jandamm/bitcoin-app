//
//  MainViewController.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "MainViewController"
    }
}

extension MainViewController: WebserviceObserver {

    func webservice(_ webservice: Webservice, updatedTicker ticker: BitcoinTicker) {}
    func webservice(_ webservice: Webservice, failedToUpdateTickerWithError error: Error) {}
}
