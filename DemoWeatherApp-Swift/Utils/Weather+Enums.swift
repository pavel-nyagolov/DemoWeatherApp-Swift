//
//  Weather+Enums.swift
//  DemoWeatherApp-Swift
//
//  Created by Pavel on 3.04.23.
//

import Foundation

enum Location: String {
    case varna = "https://api.open-meteo.com/v1/forecast?latitude=43.22&longitude=27.92&hourly=temperature_2m,relativehumidity_2m,weathercode,pressure_msl,windspeed_10m,winddirection_10m&current_weather=true"
    case sofia = "https://api.open-meteo.com/v1/forecast?latitude=42.70&longitude=23.32&hourly=temperature_2m,relativehumidity_2m,weathercode,pressure_msl,windspeed_10m,winddirection_10m&current_weather=true"
    case burgas = "https://api.open-meteo.com/v1/forecast?latitude=42.51&longitude=27.47&hourly=temperature_2m,relativehumidity_2m,weathercode,pressure_msl,windspeed_10m,winddirection_10m&current_weather=true"
}

enum DataType {
    case weatherCode
    case temperature
    case windDirection
    case windSpeed
    case pressure
    case humidity
}

enum WeatherCodeType: String {
    case clearSky = "Clear Sky"
    case cloudy = "Cloudy"
    case fog = "Fog"
    case drizzle = "Drizzle"
    case rain = "Rain"
    case snowFall = "Snow Fall"
    case rainShowers = "Rain Showers"
    case snowShowers = "Snow Showers"
    case thunderstorm = "Thunderstorm"
    case unknown = "Uknown"
}
