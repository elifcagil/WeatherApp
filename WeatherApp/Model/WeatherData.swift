//
//  Weather.swift
//  WeatherApp
//
//  Created by ELİF ÇAĞIL on 17.04.2025.
//

import Foundation


struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
    let icon: String
}

