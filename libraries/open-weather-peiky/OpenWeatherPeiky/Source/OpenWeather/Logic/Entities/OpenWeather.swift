//
//  OpenWeather.swift
//  OpenWeatherPeiky
//
//  Created by Ibrahimme Morelo on 28/11/2019.
//

struct OpenWeatherDetail: Decodable {
    var weather: [OpenWeather]
    var name: String
}

struct OpenWeather: Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}
