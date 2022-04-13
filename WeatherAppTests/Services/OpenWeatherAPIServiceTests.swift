//
//  OpenWeatherAPIServiceTests.swift
//  WeatherAppTests
//
//  Created by Cesar Brenes on 13/4/22.
//

import XCTest
import Mocker
import Alamofire
@testable import WeatherApp

class OpenWeatherAPIServiceTests: XCTestCase {

    func testRequestToServerSuccess() throws {
        let coordinates = Coordinates(latitude: 34.0194704, longitude: -118.4912273)
        let openWeatherApiService = createOpenWeatherWithMockData()
        let requestExpectation = expectation(description: "Request should finish")
        registerMock(coordinates: coordinates, statusCode: 200)

        var weatherResponse: Weather?
        openWeatherApiService.fetchWeatherForCurrentLocation(coordinates: coordinates) { result in
            switch result {
            case .success(let weather):
                weatherResponse = weather
                requestExpectation.fulfill()
            case .failure:
                requestExpectation.fulfill()
            }
        }
        wait(for: [requestExpectation], timeout: 1)
        XCTAssertNotNil(weatherResponse)
        XCTAssertEqual(weatherResponse?.name, "Heredia")
        XCTAssertEqual(weatherResponse?.iconURL?.absoluteString, "http://openweathermap.org/img/wn/10d@2x.png")
        XCTAssertEqual(weatherResponse?.temperature, 289.61)
        XCTAssertEqual(weatherResponse?.description, "clear sky")
        XCTAssertEqual(weatherResponse?.lowTemperature, 287.56)
        XCTAssertEqual(weatherResponse?.hightTemperature, 292.45)
        XCTAssertEqual(weatherResponse?.windSpeed, 8.75)
        XCTAssertEqual(weatherResponse?.windDirection, 270)
    }

    func testRequestToServerFail() throws {
        let coordinates = Coordinates(latitude: 34.0194704, longitude: -118.4912273)
        let openWeatherApiService = createOpenWeatherWithMockData()
        let requestExpectation = expectation(description: "Request should finish")
        registerMock(coordinates: coordinates, statusCode: 400)

        var weatherResponse: Weather?
        var errorResponse: WeatherAppError?
        openWeatherApiService.fetchWeatherForCurrentLocation(coordinates: coordinates) { result in
            switch result {
            case .success(let weather):
                weatherResponse = weather
                requestExpectation.fulfill()
            case .failure(let error):
                errorResponse = error
                requestExpectation.fulfill()
            }
        }
        wait(for: [requestExpectation], timeout: 1)
        XCTAssertNil(weatherResponse)
        XCTAssertNotNil(errorResponse)
        XCTAssertEqual(errorResponse, .serverError)
    }

    func testRequestToServerNoInternetConnection() throws {
        let coordinates = Coordinates(latitude: 34.0194704, longitude: -118.4912273)
        let requestExpectation = expectation(description: "Request should finish")
        let openWeatherApiService = OpenWeatherAPIService(reachabilityManager: MockNetworkReachabilityManager())

        var weatherResponse: Weather?
        var errorResponse: WeatherAppError?
        openWeatherApiService.fetchWeatherForCurrentLocation(coordinates: coordinates) { result in
            switch result {
            case .success(let weather):
                weatherResponse = weather
                requestExpectation.fulfill()
            case .failure(let error):
                errorResponse = error
                requestExpectation.fulfill()
            }
        }
        wait(for: [requestExpectation], timeout: 1)
        XCTAssertNil(weatherResponse)
        XCTAssertNotNil(errorResponse)
        XCTAssertEqual(errorResponse, .noInternetConnection)
    }

    func createOpenWeatherWithMockData() -> OpenWeatherAPIService {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self]  + (configuration.protocolClasses ?? [])
        return OpenWeatherAPIService(configuration: configuration)
    }

    func registerMock(coordinates: Coordinates, statusCode: Int) {
        let url = OpenWeatherAPIHelper.getServerURL(coordinates: coordinates)
        let mock = Mock(url: URL(string: url)!, dataType: .json, statusCode: statusCode, data: [
            .get : try! Data(contentsOf: MockedData.currentWeatherResponse) // Data containing the JSON response
        ])
        mock.register()
    }
}
