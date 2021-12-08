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
    @Published var timeLeft = 0 // in seconds
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
            
            // logic
            if self.timeLeft == 0 {
                self.isWork.toggle()
                self.resetTimer(workDuration: workDuration, restDuration: restDuration)
            } else if self.timeLeft <= 5 {
                self.last5Sec = true
            }
            
        }
    }
    
    func resetTimer(workDuration: Int, restDuration: Int) {
        self.timer.invalidate()
        self.started = false
        print("setTimer:", self.started)
        
        if self.isWork {
//            self.timeLeft = workDuration // for testing
            timeLeft = workDuration * 60
        } else {
//            self.timeLeft = restDuration // for testing
            timeLeft = restDuration * 60
        }
        self.last5Sec = false
        self.isTimerRunning = false
    }
}
