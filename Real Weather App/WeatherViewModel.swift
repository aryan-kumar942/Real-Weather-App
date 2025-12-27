//
//  WeatherViewModel.swift
//  Real Weather App
//
//  Created by Aryan kumar giri on 27/12/25.
//
import Foundation
import Combine
// view model responsible for managing weather data

@MainActor
class WeatherViewModel: ObservableObject {

    @Published var weather: WeatherResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchWeather(city: String) async {
        isLoading = true
        errorMessage = nil

        do {
            weather = try await WeatherService.fetchWeather(for: city)
        } catch {
            errorMessage = "Failed to load weather"
        }

        isLoading = false
    }
}
