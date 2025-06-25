//
//  NetworkManager.swift
//  weather app
//
//  Created by Prahash Barman on 25/06/25.
//

import Foundation

class NetworkManager {
    fileprivate static let APIURL: String = "https://api.weatherapi.com/v1/"
    fileprivate static let APIKey: String = "70533dc2df054df3bc371520252506"
    static let shared: NetworkManager = {
        return NetworkManager()
    }()
    
    private init() {}
    
    private func constructURL(requestType: RequestType) -> URL {
        let urlString: String = NetworkManager.APIURL + requestType.getURLParam()
        return URL(string: urlString) ?? URL(fileURLWithPath: "")
    }
    
    func getCurrentWeather(for city: String, completion: @escaping (WeatherDataModel) -> Void) {
        let url: URL = constructURL(requestType: .currentWeather(city: city))
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        getWeatherDataAndParse(for: urlRequest, completion: completion)
    }
    
    func getForecastedWeather(for city: String, completion: @escaping (WeatherDataModel) -> Void) {
        let url: URL = constructURL(requestType: .forecastWeather(city: city))
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        getWeatherDataAndParse(for: urlRequest, completion: completion)
    }
    
    func getWeatherDataAndParse(for urlRequest: URLRequest, completion: @escaping (WeatherDataModel) -> Void) {
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil, let data = data else {
                //TODO: handle error here
                print(error.debugDescription)
                return
            }
            guard let weather: WeatherDataModel = DataParser.shared.parseToWeatherData(data) else { return }
            completion(weather)
        }.resume()
    }
}

enum RequestType {
    case currentWeather(city: String)
    case forecastWeather(city: String)
    case citySearch(query: String)
    
    fileprivate func getURLParam() -> String {
        switch self {
        case let .currentWeather(city):
            return "current.json?key=\(NetworkManager.APIKey)&q=\(city)"
        case let .forecastWeather(city):
            return "forecast.json?key=\(NetworkManager.APIKey)&q=\(city)"
        case let .citySearch(query):
            return "search.json?key=\(NetworkManager.APIKey)&q=\(query)"
        }
    }
}
