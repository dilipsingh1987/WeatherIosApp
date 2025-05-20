//
//  ContentView.swift
//  WeatherIosApp
//
//  Created by Macbook  on 20/05/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel()

    var body: some View {
        VStack {
            TextField("Enter city", text: $viewModel.city)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button("Get Weather") {
                Task { await viewModel.fetchWeather() }
            }
            .padding()

            if viewModel.isLoading {
                ProgressView()
            } else if let weather = viewModel.weather {
                WeatherCardView(weather: weather)
            }
        }
        .alert("Error", isPresented: .constant(viewModel.errorMessage != nil), actions: {
            Button("OK", role: .cancel) { viewModel.errorMessage = nil }
        }, message: {
            Text(viewModel.errorMessage ?? "")
        })
        .padding()
    }
}

#Preview {
    ContentView()
}

