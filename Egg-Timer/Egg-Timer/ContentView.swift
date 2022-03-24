//
//  ContentView.swift
//  Egg-Timer
//
//  Created by Patrick Quilty on 3/24/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State var textToUpdate = "How do you like your eggs?"
    
    func fireTime(Timer: Timer) {
        print("Timer fired!")
        
    }
    let softTime = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in
        Sounds.playSounds(soundfile: "EggTimer_alarm_sound.mp3")
    }
    let mediumTime = Timer.scheduledTimer(withTimeInterval: 420.0, repeats: false) { timer in
        Sounds.playSounds(soundfile: "EggTimer_alarm_sound.mp3")
    }
    let hardTime = Timer.scheduledTimer(withTimeInterval: 720.0, repeats: false) { timer in
        Sounds.playSounds(soundfile: "EggTimer_alarm_sound.mp3")
    }

    var body: some View {
        ZStack {
            Color(.systemTeal).ignoresSafeArea(.all)
            VStack {
                Text(textToUpdate)
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.bottom, 40)
                    .padding(.top, 20)
                HStack{
                    Button(action:{
                        textToUpdate = "Soft"
                        fireTime(Timer: softTime)
        
                    }, label: {
                        ZStack {
                        Image("soft_egg")
                            .resizable()
                            .frame(width: 100, height: 130)
                        Text("Soft")
                                .foregroundColor(.white)
                                .font(.title2)
                                .bold()
                        }
                        })
                    Button(action:{
                        textToUpdate = "Medium"
                        fireTime(Timer: mediumTime)
                    }, label: {
                        ZStack {
                        Image("medium_egg")
                            .resizable()
                            .frame(width: 100, height: 130)
                        Text("Medium")
                                .foregroundColor(.white)
                                .font(.title2)
                                .bold()
                        }
                        })
                    Button(action:{
                        textToUpdate = "Hard"
                        fireTime(Timer: hardTime)
                    }, label: {
                        ZStack {
                        Image("hard_egg")
                            .resizable()
                            .frame(width: 100, height: 130)
                        Text("Hard")
                                .foregroundColor(.white)
                                .font(.title2)
                                .bold()
                        }
                        })
            }
                .padding(.bottom, 60)
        }
    }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewInterfaceOrientation(.portrait)
    }
}
