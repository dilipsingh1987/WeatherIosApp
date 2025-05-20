//
//  WeatherResponse.swift
//  WeatherIosApp
//
//  Created by Macbook  on 20/05/25.
//

import Foundation
struct WeatherResponse: Codable {
    let name: String
    let main: Main
    let weather: [Weather]

    struct Main: Codable {
        let temp: Double
    }

    struct Weather: Codable {
        let main: String
        let icon: String
    }

    static func stub() -> WeatherResponse {
        WeatherResponse(name: "London", main: .init(temp: 22.0), weather: [.init(main: "Clear", icon: "01d")])
    }
}
