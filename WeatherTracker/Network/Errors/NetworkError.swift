//
//  NetworkError.swift
//  WeatherTracker
//
//  Created by Duarte Santos Lopes on 17/12/2024.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidResponse
    case invalidURL
    case decodingError(Error)
    case httpError(statusCode: Int)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response."
        case .invalidURL:
            return "Invalid URL."
        case .decodingError(let error):
            return "Failed to decode the response: \(error.localizedDescription)"
        case .httpError(let statusCode):
            return "HTTP error with status code \(statusCode)."
        }
    }
}
