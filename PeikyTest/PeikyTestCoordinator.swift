//
//  PeikyTestCoordinator.swift
//  PeikyTest
//
//  Created by Ibrahimme Morelo on 28/11/2019.
//

import UIKit

final class PeikyTestCoordinator {
    private let presenter: PeikyTestCoordinatorPresenter
    
    init() {
        let wireframe = PeikyTestCoordinatorWireframe()
        self.presenter = PeikyTestCoordinatorPresenter(wireframe: wireframe)
    }
    
    weak var rootController: UIViewController? {
        return presenter.rootController
    }
}
