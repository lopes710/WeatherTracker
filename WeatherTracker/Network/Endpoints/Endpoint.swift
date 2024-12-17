//
//  Endpoint.swift
//  WeatherTracker
//
//  Created by Duarte Santos Lopes on 17/12/2024.
//

import Foundation

enum EndpointError: Error {
    case generalError
}

struct Endpoint: Equatable {
    // Should be obscured
    static let key = "5ea786525fae49ffb68213202241712"
    
    enum Verb: String {
        case get = "GET"
        case post = "POST"
        case patch = "PATCH"
        case put = "PUT"
        case delete = "DELETE"
    }

    enum ContentType: Equatable {
        case json
        case imageJpeg
        case imagePng
        case applicationPdf
        case applicationOctetStream
        case multipartFormData(boundary: String)

        var rawValue: String {
            switch self {
            case .json: return "application/json"
            case .imageJpeg: return "image/jpeg"
            case .imagePng: return "image/png"
            case .applicationPdf: return "application/pdf"
            case .applicationOctetStream: return "application/octet-stream"
            case .multipartFormData(let boundary): return "multipart/form-data; boundary=\"\(boundary)\""
            }
        }
    }

    var fullUrl: String?
    var path: String = ""
    var method: Verb = .get
    var queryItems: [URLQueryItem] = []
    var body: Data?
    var contentType: ContentType = .json
}

extension Endpoint {

    private var apiBaseHost: String {
        return "api.weatherapi.com"
    }

    var url: URL {
        var components = URLComponents()

        if let fullUrl = fullUrl,
           let urlComponents = URLComponents(string: fullUrl) {
            components = urlComponents
        } else {
            components.scheme = "https"
            components.host = apiBaseHost
            components.path = "/v1/" + path
        }

        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }

        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }

        return url
    }

    var urlRequest: URLRequest {
        get throws {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.httpBody = body
            request.timeoutInterval = 30

            request.allHTTPHeaderFields = [
                "Time-Zone": TimeZone.current.identifier,
                "Content-Type": contentType.rawValue,
            ]

            return request
        }
    }
}
