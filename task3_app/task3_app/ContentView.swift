

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    @ObservedObject var timerManager = TimerManager()
    
    
    @State var timerMode: TimerMode = .initial
    
    @State var selectedPickerIndex = 0
    @State var SecondselectedPickerIndex = 0
    
    let availableMinutes = Array(1...59)
    let availableSecond = Array(1...59)
    
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                
                
                
                
                
                
                
                
                Text(secondsToMinutesAndSeconds(seconds: timerManager.secondsLeft))
                    .font(.system(size: 80))
                    .padding(.top , 80)
                
                Image(systemName: timerManager.timerMode == .running ? "pause.circle.fill": "play.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180 , height: 180)
                    .foregroundColor(.red)
                    .onTapGesture {
                        
                        if self.timerManager.timerMode == .initial {
                            self.timerManager.setTimerLength(minutes: self.availableMinutes[self.selectedPickerIndex]*60)
                        }
                        self.timerManager.timerMode == .running ? self.timerManager.pause() : self.timerManager.start()
                        
                    }
                
                if timerManager.timerMode == .paused {
                    Image(systemName: "gobackward")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .padding(.top , 40) .onTapGesture(perform: {
                            self.timerManager.reset()
                        })
                }
                
                
                
                if timerManager.timerMode == .initial {
                    Picker(selection: $selectedPickerIndex, label: Text("")) {
                        ForEach(0 ..< availableMinutes.count) {
                            Text("\(self.availableMinutes[$0]) min")
                        }
                    }
                    
                }
                
                Spacer()
            }
            .navigationBarTitle("RAMİ")
        }
        .environment(\.colorScheme, .dark)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}







