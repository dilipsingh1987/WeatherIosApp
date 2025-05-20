//
//  WeatherCardView.swift
//  WeatherIosApp
//
//  Created by Macbook  on 20/05/25.
//

import SwiftUI

struct WeatherCardView: View {
    let weather: WeatherResponse

    var body: some View {
        VStack {
            Text(weather.name)
                .font(.title)
            Text("\(Int(weather.main.temp))°C")
                .font(.largeTitle)
            Text(weather.weather.first?.main ?? "")
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.weather.first?.icon ?? "")@2x.png"))
        }
        .padding()
        .background(Theme.cardBackground)
        .cornerRadius(16)
        .shadow(radius: 4)
    }
}

