//
//  PeikyTestCoordinatorViewController.swift
//  PeikyTest
//
//  Created by Ibrahimme Morelo on 28/11/2019.
//

import UIKit

class PeikyTestCoordinatorViewController: UIViewController {
    
    private let presenter: PeikyTestCoordinatorPresenter
    
    init(presenter: PeikyTestCoordinatorPresenter) {
        self.presenter = presenter
        super.init(nibName: String(describing: PeikyTestCoordinatorViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppConfiguration.shared.setup(self)
    }
}
