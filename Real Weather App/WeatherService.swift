//
//  WeatherService.swift
//  Real Weather App
//
//  Created by Aryan kumar giri on 27/12/25.
//
import Foundation
//Handle all network calls related to weather data and resposible only for feteching and decoding API responses

     class WeatherService {
    static func fetchWeather(for city: String) async throws -> WeatherResponse {
        let apiKey = "dfa0a8cb18974d8f6d4cfed55a84f9e5"
        let escapedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
// Build the request URL
        let urlString =
        "https://api.openweathermap.org/data/2.5/weather?q=\(escapedCity)&appid=\(apiKey)&units=metric"

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        // decode JSON response into model
        return try JSONDecoder().decode(WeatherResponse.self, from: data)
    }
}
