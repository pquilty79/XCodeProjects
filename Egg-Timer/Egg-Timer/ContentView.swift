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
    @ObservedObject var timer = MyTimer()
    @State var textToUpdate = "How do you like your eggs?"
   
    
    let softTime = 300
    let mediumTime = 420
    let hardTime = 720


    var body: some View {
        ZStack {
            Color(.systemTeal).ignoresSafeArea(.all)
            VStack {
                Text(textToUpdate)
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.top, 20)
                Text(timer.countToUpdate)
                    .foregroundColor(.white)
                    .font(.title)
                
                HStack{
                    Button(action:{
                        textToUpdate = "Soft"
                        timer.startTimer(secondsRemaining: softTime)
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
                    .shadow(radius: 10.0)
                    Button(action:{
                        textToUpdate = "Medium"
                        timer.startTimer(secondsRemaining: mediumTime)
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
                    .shadow(radius: 10.0)
                    Button(action:{
                        textToUpdate = "Hard"
                        timer.startTimer(secondsRemaining: hardTime)
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
                    .shadow(radius: 10.0)
            }
                .padding(.bottom, 60)
                
               
                Button(action:{
                    textToUpdate = "How do you like your eggs?"
                    timer.countToUpdate = " "
                    Sounds.stopSounds()
                    timer.timer.invalidate()
                }, label: {
                    Text("Clear")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                        .frame(width: 100, height: 35)
                        .padding()
                })
                .background(.blue)
                .cornerRadius(50)
                .shadow(radius: 10.0)
            }

    }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewInterfaceOrientation(.portrait)
    }
}
