//
//  WeatherService.swift
//  WeatherIosApp
//
//  Created by Macbook  on 20/05/25.
//

import Foundation
enum WeatherError: Error, LocalizedError {
    case invalidURL
    case invalidResponse

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL."
        case .invalidResponse: return "Unable to fetch data."
        }
    }
}

protocol WeatherServiceProtocol {
    func fetchWeather(for city: String) async throws -> WeatherResponse
}

class WeatherService: WeatherServiceProtocol {
    func fetchWeather(for city: String) async throws -> WeatherResponse {
        let urlString = "\(Constants.apiBaseUrl)?q=\(city)&appid=\(Constants.apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            throw WeatherError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw WeatherError.invalidResponse
        }
        return try JSONDecoder().decode(WeatherResponse.self, from: data)
    }
}
