//
//  OpenWeatherDataManager.swift
//  OpenWeatherPeiky
//
//  Created by Ibrahimme Morelo on 28/11/2019.
//

import Alamofire

final class OpenWeatherDataManager {
    func some() {
        AF.request("https://httpbin.org/get")
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData { response in
            switch response.result {
            case .success:
                print("Validation Successful")
            case let .failure(error):
                print(error)
            }
        }
    }
}

