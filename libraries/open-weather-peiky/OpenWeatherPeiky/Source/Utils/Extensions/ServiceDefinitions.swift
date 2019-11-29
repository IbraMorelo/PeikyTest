//
//  ServiceDefinitions.swift
//  OpenWeatherPeiky
//
//  Created by Ibrahimme Morelo on 11/28/19.
//

import Foundation

class ServiceDefinitions: NSObject {
    private static var baseURL = "https://api.openweathermap.org/data/2.5/weather?"
    private static var key = "d7e6204225106a26ef35751b8e152076"
    
    static func city(name: String) -> String {
        return String(format: "%@q=%@&appid=%@&units=metric&lang=es", baseURL, name, key)
    }
    
    static func location(lat: String, lon: String) -> String {
        return String(format: "%@lat=%@&lon=%@&appid=%@&units=metric&lang=es", baseURL, lat, lon, key)
    }
    
    static func iconImage(name: String) -> String {
        return String(format: "%@%@.png", "https://openweathermap.org/img/w/", name)
    }
}
