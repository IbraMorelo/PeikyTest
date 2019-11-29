//
//  OpenWeatherDataManager.swift
//  OpenWeatherPeiky
//
//  Created by Ibrahimme Morelo on 28/11/2019.
//

import Alamofire

final class OpenWeatherDataManager {
    func requestWeather(lat: String = "",
                        lon: String = "",
                        city: String = "",
                        completionHandler: @escaping (_ openWeatherDetail: OpenWeatherDetail) -> Void,
                        onError: @escaping () -> Void) {
        var url = ""
        if city.isEmpty {
            url = ServiceDefinitions.location(lat: lat, lon: lon)
        } else {
            url = ServiceDefinitions.city(name: city)
        }
        AF.request(url)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: OpenWeatherDetail.self) { response in
                switch response.result {
                case .success:
                    guard let value = response.value else {
                        onError()
                        return
                    }
                    completionHandler(value)
                case .failure:
                    onError()
                }
            }
    }
}

