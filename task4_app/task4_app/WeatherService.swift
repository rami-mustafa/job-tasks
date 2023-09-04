

import Foundation
import CoreLocation


public final class WeatherService: NSObject {
    
    
    private let locationManager = CLLocationManager()
    private let API_KEY = "a6ca8e91088a21012d7917d0753e0796"
    private var completionHandaler: ((Werather) -> Void)?
    
    
    public override init() {
        super.init()
        locationManager.delegate = self
    }
    
    
    
    public func LoadWeatherData(_ completionHandaler: @escaping((Werather) -> Void) ){
        
        self.completionHandaler = completionHandaler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //    https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D) {
        
        
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon={\(coordinates.longitude)&appid=\(API_KEY)&units=metric"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        
        guard let url = URL(string: urlString ) else { return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil , let data = data else {return}
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
                self.completionHandaler?(Werather(response: response))
            }
        }.resume()
    }
}


extension WeatherService : CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager,didUpdateLocations Locations: [CLLocation] ) {
        
        guard let location = Locations.first else {return}
        makeDataRequest(forCoordinates: location.coordinate)
    }
    
    
    public func locationManager(_ manager: CLLocationManager,didFailWithError error:Error  ) {
        
        
        print("Something went Wrong \(error.localizedDescription)")
    }
}





struct APIResponse: Decodable {
    
    let name: String
    let main: APIMain
    let weather: [APIWeather]
}


struct APIMain:Decodable {
    
    let temp: Double
    
}


struct APIWeather: Decodable {
    
    let description: String
    let iconName: String
    
    
    enum CodingKeys: String , CodingKey {
        
        case description
        case iconName = "main"
        
    }
    
    
    
}
