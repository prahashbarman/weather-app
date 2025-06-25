//
//  HomeScreenVM.swift
//  weather app
//
//  Created by Prahash Barman on 25/06/25.
//
import UIKit

protocol HomeScreenVMDelegate: AnyObject {
    func updateUI()
}

struct HomeScreenVM {
    var dayViewModel: DayViewModel?
    var favouriteCities: [String]
    let delegate: HomeScreenVMDelegate?
    
    init(favouriteCities: [String] = [], delegate: HomeScreenVMDelegate?) {
        self.favouriteCities = favouriteCities
        self.delegate = delegate
        do {
            let path = Bundle.main.path(forResource: "HomeWeather", ofType: "plist") ?? ""
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            let weather = DataParser.shared.parsePlistToWeatherData(data)
            dayViewModel = getDayViewModel(with: weather)
        }
        catch {
            print("error found while decoding")
        }
    }
    
    func updateCurrentWeather(with model: WeatherDataModel) {
        delegate?.updateUI()
    }
    
    func getForecastedWeather(for city: String) {
        DispatchQueue.global(qos: .userInteractive).async {
            NetworkManager.shared.getForecastedWeather(for: city) { weather in
                //TODO: Update forecasted weather here
            }
        }
    }
    
    func getCurrentWeather(for city: String) {
        DispatchQueue.global(qos: .userInteractive).async {
            NetworkManager.shared.getCurrentWeather(for: city) { weather in
                updateCurrentWeather(with: weather)
            }
        }
    }
    
    func getDayViewModel(with weather: WeatherDataModel?) -> DayViewModel {
        return DayViewModel(
            cityName: weather?.location.name ?? "Guwahati",
            currentTemp: weather?.current.temp_c ?? 10.0,
            weatherDescription: String(weather?.current.feelslike_c ?? 0.0),
            image: UIImage(named: "rainy")
        )
    }
}

struct DayViewModel {
    var cityName: String
    var currentTemp: Float
    var weatherDescription: String
    var image: UIImage?
}
