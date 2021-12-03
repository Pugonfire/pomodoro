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
    
    var body: some View {
        VStack{
            Text(Image(systemName: "gear"))
                .font(.system(size: 80))
                .frame(height: 100.0)
                
            Stepper("Work Duration: \(workDuration.formatted()) min", value: $workDuration, in: 5...120, step: 5)
            Stepper("Rest Duration: \(restDuration.formatted()) min", value: $restDuration, in: 5...120, step: 5)
            Stepper("Daily Goal: \(goal.formatted()) sessions", value: $goal, in: 1...120, step: 5)
            
            Spacer()
                .frame(height: 40.0)
            HStack {
                Button(action: {
//                    self.saveSettings()
                }, label: {
                    Text("Save")
                }).keyboardShortcut(.defaultAction)
                Button(action: {
//                    self.resetSettings()
                }, label: {
                    Text("Reset")
                })
            }
        }
        .frame(width: 200, height: 250)
    }
    func saveSettings() {
        UserDefaults.standard.set(self.workDuration, forKey: "workDuration")
        UserDefaults.standard.set(self.restDuration, forKey: "restDuration")
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
