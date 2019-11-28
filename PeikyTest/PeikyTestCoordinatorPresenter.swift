//
//  PeikyTestCoordinatorPresenter.swift
//  PeikyTest
//
//  Created by Ibrahimme Morelo on 28/11/2019.
//

import UIKit

final class PeikyTestCoordinatorPresenter {
    private let wireframe: PeikyTestCoordinatorWireframe
    weak var rootController: UIViewController?
    
    init(wireframe: PeikyTestCoordinatorWireframe) {
        self.wireframe = wireframe
        self.rootController = wireframe.getRootViewController(with: self)
    }
}
