//
//  WeatherDataModel.swift
//  weather app
//
//  Created by Prahash Barman on 25/06/25.
//

import Foundation

struct WeatherDataModel: Codable {
    let location: LocationInfo
    let current: WeatherInfo
}

struct LocationInfo: Codable {
    let name: String
    let region: String
    let country: String
    let localtime: String
}

struct WeatherInfo: Codable {
    let temp_c: Float
    let wind_kph: Float
    let wind_degree: Int
    let precip_mm: Float
    let humidity: Int
    let cloud: Int
    let feelslike_c: Float
    let vis_km: Float
    let uv: Float
}
