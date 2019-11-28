//
//  AppDelegate+Window.swift
//  PeikyTest
//
//  Created by Ibrahimme Morelo on 28/11/2019.
//

import UIKit


extension AppDelegate {
    @objc func initMainApplicationViews() {
        let appCoordinator = PeikyTestCoordinator()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appCoordinator.rootController
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
    }
}
