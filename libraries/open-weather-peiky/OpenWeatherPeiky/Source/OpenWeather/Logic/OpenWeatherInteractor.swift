//
//  OpenWeatherInteractor.swift
//  OpenWeatherPeiky
//
//  Created by Ibrahimme Morelo on 11/28/19.
//

protocol OpenWeatherInteractorProtocol {
    func requestWeatherCity(name: String,
                            completionHandler: @escaping (_ openWeatherDetail: OpenWeatherDetail) -> Void,
                            onError: @escaping () -> Void)
    func requestWeatherLocation(lat: String,
                                lon: String,
                                completionHandler: @escaping (_ openWeatherDetail: OpenWeatherDetail) -> Void,
                                onError: @escaping () -> Void)
}

final class OpenWeatherInteractor {
    private let dataManager = OpenWeatherDataManager()
}

extension OpenWeatherInteractor: OpenWeatherInteractorProtocol {
    func requestWeatherCity(name: String,
                            completionHandler: @escaping (_ openWeatherDetail: OpenWeatherDetail) -> Void,
                            onError: @escaping () -> Void) {
        dataManager.requestWeather(city: name, completionHandler: completionHandler, onError: onError)
    }
    
    func requestWeatherLocation(lat: String,
                                lon: String,
                                completionHandler: @escaping (_ openWeatherDetail: OpenWeatherDetail) -> Void,
                                onError: @escaping () -> Void) {
        dataManager.requestWeather(lat: lat, lon: lon, completionHandler: completionHandler, onError: onError)
    }
}
