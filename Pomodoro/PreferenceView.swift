//
//  PreferenceView.swift
//  pomodoro
//
//  Created by Max Z on 3/12/21.
//

import SwiftUI

struct PreferenceView: View {
    @AppStorage("workDuration") var workDuration = 25
    @AppStorage("restDuration") var restDuration = 5
    @AppStorage("goal") var goal = 10
    
    @State private var changeMade = false
    
    var body: some View {
        VStack {
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Work:")
                    Spacer()
                    Stepper(" \(workDuration.formatted()) min", value: $workDuration, in: 5...120, step: 5)
                }
                
                HStack {
                    Text("Rest:")
                    Spacer()
                    Stepper(" \(restDuration.formatted()) min", value: $restDuration, in: 5...120, step: 5)
                }
                
                HStack {
                    Text("Goal:")
                    Spacer()
                    Stepper(" \(goal.formatted()) sessions", value: $goal, in: 1...120, step: 5)
                }
                
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            Button(action: {
                self.resetSettings()
            }, label: {
                Text("Reset")
            })
        }
        .frame(width: 200, height: 180)
        .navigationTitle("Settings")
    }
    
    func resetSettings() {
        self.workDuration = 25
        self.restDuration = 5
        UserDefaults.standard.set(self.workDuration, forKey: "workDuration")
        UserDefaults.standard.set(self.workDuration, forKey: "restDuration")
    }
    
//    UserDefaults.standard.set(self.tapCount, forKey: "Tap")
}

struct PreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceView()
    }
}
