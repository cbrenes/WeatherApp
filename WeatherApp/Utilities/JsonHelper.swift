//
//  JsonHelper.swift
//  WeatherApp
//
//  Created by Cesar Brenes on 12/4/22.
//

import Foundation

struct JsonHelper {
    
    static func readFile(name: String) -> Data? {
        if let url = Bundle.main.url(forResource: name, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
