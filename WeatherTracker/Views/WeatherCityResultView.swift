//
//  WeatherCityResultView.swift
//  WeatherTracker
//
//  Created by Duarte Santos Lopes on 18/12/2024.
//

import SwiftUI

 struct WeatherCityResultView: View {
     let cityName: String
     let temperature: String
     let weatherIconURL: URL?
     let onSelect: () -> Void
     
     var body: some View {
         Button(action: onSelect) {
             HStack {
                 VStack(alignment: .leading, spacing: 5) {
                     Text(cityName)
                         .font(.poppinsSemiBold(size: 20))
                         .foregroundColor(Color.primaryForeground)
                     Text("\(temperature)°")
                         .font(.poppinsMedium(size: 60))
                         .foregroundColor(Color.primaryForeground)
                 }
                 
                 Spacer()
                 
                 if let weatherIconURL = weatherIconURL {
                     AsyncImage(url: weatherIconURL) { image in
                         image.resizable()
                             .scaledToFit()
                             .frame(width: 83)
                     } placeholder: {
                         ProgressView()
                     }
                 }
             }
             .padding(.horizontal, 31)
             .padding(.vertical, 16)
             .background(
                 RoundedRectangle(cornerRadius: 12)
                     .fill(Color.white)
                     .shadow(radius: 3)
             )
             .overlay(
                 RoundedRectangle(cornerRadius: 12)
                     .stroke(Color.gray.opacity(0.2))
             )
         }
         .frame(height: 117)
     }
 }
