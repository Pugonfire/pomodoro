//
//  TimerView.swift
//  pomodoro
//
//  Created by Max Z on 1/12/21.
//

import SwiftUI

struct TimerView: View {
    
    @State private var isTimerRunning = false
    @State private var startTime = Date()
    @State private var timeLeft = 0
    @State private var last5Sec = false
    @State private var isWork = true
    @State private var started = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @AppStorage("workDuration") var workDuration = 25
    @AppStorage("restDuration") var restDuration = 5
    @AppStorage("goal") var goal = 10

    var body: some View {
        
        VStack {
            // Test
            Text("\(TimerModel.menubar)")
            
            // Goal Display
            Text("0/\(goal)")
                .font(.headline)
            VStack {
                // Timer Display
                if started {
                    Text("\(timeLeft/60):\(timeLeft % 60, specifier: "%.2d")")
                        .onReceive(timer) { _ in
                            if timeLeft > 0 && isTimerRunning {
                                if timeLeft <= 6 {
                                    last5Sec = true
                                }
                                timeLeft -= 1
                            } else if timeLeft == 0 {
                                isWork.toggle()
                                started = false
                                self.resetTimer()
                            }
                        }
                } else {
                    // Since duration is always in minutes
                    if isWork {
                        Text("\(workDuration):00")
                    } else {
                        Text("\(restDuration):00")
                    }
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
        .frame(width: 200, height: 130)
    }
    func pauseTimer() {
        TimerModel.menubar = "Yah" // Test
        isTimerRunning = false
        self.timer.upstream.connect().cancel()
    }
        
    func startTimer() {
        TimerModel.menubar = "Boo" // Test
        // if starting afresh
        if !started {
            resetTimer()
            started = true
        }
        
        print("startTimer:", started)
        isTimerRunning = true
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    func resetTimer() {
        started = false
        print("setTimer:", started)
        
        if isWork {
            timeLeft = workDuration
//            timeLeft = workDuration * 60
        } else {
            timeLeft = restDuration
//            timeLeft = restDuration * 60
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
        Group {
            TimerView()
        }
    }
}
