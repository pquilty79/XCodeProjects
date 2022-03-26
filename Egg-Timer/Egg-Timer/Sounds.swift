//
//  Sounds.swift
//  Egg-Timer
//
//  Created by Patrick Quilty on 3/22/22.
//
import AVFoundation

 class Sounds {

   static var audioPlayer:AVAudioPlayer?

   static func playSounds(soundfile: String) {

       if let path = Bundle.main.path(forResource: soundfile, ofType: nil){

           do{

               audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
               audioPlayer?.prepareToPlay()
               audioPlayer?.play()

           }catch {
               print("Error")
           }
       }
    }
     
     
     
     static func stopSounds() {
         audioPlayer?.stop()
     }
 }
