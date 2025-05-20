//
//  WeatherViewModel.swift
//  WeatherIosApp
//
//  Created by Macbook  on 20/05/25.
//

import Foundation
@MainActor
class WeatherViewModel: ObservableObject {
    @Published var city: String = UserDefaults.standard.string(forKey: "lastCity") ?? ""
    @Published var weather: WeatherResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service: WeatherServiceProtocol

    init(service: WeatherServiceProtocol = WeatherService()) {
        self.service = service
        if !city.isEmpty {
            Task { await fetchWeather() }
        }
    }

    func fetchWeather() async {
        guard !city.isEmpty else { return }
        isLoading = true
        errorMessage = nil
        do {
            weather = try await service.fetchWeather(for: city)
            UserDefaults.standard.setValue(city, forKey: "lastCity")
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
