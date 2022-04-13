//
//  MockedData.swift
//  WeatherApp
//
//  Created by Cesar Brenes on 13/4/22.
//

import Foundation
import Mocker

class MockedData {
    
    public static let currentWeatherResponse: URL = Bundle(for: MockedData.self).url(forResource: "getWeatherResponseSuccess", withExtension: "json")!
}
