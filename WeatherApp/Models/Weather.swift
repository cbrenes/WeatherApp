//
//  Weather.swift
//  WeatherApp
//
//  Created by Cesar Brenes on 12/4/22.
//

import Foundation

struct Weather: Decodable {
    let name: String
    let iconURL: URL?
    let temperature: Double
    let description: String?
    let lowTemperature: Double
    let hightTemperature: Double
    let windSpeed: Double
    let windDirection: Double
    
    enum CodingKeys: String, CodingKey {
        case name
        case weather
        case main
        case wind
    }
    
    enum WindCodingKeys: String, CodingKey {
        case speed
        case direction = "deg"
    }
    
    enum MainCodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
    
    enum WeatherCodingKeys: String, CodingKey {
        case icon
        case description
    }
}

extension Weather {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        let wind = try values.nestedContainer(keyedBy: WindCodingKeys.self, forKey: .wind)
        windSpeed = try wind.decode(Double.self, forKey: .speed)
        windDirection = try wind.decode(Double.self, forKey: .direction)
        let main = try values.nestedContainer(keyedBy: MainCodingKeys.self, forKey: .main)
        lowTemperature = try main.decode(Double.self, forKey: .temperatureMin)
        hightTemperature = try main.decode(Double.self, forKey: .temperatureMax)
        temperature = try main.decode(Double.self, forKey: .temperature)
        var weatherList = try values.nestedUnkeyedContainer(forKey: .weather)
        let weather = try weatherList.nestedContainer(keyedBy: WeatherCodingKeys.self) /// we are getting only the first element of the weather list
        description = try weather.decodeIfPresent(String.self, forKey: .description)
        if let iconName = try weather.decodeIfPresent(String.self, forKey: .icon) {
            iconURL = URL(string: "http://openweathermap.org/img/wn/\(iconName)@2x.png")
        } else {
            iconURL = nil
        }
    }
}
