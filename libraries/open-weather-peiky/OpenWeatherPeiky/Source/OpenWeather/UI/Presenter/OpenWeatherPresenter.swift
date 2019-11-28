//
//  OpenWeatherPresenter.swift
//  OpenWeatherPeiky
//
//  Created by Ibrahimme Morelo on 28/11/2019.
//

protocol OpenWeatherPresenterProtocol: OpenWeatherViewOutput {
    func showOpenWeather()
}

final class OpenWeatherPresenter {
    private let wireframe: OpenWeatherWireframeProtocol
    private let interactor: OpenWeatherInteractorProtocol
    
    init (wireframe: OpenWeatherWireframeProtocol, interactor: OpenWeatherInteractorProtocol) {
        self.wireframe = wireframe
        self.interactor = interactor
    }
}

extension OpenWeatherPresenter: OpenWeatherPresenterProtocol {
    func didLoad() {
        
    }
    
    func showOpenWeather() {
        wireframe.showOpenWeather(with: self)
    }
}
