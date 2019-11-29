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
    func showOpenWeather() {
        wireframe.showOpenWeather(with: self)
    }
    
    func requestWeatherCity(name: String,
                            completionHandler: @escaping (_ openWeatherDetail: OpenWeatherDetail) -> Void,
                            onError: @escaping () -> Void) {
        interactor.requestWeatherCity(name: name,
                                      completionHandler: completionHandler,
                                      onError: onError)
    }
    
    func requestWeatherLocation(lat: String,
                                lon: String,
                                completionHandler: @escaping (_ openWeatherDetail: OpenWeatherDetail) -> Void,
                                onError: @escaping () -> Void) {
        interactor.requestWeatherLocation(lat: lat,
                                          lon: lon,
                                          completionHandler: completionHandler,
                                          onError: onError)
    }
}
