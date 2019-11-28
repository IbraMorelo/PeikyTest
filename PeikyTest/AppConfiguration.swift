//
//  AppConfiguration.swift
//  PeikyTest
//
//  Created by Ibrahimme Morelo on 28/11/2019.
//

import OpenWeatherPeiky

class AppConfiguration: NSObject {
    static let shared = AppConfiguration()
    func setup(_ baseController: UIViewController) {
        OpenWeatherModule(with: baseController).showOpenWeather()
    }
}
