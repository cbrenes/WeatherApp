//
//  AlamofireHelper.swift
//  WeatherApp
//
//  Created by Cesar Brenes on 12/4/22.
//

import Foundation
import Alamofire

struct AlamofireHelper {
    
    static let timeOut = 30.0
    
    /**
     This helper creates the URLRequest object necessary to use in the library Alamofire
     - Parameters:
     - parameters: Parameters value, this is a dictionary defined in alamofire library, it could be nil if is necessary
     - requestPath: String value, this is the ulr of the request
     - httpMethod: HTTPMethod value it could be: connect, delete, get, head, options, patch, post, put, trace
     - countryCode: Country code of the tenant or employee. '+' should be included
     - password: Password of the tenant or employee
     - Returns: URLRequest ready with all information contained in the parameters
     */
    static func createRequest(parameters: Parameters?, requestPath: String, httpMethod: HTTPMethod, contentType: String = "application/json") -> URLRequest? {
        guard let requestURL = URL(string: requestPath) else {
            return nil
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = httpMethod.rawValue
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = timeOut
        if let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        return request
    }
}

protocol CustomNetworkReachability {
    var isReachable: Bool { get }
}

extension NetworkReachabilityManager: CustomNetworkReachability {}

class MockNetworkReachabilityManager: CustomNetworkReachability {
    var isReachable: Bool {
        return false
    }
}
