//
//  Endpoint+Weather.swift
//  WeatherTracker
//
//  Created by Duarte Santos Lopes on 17/12/2024.
//

import Foundation

extension Endpoint {
    
    static func currentWeather(for city: String) -> Self {
        let queryItems = [
            URLQueryItem(name: "key", value: Endpoint.key),
            URLQueryItem(name: "q", value: city)
        ]
        return Endpoint(path: "current.json", method: .get, queryItems: queryItems)
    }
}
