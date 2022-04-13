//
//  OpenWeatherAPIService.swift
//  WeatherApp
//
//  Created by Cesar Brenes on 12/4/22.
//

import Foundation
import Alamofire

class OpenWeatherAPIService: APIStoreProtocol  {
    
    let sessionManager: Session
    let reachabilityManager: CustomNetworkReachability?
    
    // this allows to mock the session using Mocker
    init(configuration: URLSessionConfiguration = URLSessionConfiguration.af.default, reachabilityManager: CustomNetworkReachability? = NetworkReachabilityManager()) {
        sessionManager = Alamofire.Session(configuration: configuration)
        self.reachabilityManager = reachabilityManager
    }
    
    func fetchWeatherForCurrentLocation(coordinates: Coordinates, completion: @escaping(Result<Weather, WeatherAppError>) -> Void) {
        if reachabilityManager?.isReachable ?? false {
            let serverURL = OpenWeatherAPIHelper.getServerURL(coordinates: coordinates)
            guard let request = AlamofireHelper.createRequest(parameters: nil, requestPath: serverURL, httpMethod: .get) else {
                completion(.failure(.invalidURLAPIRequest))
                return
            }
            sessionManager.request(request).validate().responseDecodable(of: Weather.self) { response in
                switch response.result {
                case .success(let weather):
                    completion(.success(weather))
                case .failure:
                    completion(.failure(.serverError))
                }
            }
        } else {
            completion(.failure(.noInternetConnection))
        }
    }
}
