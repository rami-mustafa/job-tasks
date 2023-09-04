//
//  ContentView.swift
//  task4_app
//
//  Created by Ghaiath Alhereh on 04.09.23.
//

import SwiftUI

struct ContentView: View {
    
    
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.cityName)
                .font(.largeTitle)
                .padding()
        
            Text(viewModel.weatherIcon)
                .font(.system(size: 50))
                .padding()
            
            
            Text(viewModel.temperature)
                .font(.system(size: 30))
                .bold()
            
            Text(viewModel.weatherDescription)
                .padding()
            
            HStack{
                Text(viewModel.tempMax)

                Text(viewModel.tempMin)

            }
        } .onAppear(perform: viewModel.refresh)
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: WeatherViewModel(weatherService: WeatherService()))
    }
}
