//
//  TimerView.swift
//  pomodoro
//
//  Created by Max Z on 1/12/21.
//

import SwiftUI

struct TimerView: View {
    @AppStorage("workDuration") var workDuration = 25
    @AppStorage("restDuration") var restDuration = 5
    
    @State var isTimerRunning = false
    @State private var startTime = Date()
    @State private var timeLeft = 25
    @State private var last5Sec = false
    @State private var isWork = true
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        
        VStack {
            // Goal Display
            Text("Goal")
                .font(.title)
            
            // Timer Display
            Text("\(timeLeft/60):\(timeLeft % 60, specifier: "%.2d")")
                .onAppear() {
                    self.resetTimer()
                }
                .onReceive(timer) { _ in
                    if timeLeft > 0 && isTimerRunning {
                        if timeLeft <= 6 {
                            last5Sec = true
                        }
                        timeLeft -= 1
                    } else if timeLeft == 0 {
                        isWork.toggle()
                        self.resetTimer()
                    }
                }
                .font(.system(size: 60))
                .foregroundColor(isWork ? (last5Sec ? Color.red : Color.primary) : Color.green)
            
            // Controller
            HStack {
                
                if isTimerRunning {
                    Button(action: {
                        self.pauseTimer()
                    }, label: {
                        Image(systemName: "pause")
                            .foregroundColor(.primary)
                    })
                        .buttonStyle(PlainButtonStyle())
                } else {
                    Button(action: {
                        self.startTimer()
                    }, label: {
                        Image(systemName: "play")
                            .foregroundColor(.primary)
                            
                    })
                        .buttonStyle(PlainButtonStyle())
                }
                if isWork {
                    Button(action: {
                        self.resetTimer()
                    }, label: {
                        Image(systemName: "gobackward")
                    })
                } else {
                    Button(action: {
                        isWork.toggle() // skip rest
                        self.resetTimer()
                    }, label: {
                        Image(systemName: "multiply")
                    })
                }
                Button(action: {
                    self.openSettings()
                }, label: {
                    Image(systemName: "gear")
                })
            }
            .foregroundColor(.primary)
            .buttonStyle(PlainButtonStyle())
            .font(.system(size: 24))
        }
        .padding()
        .frame(width: 200, height: 150)
    }
    func pauseTimer() {
        isTimerRunning = false
        self.timer.upstream.connect().cancel()
    }
        
    func startTimer() {
        isTimerRunning = true
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    func resetTimer() {
        if isWork {
            timeLeft = workDuration
        } else {
            timeLeft = restDuration
        }
        last5Sec = false
        isTimerRunning = false
    }
    
    func openSettings() {
        NSApp.sendAction(#selector(AppDelegate.openPreferencesWindow), to: nil, from:nil)

    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
