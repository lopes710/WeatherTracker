//
//  WeatherView.swift
//  WeatherTracker
//
//  Created by Duarte Santos Lopes on 17/12/2024.
//

import SwiftUI

struct WeatherView: View {
    private enum Constant {
        static let searchHorizontalPadding = 24.0
        static let searchLocation = "Search Location"
        static let noCitySelected = "No City Selected"
        static let pleaseSearchCity = "Please Search For A City"
    }
    
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        VStack {
            HStack {
                TextField(Constant.searchLocation, text: $viewModel.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, Constant.searchHorizontalPadding)
            }
            
            Spacer()
            
            if !viewModel.searchResults.isEmpty {
                List(viewModel.searchResults, id: \.location.name) { result in
                    WeatherCityResultView(
                        cityName: result.location.name,
                        temperature: "\(result.current.temp_c)",
                        weatherIconURL: result.current.condition.fullIconURL,
                        onSelect: {
                            viewModel.selectCity(result: result)
                        }
                    )
                    .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
            } else if viewModel.cityName.isEmpty {
                emptyStateView()
            } else {
                CityInfoView(
                    iconUrl: viewModel.iconUrl,
                    cityName: viewModel.cityName,
                    temperature: viewModel.temperature,
                    humidity: viewModel.humidity,
                    uvIndex: viewModel.uvIndex,
                    feelsLike: viewModel.feelsLike
                )
            }
            
            Spacer()
            
        }
    }
    
    @ViewBuilder
    private func emptyStateView() -> some View {
        VStack {
            Text(Constant.noCitySelected)
                .font(.poppinsSemiBold(size: 30))
                .foregroundColor(Color.primaryForeground)
            
            Spacer().frame(height: 10)
            
            Text(Constant.pleaseSearchCity)
                .font(.poppinsSemiBold(size: 15))
                .foregroundColor(Color.primaryForeground)
        }
        .multilineTextAlignment(.center)
    }
}

#Preview {
    WeatherView()
}
