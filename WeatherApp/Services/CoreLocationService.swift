//
//  CoreLocationService.swift
//  WeatherApp
//
//  Created by Cesar Brenes on 12/4/22.
//

import Foundation
import CoreLocation

class CoreLocationService: NSObject, LocationStoreProtocol {
    
    private var locationManager: CLLocationManager
    private var completionHandler: ((Result<Coordinates, WeatherAppError>) -> Void)?
    private var currentLocation: CLLocation? {
        didSet {
            guard let currentLocation = currentLocation else { return }
            completionHandler?(.success(Coordinates(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)))
            clean()
        }
    }
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = false
        locationManager.activityType = .other
    }
    
    func getCurrentLocation(completionHandler:@escaping (Result<Coordinates, WeatherAppError>) -> Void) {
        guard let currentLocation = currentLocation else {
            self.completionHandler = completionHandler
            locationManager.startUpdatingLocation()
            return
        }
        completionHandler(.success(Coordinates(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)))
        clean()
    }
    
    private func clean() {
        completionHandler = nil
        currentLocation = nil
    }
}

extension CoreLocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
        locationManager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .denied || manager.authorizationStatus == .restricted {
            completionHandler?(.failure(WeatherAppError.invalidLocationPermissions))
            clean()
        }
    }
}

