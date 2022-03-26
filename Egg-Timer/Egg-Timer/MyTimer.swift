//
//  MyTimer.swift
//  Egg-Timer
//
//  Created by Patrick Quilty on 3/26/22.
//

import Foundation

class MyTimer: ObservableObject {
    var timer = Timer()
    @Published var countToUpdate = " "
    func startTimer(secondsRemaining: Int) {
      timer.invalidate()
      var seconds = secondsRemaining
       timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
          if seconds > 0 {
              self.countToUpdate = "\(seconds) seconds"
                seconds = seconds - 1
            } else {
                self.countToUpdate = " "
                Sounds.playSounds(soundfile: "EggTimer_alarm_sound.mp3")
                timer.invalidate()
        }
      }
    }
    
    
    
    
    
    
}

