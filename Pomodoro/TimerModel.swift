//
//  TimerModel.swift
//  pomodoro
//
//  Created by Max Z on 7/12/21.
//

import Foundation

class TimerModel: ObservableObject {
    static let sharedInstance = TimerModel()
    
    @Published var isTimerRunning = false
    @Published var timeLeft = 0
    @Published var last5Sec = false
    @Published var isWork = true
    @Published var started = false
    
    @Published var timer = Timer()
    
    func pauseTimer() {
        self.isTimerRunning = false
        self.timer.invalidate()
    }
        
    func startTimer(workDuration: Int, restDuration: Int) {
        // if starting afresh
        if !self.started {
            resetTimer(workDuration: workDuration, restDuration: restDuration)
            self.started = true
        }
        
        print("startTimer:", self.started)
        self.isTimerRunning = true
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.timeLeft -= 1
        }
    }
    
    func resetTimer(workDuration: Int, restDuration: Int) {
        self.started = false
        print("setTimer:", self.started)
        
        if self.isWork {
            self.timeLeft = workDuration
//            timeLeft = workDuration * 60
        } else {
            self.timeLeft = restDuration
//            timeLeft = restDuration * 60
        }
        self.last5Sec = false
        self.isTimerRunning = false
    }
}
