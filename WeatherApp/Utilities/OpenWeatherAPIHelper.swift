//
//  OpenWeatherAPIHelper.swift
//  WeatherApp
//
//  Created by Cesar Brenes on 12/4/22.
//

import Foundation

struct OpenWeatherAPIHelper {
    
    private static let weatherRootURL = "https://api.openweathermap.org/data/2.5/weather?"
    
    static func getServerURL(coordinates: Coordinates) -> String {
        return "\(weatherRootURL)lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(Keys.openWeatherApiKey)"
    }
}
