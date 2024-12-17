//
//  URLSession+Requests.swift
//  WeatherTracker
//
//  Created by Duarte Santos Lopes on 17/12/2024.
//

import Foundation

extension URLSession: NetworkProtocol {
    
    func fetchWeather(for city: String) async throws -> WeatherResponse {
        let endpoint = Endpoint.currentWeather(for: city)
        
        let request: URLRequest
        do {
            request = try endpoint.urlRequest
        } catch {
            throw NetworkError.invalidURL
        }
        
        
        let (data, response) = try await self.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.httpError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1)
        }
        
        do {
            let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
            return weatherResponse
        } catch {
            throw NetworkError.decodingError(error)
        }
        
    }
}
