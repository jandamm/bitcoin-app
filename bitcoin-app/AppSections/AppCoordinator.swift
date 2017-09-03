//
//  AppCoordinator.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import JDCoordinator

class AppCoordinator: JDAppCoordinator {
    
    private let webservice: Webservice
    
    convenience override init(with navigationController: UINavigationController) {
        let webservice = BitcoinService()

        self.init(with: navigationController, andWebservice: webservice)
    }
    
    init(with navigationController: UINavigationController, andWebservice webservice: Webservice) {
        self.webservice = webservice

        super.init(with: navigationController)
    }
    
    override func start() {
        super.start()
        
        showMainViewController()
    }
    
    private func showMainViewController() {
        let mainViewController = MainViewController()

        webservice.startTicker(for: BitcoinConversion.conversion(), withObserver: mainViewController, successCompletion:  { ticker in
            self.setViewController(mainViewController)
        }, failureCompletion: { error in
           NSLog(error.localizedDescription)
        })
    }
}
