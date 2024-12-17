//
//  WeatherViewModel.swift
//  WeatherTracker
//
//  Created by Duarte Santos Lopes on 17/12/2024.
//

import Foundation

class WeatherViewModel: ObservableObject {
    private let weatherRequester = WeatherRequester()
    private var searchTask: Task<Void, Never>?
    private let savedCityKey = "selectedCity"
    
    @Published var searchText: String = "" {
        didSet {
            debounceSearch(for: searchText)
        }
    }
    
    @Published var searchResults: [WeatherResponse] = []
    @Published var iconUrl: URL?
    @Published var cityName: String = ""
    @Published var temperature: String = ""
    @Published var weatherCondition: String = ""
    @Published var humidity: String = ""
    @Published var uvIndex: String = ""
    @Published var feelsLike: Double = 0.0
        
    init() {
        loadSavedCity()
    }
    
    private func debounceSearch(for city: String) {
        searchTask?.cancel()
        
        searchTask = Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            
            guard !Task.isCancelled, !city.isEmpty else { return }
            
            await fetchWeather(for: city)
        }
    }
    
    private func fetchWeather(for city: String) async {
        do {
            let weatherResponse = try await weatherRequester.fetchCurrentWeather(for: city)
            
            Task { @MainActor in
                self.searchResults = [weatherResponse]
            }
        } catch {
            Task { @MainActor in
                self.searchResults = []
            }
            print("Error fetching weather: \(error.localizedDescription)")
        }
    }
    
    func selectCity(result: WeatherResponse) {
        // Save to userdefaults
        UserDefaults.standard.setValue(result.location.name, forKey: savedCityKey)
        
        // Update main weather display
        cityName = result.location.name
        temperature = "\(result.current.temp_c)"
        weatherCondition = result.current.condition.text
        humidity = "\(result.current.humidity)%"
        uvIndex = "\(result.current.uv)"
        iconUrl = result.current.condition.fullIconURL
        feelsLike = result.current.feelslike_c
        
        // Clear results after selection
        searchResults.removeAll()
    }
    
    private func loadSavedCity() {
        guard let savedCity = UserDefaults.standard.string(forKey: savedCityKey) else { return }
        
        // Fetch weather data using async Task
        Task { @MainActor in
            do {
                let weatherResponse = try await weatherRequester.fetchCurrentWeather(for: savedCity)
                self.selectCity(result: weatherResponse)
            } catch {
                print("Error fetching weather for saved city: \(error.localizedDescription)")
                self.searchResults = [] // Clear search results if an error occurs
            }
        }
    }
}
