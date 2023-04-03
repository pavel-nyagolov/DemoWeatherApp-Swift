//
//  Weather.swift
//  DemoWeatherApp-Swift
//
//  Created by Pavel on 3.04.23.
//

import Foundation

struct Weather: Codable {
    var hourly: HourlyWeather
    var current_weather: CurrentWeather
}

struct HourlyWeather: Codable {
    var pressure_msl: [Double]
    var relativehumidity_2m: [Double]
    var temperature_2m: [Double]
    var time: [String]
    var weathercode: [Double]
    var winddirection_10m: [Double]
    var windspeed_10m: [Double]
}

struct CurrentWeather: Codable {
    var temperature: Double
    var time: String
    var weathercode: Double
    var winddirection: Double
    var windspeed: Double
}
