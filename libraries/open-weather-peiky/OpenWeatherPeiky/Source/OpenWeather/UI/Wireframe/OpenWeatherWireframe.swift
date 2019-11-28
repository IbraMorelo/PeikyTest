//
//  OpenWeatherWireframe.swift
//  OpenWeatherPeiky
//
//  Created by Ibrahimme Morelo on 11/28/19.
//

protocol OpenWeatherWireframeProtocol {
    func showOpenWeather(with presenter: OpenWeatherViewOutput)
}

final class OpenWeatherWireframe {
    private weak var baseController: UIViewController?
    
    init(baseController: UIViewController?) {
        self.baseController = baseController
    }
}

extension OpenWeatherWireframe: OpenWeatherWireframeProtocol {
    func showOpenWeather(with presenter: OpenWeatherViewOutput) {
        let viewController = OpenWeatherViewController(presenter: presenter)
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.modalPresentationStyle = .fullScreen
        baseController?.present(navigation, animated: true)
    }
}

