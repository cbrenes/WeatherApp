//
//  Errors.swift
//  WeatherApp
//
//  Created by Cesar Brenes on 12/4/22.
//

import Foundation

enum WeatherAppError: Error {
    case invalidLocationPermissions
    case invalidURLAPIRequest
    case invalidServerResponse
    case serverError
    case noInternetConnection
}
