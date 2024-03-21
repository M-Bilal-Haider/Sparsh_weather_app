//
//  WeatherData.swift
//  SparshWeatherApp
//
//  Created by Bilal Haider on 21/03/2024.
//

import Foundation

struct WeatherData: Decodable {
    let location: Location
    let current: Current

    struct Location: Decodable {
        let name: String
    }

    struct Current: Decodable {
        let temp_c: Double
        let condition: Condition

        struct Condition: Decodable {
            let text: String
        }
    }
}
