

import Foundation

private let defaultIcon = "❓"
private let iconMap = [

    "Drizzle" : "🌨",
    "Thunderstorm" : "🌪 ",
    "Rain" : "🌧",
    "Snow" : "🌨",
    "Clear" : "🌤",
    "Clouds" : "🌥",



]



public class WeatherViewModel  {
    
     var cityName: String = "City Name"
     var temperature: String = "--"
     var weatherDescription: String = "--"
     var weatherIcon: String = defaultIcon
    
    
    
    public let weatherService: WeatherService
    
    
    public init (weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    
    
    public func refresh() {
        weatherService.LoadWeatherData {  weather in
            
            DispatchQueue.main.async {
                self.cityName =  weather.city
                self.temperature = "\( weather.temperature) C"
                self.weatherDescription =  weather.description.capitalized
                self.weatherIcon = iconMap[ weather.iconName] ?? defaultIcon
            }
        }
    }
}
