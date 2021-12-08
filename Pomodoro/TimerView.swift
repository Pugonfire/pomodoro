//
//  TimerView.swift
//  pomodoro
//
//  Created by Max Z on 1/12/21.
//

import SwiftUI

struct TimerView: View {
    
//    @State private var isTimerRunning = false
//    @State private var startTime = Date()
//    @State private var timeLeft = 0
//    @State private var last5Sec = false
//    @State private var isWork = true
//    @State private var started = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @ObservedObject var globalTimerModel: TimerModel = TimerModel.sharedInstance
    
    @AppStorage("workDuration") var workDuration = 25
    @AppStorage("restDuration") var restDuration = 5
    @AppStorage("goal") var goal = 10

    var body: some View {
        
        VStack {            
            // Goal Display
            Text("0/\(goal)")
                .font(.headline)
            VStack {
                // Timer Display
                Text("\(self.globalTimerModel.timeLeft/60):\(self.globalTimerModel.timeLeft % 60, specifier: "%.2d")")
            }
//                if TimerModel.started {
//                    Text("\(TimerModel.timeLeft/60):\(TimerModel.timeLeft % 60, specifier: "%.2d")")
//                        .onReceive(timer) { _ in
//                            if TimerModel.timeLeft > 0 && TimerModel.isTimerRunning {
//                                if TimerModel.timeLeft <= 6 {
//                                    TimerModel.last5Sec = true
//                                }
//                                TimerModel.timeLeft -= 1
//                            } else if TimerModel.timeLeft == 0 {
//                                TimerModel.isWork.toggle()
//                                TimerModel.started = false
//                                TimerModel.resetTimer(workDuration: workDuration, restDuration: restDuration)
//                            }
//                        }
//                } else {
//                    // Since duration is always in minutes
//                    if TimerModel.isWork {
//                        Text("\(workDuration):00")
//                    } else {
//                        Text("\(restDuration):00")
//                    }
//                }
//            }
//            .font(.system(size: 60))
//            .foregroundColor(TimerModel.isWork ? (TimerModel.last5Sec ? Color.red : Color.primary) : Color.green)
            
            // Controller
            HStack {
                
                if self.globalTimerModel.isTimerRunning {
                    Button(action: {
                        self.globalTimerModel.pauseTimer()
                    }, label: {
                        Image(systemName: "pause")
                            .foregroundColor(.primary)
                    })
                        .buttonStyle(PlainButtonStyle())
                } else {
                    Button(action: {
                        self.globalTimerModel.startTimer(workDuration: workDuration, restDuration: restDuration)
                    }, label: {
                        Image(systemName: "play")
                            .foregroundColor(.primary)
                            
                    })
                        .buttonStyle(PlainButtonStyle())
                }
                if self.globalTimerModel.isWork {
                    Button(action: {
                        self.globalTimerModel.resetTimer(workDuration: workDuration, restDuration: restDuration)
                    }, label: {
                        Image(systemName: "gobackward")
                    })
                } else {
                    Button(action: {
                        self.globalTimerModel.isWork.toggle() // skip rest
                        self.globalTimerModel.resetTimer(workDuration: workDuration, restDuration: restDuration)
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
//    func pauseTimer() {
//        TimerModel.menubar = "Yah" // Test
//        TimerModel.isTimerRunning = false
//        self.timer.upstream.connect().cancel()
//    }
//
//    func startTimer() {
//        TimerModel.menubar = "Boo" // Test
//        // if starting afresh
//        if !TimerModel.started {
//            resetTimer()
//            TimerModel.started = true
//        }
//
//        print("startTimer:", TimerModel.started)
//        TimerModel.isTimerRunning = true
//        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    }
//
//    func resetTimer() {
//        TimerModel.started = false
//        print("setTimer:", TimerModel.started)
//
//        if TimerModel.isWork {
//            TimerModel.timeLeft = workDuration
////            timeLeft = workDuration * 60
//        } else {
//            TimerModel.timeLeft = restDuration
////            timeLeft = restDuration * 60
//        }
//        TimerModel.last5Sec = false
//        TimerModel.isTimerRunning = false
//    }
    
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
