import Foundation

// MARK: - WeatherResponse
struct WeatherResponse: Codable {
    let location: Location
    let current: CurrentWeather
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let region: String
    let country: String
}

// MARK: - CurrentWeather
struct CurrentWeather: Codable {
    let temp_c: Double
    let feelslike_c: Double
    let humidity: Int
    let uv: Double
    let condition: WeatherCondition
    
    enum CodingKeys: String, CodingKey {
        case temp_c
        case feelslike_c
        case humidity
        case uv
        case condition
    }
}

// MARK: - WeatherCondition
struct WeatherCondition: Codable {
    let text: String
    let icon: String
    
    var fullIconURL: URL? {
        return URL(string: "https:\(icon)")
    }
}
