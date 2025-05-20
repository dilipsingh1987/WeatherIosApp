//
//  WeatherViewModelTests.swift
//  WeatherIosApp
//
//  Created by Macbook  on 20/05/25.
//

import XCTest
@testable import WeatherIosApp

final class WeatherViewModelTests: XCTestCase {
    class MockWeatherService: WeatherServiceProtocol {
        func fetchWeather(for city: String) async throws -> WeatherResponse {
            return WeatherResponse.stub()
        }
    }

    func testFetchWeatherSuccess() async throws {
        let viewModel = await WeatherViewModel(service: MockWeatherService())
        
        await MainActor.run {
               viewModel.city = "London"
           }

           await viewModel.fetchWeather()
        await MainActor.run {
                XCTAssertNotNil(viewModel.weather)
                XCTAssertEqual(viewModel.weather?.name, "London")
            }
    }
}

