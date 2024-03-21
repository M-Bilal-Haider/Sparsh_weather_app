//
//  WeatherView.swift
//  SparshWeatherApp
//
//  Created by Bilal Haider on 21/03/2024.
//

import SwiftUI

struct WeatherView: View {
    let weatherData: WeatherData

    var body: some View {
        VStack {
            Text("Weather in \(weatherData.location.name)")
                .font(.title)
                .padding()

            Text("Temperature: \(weatherData.current.temp_c.rounded()) °C")
                .padding()

            Text("Condition: \(weatherData.current.condition.text)")
                .padding()

        }
    }
}
