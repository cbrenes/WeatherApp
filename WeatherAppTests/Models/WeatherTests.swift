//
//  WeatherTests.swift
//  WeatherAppTests
//
//  Created by Cesar Brenes on 12/4/22.
//

import XCTest
@testable import WeatherApp

class WeatherTests: XCTestCase {

    func testDecodeSuccess() throws {

        guard let jsonFile = JsonHelper.readFile(name: "getWeatherResponseSuccess") else {
            XCTAssertNotNil(nil, "The Json file shouldn't be nil")
            return
        }

        let decoder = JSONDecoder()
        let weather = try decoder.decode(Weather.self, from: jsonFile)

        XCTAssertEqual(weather.name, "Heredia")
        XCTAssertEqual(weather.iconURL?.absoluteString, "http://openweathermap.org/img/wn/10d@2x.png")
        XCTAssertEqual(weather.temperature, 289.61)
        XCTAssertEqual(weather.description, "clear sky")
        XCTAssertEqual(weather.lowTemperature, 287.56)
        XCTAssertEqual(weather.hightTemperature, 292.45)
        XCTAssertEqual(weather.windSpeed, 8.75)
        XCTAssertEqual(weather.windDirection, 270)
    }

    func testDecodeJsonWithoutWeatherKey() throws {

        guard let jsonFile = JsonHelper.readFile(name: "getWeatherResponseSuccess") else {
            XCTAssertNotNil(nil, "The Json file shouldn't be nil")
            return
        }

        var dictionary: [String: Any]?  = try JSONSerialization.jsonObject(with: jsonFile, options: []) as? [String: Any]
        dictionary?.removeValue(forKey: "weather")
        let jsonDataModified = try JSONSerialization.data(withJSONObject: dictionary!, options: .prettyPrinted)

        do {
            let decoder = JSONDecoder()
            _ = try decoder.decode(Weather.self, from: jsonDataModified)
            XCTAssert(false, "The decode should fail")
        } catch {
            XCTAssert(true, "Expected to get an error trying to parse the object")
        }
    }

    func testDecodeJsonWithoutMainKey() throws {

        guard let jsonFile = JsonHelper.readFile(name: "getWeatherResponseSuccess") else {
            XCTAssertNotNil(nil, "The Json file shouldn't be nil")
            return
        }

        var dictionary: [String: Any]?  = try JSONSerialization.jsonObject(with: jsonFile, options: []) as? [String: Any]
        dictionary?.removeValue(forKey: "main")
        let jsonDataModified = try JSONSerialization.data(withJSONObject: dictionary!, options: .prettyPrinted)

        do {
            let decoder = JSONDecoder()
            _ = try decoder.decode(Weather.self, from: jsonDataModified)
            XCTAssert(false, "The decode should fail")
        } catch {
            XCTAssert(true, "Expected to get an error trying to parse the object")
        }
    }

    func testDecodeJsonWithoutWindKey() throws {

        guard let jsonFile = JsonHelper.readFile(name: "getWeatherResponseSuccess") else {
            XCTAssertNotNil(nil, "The Json file shouldn't be nil")
            return
        }

        var dictionary: [String: Any]?  = try JSONSerialization.jsonObject(with: jsonFile, options: []) as? [String: Any]
        dictionary?.removeValue(forKey: "wind")
        let jsonDataModified = try JSONSerialization.data(withJSONObject: dictionary!, options: .prettyPrinted)

        do {
            let decoder = JSONDecoder()
            _ = try decoder.decode(Weather.self, from: jsonDataModified)
            XCTAssert(false, "The decode should fail")
        } catch {
            XCTAssert(true, "Expected to get an error trying to parse the object")
        }
    }


    func testDecodeJsonWithoutNameKey() throws {

        guard let jsonFile = JsonHelper.readFile(name: "getWeatherResponseSuccess") else {
            XCTAssertNotNil(nil, "The Json file shouldn't be nil")
            return
        }

        var dictionary: [String: Any]?  = try JSONSerialization.jsonObject(with: jsonFile, options: []) as? [String: Any]
        dictionary?.removeValue(forKey: "name")
        let jsonDataModified = try JSONSerialization.data(withJSONObject: dictionary!, options: .prettyPrinted)

        do {
            let decoder = JSONDecoder()
            _ = try decoder.decode(Weather.self, from: jsonDataModified)
            XCTAssert(false, "The decode should fail")
        } catch {
            XCTAssert(true, "Expected to get an error trying to parse the object")
        }
    }
}
