//
//  WeatherServiceProtocol.swift
//  WeatherTracker
//
//  Created by Duarte Santos Lopes on 17/12/2024.
//

import Foundation

protocol NetworkProtocol {
    func fetchWeather(for city: String) async throws -> WeatherResponse
}
