//
//  WeatherRequester.swift
//  WeatherTracker
//
//  Created by Duarte Santos Lopes on 17/12/2024.
//

import Foundation

class WeatherRequester {
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol = URLSession.shared) {
        self.network = network
    }
    
    // Fetch Weather
    func fetchCurrentWeather(for city: String) async throws -> WeatherResponse {
        return try await network.fetchWeather(for: city)
    }
}

