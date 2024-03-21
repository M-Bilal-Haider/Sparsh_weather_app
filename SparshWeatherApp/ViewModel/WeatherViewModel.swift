//
//  WeatherViewModel.swift
//  SparshWeatherApp
//
//  Created by Bilal Haider on 21/03/2024.
//
//
import Foundation
import CoreLocation
import Alamofire

class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var weatherData: WeatherData?
    @Published var error: String?
    private var locationManager: CLLocationManager?
    private var locationFetched: Bool = false // Flag to track if location has been fetched
    @Published var isProcessing : Bool = false

    let apiKey = "e9c7a77ffa4f4967908122550242103"
    private var query = ""

    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        isProcessing = true
    }

    func fetchWeatherDataBasedOnLocation() {
        guard !locationFetched else { return } // Check if location has already been fetched
        locationManager?.startUpdatingLocation()
    }

    func fetchWeatherData(forCity city: String) {
        let escapedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        query = "\(escapedCity)"

        fetchWeatherData()
    }

    func fetchWeatherData(forLocation location: CLLocation) {
        query = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
        fetchWeatherData()
    }

    func refreshDara(){
        fetchWeatherData()
    }

    func fetchWeatherData(){
        isProcessing = true
        let urlString = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(query)"

        print(urlString)

        guard let url = URL(string: urlString) else {
            self.error = "Invalid URL"
            return
        }

        AF.request(url).validate().responseDecodable(of: WeatherData.self) { response in
            switch response.result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.weatherData = data
                    self.error = nil
                    self.isProcessing = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = "Unable to fetch weather at moment"
                    self.isProcessing = false
                }
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        fetchWeatherData(forLocation: location)
        locationManager?.stopUpdatingLocation()
        locationFetched = true
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        self.error = error.localizedDescription
    }
}
