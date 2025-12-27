//
//  Model.swift
//  Real Weather App
//
//  Created by Aryan kumar giri on 27/12/25.
//
// MARKS: Weather API Models
import Foundation

struct WeatherResponse: Codable {
    let name: String
    let main: Main
    let weather: [WeatherDetail]
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
}

struct WeatherDetail: Codable {
    let main: String
    let description: String
    let icon: String
}
