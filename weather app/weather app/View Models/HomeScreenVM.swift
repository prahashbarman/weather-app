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

class HomeScreenVM {
    var dayViewModel: DayViewModel?
    var favouriteCities: [String]
    let delegate: HomeScreenVMDelegate?
    
    init(delegate: HomeScreenVMDelegate?) {
        self.delegate = delegate
        var cities: [String] = []
        do {
            let path = Bundle.main.path(forResource: "ManagedCities", ofType: "plist") ?? ""
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            cities = DataParser.shared.parsePlistToFavCitiesArray(data)
        }
        catch {
            print("error found while decoding fav city plist data")
        }
        self.favouriteCities = cities
        do {
            let path = Bundle.main.path(forResource: "HomeWeather", ofType: "plist") ?? ""
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            let weather = DataParser.shared.parsePlistToWeatherData(data)
            getDayViewModel(with: weather) { [weak self] model in
                self?.dayViewModel = model
                self?.delegate?.updateUI()
            }
        }
        catch {
            print("error found while decoding home weather plist data")
        }
    }
    
    func updateHomeCity(_ city: String) {
        getCurrentWeather(for: city)
    }
    
    func updateCurrentWeather(with model: WeatherDataModel) {
        getDayViewModel(with: model) { [weak self] model in
            self?.dayViewModel = model
            self?.delegate?.updateUI()
        }
    }
    
    func getForecastedWeather(for city: String) {
        DispatchQueue.global(qos: .userInteractive).async {
            NetworkManager.shared.getForecastedWeather(for: city) { weather in
                //TODO: Update forecasted weather here
            }
        }
    }
    
    func getCurrentWeather(for city: String) {
        NetworkManager.shared.getCurrentWeather(for: city) { [weak self] weather in
            self?.updateCurrentWeather(with: weather)
        }
    }
    
    func getDayViewModel(with weather: WeatherDataModel?, completion: @escaping (DayViewModel) -> ()) {
        guard let weather = weather else { return }
        
        let imageUrlString = weather.current.condition.icon
        NetworkManager.shared.getWeatherIcon(urlString: imageUrlString) { image in
            let dayViewModel = DayViewModel(
                cityName: weather.location.name,
                currentTemp: weather.current.temp_c,
                weatherDescription: weather.current.condition.text,
                image: image)
            completion(dayViewModel)
        }
    }
}

struct DayViewModel {
    var cityName: String
    var currentTemp: Float
    var weatherDescription: String
    var image: UIImage?
}
