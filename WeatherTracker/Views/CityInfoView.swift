//
//  CityInfoView.swift
//  WeatherTracker
//
//  Created by Duarte Santos Lopes on 19/12/2024.
//

import SwiftUI

struct CityInfoView: View {
    private enum Constant {
        static let humidity = "Humidity"
        static let uv = "UV"
        static let feelsLike = "Feels Like"
    }
    
    let iconUrl: URL?
    let cityName: String
    let temperature: String
    let humidity: String
    let uvIndex: String
    let feelsLike: Double
    
    var body: some View {
        VStack(spacing: 20) {
            if let weatherIconURL = iconUrl {
                AsyncImage(url: weatherIconURL) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 123, height: 123)
                } placeholder: {
                    ProgressView()
                }
            }
            
            // City Name and Temperature
            VStack(spacing: 24) {
                HStack {
                    Text(cityName)
                        .font(.poppinsSemiBold(size: 30))
                        .foregroundColor(Color.primaryForeground)
                    Image("Vector")
                        .resizable()
                        .frame(width: 21, height: 21)
                }
                
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text(temperature)
                        .font(.poppinsMedium(size: 70))
                        .foregroundColor(Color.primaryForeground)
                    
                    Text(" °")
                        .font(.poppinsMedium(size: 30))
                        .foregroundColor(Color.primaryForeground)
                        .baselineOffset(35)
                }
            }
            
            // Weather Details Section
            HStack(spacing: 56) {
                weatherDetailView(title: Constant.humidity, value: humidity)
                weatherDetailView(title: Constant.uv, value: uvIndex)
                weatherDetailView(title: Constant.feelsLike, value: "\(String(feelsLike))°")
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.primaryBackground)
            )
            .padding(.all, 16)
        }
    }
    
    @ViewBuilder
    private func weatherDetailView(title: String, value: String) -> some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.poppinsMedium(size: 12))
                .foregroundColor(Color.secondaryForeground)
            Text(value)
                .font(.poppinsMedium(size: 15))
                .foregroundColor(Color.tertiaryForeground)
        }
    }
}
