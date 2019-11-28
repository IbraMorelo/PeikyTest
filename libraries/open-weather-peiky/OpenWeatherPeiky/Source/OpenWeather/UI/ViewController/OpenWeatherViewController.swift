//
//  OpenWeatherViewController.swift
//  OpenWeatherPeiky
//
//  Created by Ibrahimme Morelo on 28/11/2019.
//

protocol OpenWeatherViewOutput {
    func didLoad()
}

final class OpenWeatherViewController: UIViewController {
    private var presenter: OpenWeatherViewOutput
    
    init(presenter: OpenWeatherViewOutput) {
        self.presenter = presenter
        super.init(nibName: String(describing: OpenWeatherViewController.self),
                   bundle: bundleForXib(type: OpenWeatherViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not implemented")
    }
    
    override func viewDidLoad() {
        presenter.didLoad()
        view.backgroundColor = .red
    }
}
