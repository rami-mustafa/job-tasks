

import Foundation

private let defaultIcon = "❓"
private let iconMap = [
  "Drizzle" : "🌧",
  "Thunderstorm" : "☀️☀️",
  "Rain": "🌧",
  "Snow": "❄️",
  "Clear": "☀️",
  "Clouds" : "☁️",
]



public class WeatherViewModel : ObservableObject {
    
    @Published var cityName: String = "City Name"
    @Published var temperature: String = "--"
    @Published var weatherDescription: String = "--"
    @Published var weatherIcon: String = defaultIcon
    @Published var tempMax: String = "--"
    @Published var tempMin: String = "--"

    
    
    
    public let weatherService: WeatherService
    
    
    public init (weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    
    
    public func refresh() {
        weatherService.LoadWeatherData {  weather in
            
            DispatchQueue.main.async {
                self.cityName =  weather.city
                self.temperature = "\( weather.temperature) ºC"
                self.weatherDescription =  weather.description.capitalized
                self.weatherIcon = iconMap[ weather.iconName] ?? defaultIcon
                self.tempMax =  "Max :\( weather.max)ºC "
                self.tempMin =  "Min :\( weather.min)ºC "
            }
        }
    }
}
