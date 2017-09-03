//
//  AppDelegate.swift
//  bitcoin-app
//
//  Created by Jan Dammshäuser on 03.09.17.
//  Copyright © 2017 Jan Dammshäuser. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private lazy var rootViewController: BaseNavigationController = BaseNavigationController()
    private lazy var appCoordinator: AppCoordinator = AppCoordinator(with: self.rootViewController)

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let frame = UIScreen.main.bounds
        let window = UIWindow(frame: frame)

        window.rootViewController = rootViewController

        appCoordinator.start()

        window.makeKeyAndVisible()
        self.window = window

        return true
    }

    func applicationWillResignActive(_: UIApplication) {
        appCoordinator.webservice.stopTicker()
    }

    func applicationWillEnterForeground(_: UIApplication) {
        try? appCoordinator.webservice.restartTicker()
    }
}
