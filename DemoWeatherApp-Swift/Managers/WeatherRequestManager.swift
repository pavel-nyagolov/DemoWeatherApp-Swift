//
//  WeatherRequestManager.swift
//  DemoWeatherApp-Swift
//
//  Created by Pavel on 3.04.23.
//

import Foundation

class WeatherRequestManager {
    
    let url: URL?
    
    var weatherModel: [DataType: Any]?
    
    init(location: Location) {
        self.url = URL(string: location.rawValue)
    }
    
    func getWeatherData(){
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) in
            guard let data = data, let receivedData = try? JSONDecoder().decode(Weather.self, from: data) else {
                print("Cannot parse the data")
                return
            }
            
            self.weatherModel = [.weatherCode: receivedData.current_weather.weathercode,
                                 .temperature: receivedData.current_weather.temperature,
                                 .windDirection: receivedData.current_weather.winddirection,
                                 .windSpeed: receivedData.current_weather.windspeed,
                                 .pressure: receivedData.hourly.pressure_msl[0],
                                 .humidity: receivedData.hourly.relativehumidity_2m[0]
            ]
            
            NotificationCenter.default.post(name: .updateDataNotification, object: nil)
        })
        
        task.resume()
    }
    
    func getWeatherCode() -> WeatherCodeType {
        switch Int(weatherModel?[.weatherCode] as? Double ?? 0) {
        case 0:
            return .clearSky
        case 1...3:
            return .cloudy
        case 45...48:
            return .fog
        case 51...57:
            return .drizzle
        case 61...67:
            return .rain
        case 71...77:
            return .snowFall
        case 80...82:
            return .rainShowers
        case 85, 86:
            return .snowShowers
        case 95...99:
            return .thunderstorm
        default:
            return .unknown
        }
    }
}
