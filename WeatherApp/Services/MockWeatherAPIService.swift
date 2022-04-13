//
//  MockWeatherAPIService.swift
//  WeatherApp
//
//  Created by Cesar Brenes on 13/4/22.
//

import Foundation

class MockWeatherAPIService: APIStoreProtocol {
    func fetchWeatherForCurrentLocation(coordinates: Coordinates, completion: @escaping(Result<Weather, WeatherAppError>) -> Void) {
        guard let jsonFile = JsonHelper.readFile(name: "getWeatherResponseSuccess") else {
            completion(.failure(.invalidServerResponse))
            return
        }
        do {
            let decoder = JSONDecoder()
            let weather = try decoder.decode(Weather.self, from: jsonFile)
            completion(.success(weather))
        } catch {
            completion(.failure(.invalidServerResponse))
        }
    }
}
