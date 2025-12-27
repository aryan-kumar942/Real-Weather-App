//
//  ContentView.swift
//  Real Weather App
//
//  Created by Aryan kumar giri on 27/12/25.
//
import SwiftUI
// main user interface for Weather app

struct ContentView: View {

    @StateObject private var vm = WeatherViewModel()
    @State private var cityName = "Delhi"

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.black, .white],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {

                HStack {
                    TextField("Enter city", text: $cityName)
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(14)

                    Button {
                        Task {
                            await vm.fetchWeather(city: cityName)
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .padding(12)
                            .background(.blue.opacity(0.7))
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal)

                Spacer()

                if let weather = vm.weather {
                    WeatherCard(weather: weather)
                }
  //display weather data if available
                if vm.isLoading {
                    ProgressView()
                        .tint(.white)
                }
// display error message if API fails
                if let error = vm.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }

                Spacer()
            }
        }
    }
}

struct WeatherCard: View {
    let weather: WeatherResponse

    var body: some View {
        VStack(spacing: 16) {

            Text(weather.name)
                .font(.largeTitle.bold())
                .foregroundColor(.white)

            if let icon = weather.weather.first?.icon {
                AsyncImage(
                    url: URL(string: "https://openweathermap.org/img/wn/\(icon)@4x.png")
                ) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 140, height: 140)
            }

            Text("\(Int(weather.main.temp))°")
                .font(.system(size: 64, weight: .bold))
                .foregroundColor(.white)

            Text(weather.weather.first?.description.capitalized ?? "")
                .foregroundColor(.white.opacity(0.9))

            Divider()
                .background(.white.opacity(0.4))

            HStack(spacing: 40) {
                InfoTile(
                    title: "Humidity",
                    value: "\(weather.main.humidity)%",
                    icon: "drop.fill"
                )

                InfoTile(
                    title: "Condition",
                    value: weather.weather.first?.main ?? "-",
                    icon: "cloud.sun.fill"
                )
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(28)
        .padding(.horizontal)
    }
}

struct InfoTile: View {
    let title: String
    let value: String
    let icon: String

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .foregroundColor(.white)
            Text(value)
                .foregroundColor(.white)
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
    }
}
