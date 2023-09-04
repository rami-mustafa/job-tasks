

import Foundation


public struct Weather {
    
    let city: String
    let temperature: String
    let description: String
    let iconName: String
    
    let max: String
    let min: String

    
    init(response: APIResponse) {
        city = response.name
        temperature = "\(Int(response.main.temp))"
        description = response.weather.first?.description ?? ""
        iconName = response.weather.first?.iconName ?? ""
        max = "\(Int(response.main.temp_max))"
        min = "\(Int(response.main.temp_min))"
    }
    
}
