//
//  MockCoreLocationService.swift
//  WeatherApp
//
//  Created by Cesar Brenes on 13/4/22.
//

import Foundation

class MockCoreLocationService: LocationStoreProtocol {
    
    let error: WeatherAppError?
    let coordinates: Coordinates
    
    init(error: WeatherAppError? = nil, coordinates: Coordinates = Coordinates(latitude: 34.0194704, longitude: -118.4912273)) {
        self.error = error
        self.coordinates = coordinates
    }
    
    func getCurrentLocation(completionHandler:@escaping (Result<Coordinates, WeatherAppError>) -> Void) {
        guard let error = error else {
            completionHandler(.success(coordinates))
            return
        }
        completionHandler(.failure(error))
    }
}
