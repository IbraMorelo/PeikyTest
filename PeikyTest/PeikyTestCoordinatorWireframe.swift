//
//  PeikyTestCoordinatorWireframe.swift
//  PeikyTest
//
//  Created by Ibrahimme Morelo on 28/11/2019.
//

import UIKit

class PeikyTestCoordinatorWireframe {
    func getRootViewController(with presenter: PeikyTestCoordinatorPresenter) -> UIViewController {
        let rootController = PeikyTestCoordinatorViewController(presenter: presenter)
        let rootNavigation = UINavigationController(rootViewController: rootController)
        return rootNavigation
    }
}
