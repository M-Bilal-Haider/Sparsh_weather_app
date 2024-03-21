//
//  ContentView.swift
//  SparshWeatherApp
//
//  Created by Bilal Haider on 21/03/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var cityName: String = ""

    var body: some View {
        VStack {
            if let weatherData = viewModel.weatherData {
                WeatherView(weatherData: weatherData)
            } else {
                Text("No weather data available")
            }


            Button("refresh") {
                refreshWeatherData()
            } 

            TextField("Enter city name", text: $cityName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if let error = viewModel.error {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }

            Button("Fetch") {
                fetchWeatherData()
            }
            .padding()
        }

        .padding()
        .onAppear {
            viewModel.fetchWeatherDataBasedOnLocation()
        }
        .overlay{
            if(viewModel.isProcessing) {
                ProgressView()
            }
        }
    }

    func fetchWeatherData() {
        viewModel.fetchWeatherData(forCity: cityName)
    }

    func refreshWeatherData(){
        viewModel.refreshDara()
    }
}

#Preview {
    ContentView()
}
