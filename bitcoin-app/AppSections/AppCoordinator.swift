//
//  AppCoordinator.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import JDCoordinator

class AppCoordinator: JDAppCoordinator {
    
    let webservice: Webservice
    
    private weak var historyDataReceiver: HistoryDataReceiver?
    
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
        
        showLaunchscreen()
        showMainViewController()
        
        webservice.getHistoryData(for: BitcoinConversion.get()) { data in
            self.historyDataReceiver?.updateChart(with: data)
        }
    }
    
    // MARK: - Show
    private func showLaunchscreen() {
        navigationController.setNavigationBarHidden(true, animated: false)
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LaunchScreen")
        
        setViewController(viewController, animated: false)
    }
    
    private func showMainViewController() {
        let mainViewController = MainViewController()
        
        historyDataReceiver = mainViewController

        webservice.startTicker(for: BitcoinConversion.get(), withObserver: mainViewController, successCompletion:  { ticker in
            self.navigationController.setNavigationBarHidden(false, animated: true)
            self.setViewController(mainViewController)
        }, failureCompletion: { error in
           NSLog(error.localizedDescription)
        })
    }
}
