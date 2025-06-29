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
    
    init(favouriteCities: [String] = [], delegate: HomeScreenVMDelegate?) {
        self.favouriteCities = favouriteCities
        self.delegate = delegate
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
            NetworkManager.shared.getCurrentWeather(for: city) { [weak self] weather in
                self?.updateCurrentWeather(with: weather)
            }
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
