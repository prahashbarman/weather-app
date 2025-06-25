//
//  DataParser.swift
//  weather app
//
//  Created by Prahash Barman on 25/06/25.
//

import Foundation

class DataParser {
    static let shared: DataParser = DataParser()
    private init() {}
    
    func parseToWeatherData(_ data: Data) -> WeatherDataModel? {
        do {
            let data = try JSONDecoder().decode(WeatherDataModel.self, from: data)
            //TODO: UPDATE UI - Show data to user
            print(data)
        }
        catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func parsePlistToWeatherData(_ data: Data) -> WeatherDataModel? {
        do {
            let weather = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers ,format: nil) as! [String:Any]
            let location: [String:Any] = weather["location"] as! [String : Any]
            let current: [String:Any] = weather["current"] as! [String : Any]
            let locationInfo: LocationInfo = LocationInfo(name: location["name"] as! String,
                                                          region: location["region"] as! String,
                                                          country: location["country"] as! String,
                                                          localtime: (location["localtime"] as! NSDate).description)
            let currentInfo: WeatherInfo = WeatherInfo(temp_c: (current["temp_c"] as! NSNumber).floatValue,
                                                       wind_kph: (current["wind_kph"] as! NSNumber).floatValue,
                                                       wind_degree: (current["wind_degree"] as! NSNumber).intValue,
                                                       precip_mm: (current["precip_mm"] as! NSNumber).floatValue,
                                                       humidity: (current["humidity"] as! NSNumber).intValue,
                                                       cloud: (current["cloud"] as! NSNumber).intValue,
                                                       feelslike_c: (current["feelslike_c"] as! NSNumber).floatValue,
                                                       vis_km: (current["vis_km"] as! NSNumber).floatValue,
                                                       uv: (current["uv"] as! NSNumber).floatValue)
            let weatherDataModel: WeatherDataModel = WeatherDataModel(location: locationInfo, current: currentInfo)
            return weatherDataModel
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
