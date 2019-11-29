//
//  OpenWeatherModule.swift
//  OpenWeatherPeiky
//
//  Created by Ibrahimme Morelo on 28/11/2019.
//

public class OpenWeatherModule {
    private let presenter: OpenWeatherPresenterProtocol

    public init(with baseController: UIViewController?) {
        let interactor = OpenWeatherInteractor()
        let wireframe = OpenWeatherWireframe(baseController: baseController)
        presenter = OpenWeatherPresenter(wireframe: wireframe, interactor: interactor)
    }
    
    public func showOpenWeather() {
        presenter.showOpenWeather()
    }
}

