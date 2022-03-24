//
//  ContentView.swift
//  Xylophone
//
//  Created by Patrick Quilty on 3/23/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            VStack {
                Button(action: {
                    Sounds.playSounds(soundfile: "note1.wav")
                }, label: {
                    Text("C")
                        .frame(width: 380, height: 95, alignment: .center)
                        .foregroundColor(.white)
            })
                .background(.blue)
                .cornerRadius(10)
                Button(action:{
                    Sounds.playSounds(soundfile: "note2.wav")
                }, label: {
                    Text("D")
                        .frame(width: 365, height: 95, alignment: .center)
                        .foregroundColor(.white)
            })
                .background(.red)
                .cornerRadius(10)
                Button(action:{
                    Sounds.playSounds(soundfile: "note3.wav")
                }, label: {
                    Text("E")
                        .frame(width: 350, height: 95, alignment: .center)
                        .foregroundColor(.white)
            })
                .background(.yellow)
                .cornerRadius(10)
                Button(action:{
                    Sounds.playSounds(soundfile: "note4.wav")
                }, label: {
                    Text("F")
                        .frame(width: 335, height: 95, alignment: .center)
                        .foregroundColor(.white)
            })
                .background(.purple)
                .cornerRadius(10)
                Button(action:{
                    Sounds.playSounds(soundfile: "note5.wav")
                }, label: {
                    Text("G")
                        .frame(width: 330, height: 95, alignment: .center)
                        .foregroundColor(.white)
            })
                .background(.orange)
                .cornerRadius(10)
                Button(action:{
                    Sounds.playSounds(soundfile: "note6.wav")
                }, label: {
                    Text("A")
                        .frame(width: 315, height: 95, alignment: .center)
                        .foregroundColor(.white)
            })
                .background(.pink)
                .cornerRadius(10)
                Button(action:{
                    Sounds.playSounds(soundfile: "note7.wav")
                }, label: {
                    Text("B")
                        .frame(width: 300, height: 95, alignment: .center)
                        .foregroundColor(.white)
            })
                .background(.green)
                .cornerRadius(10)
            }
        }
        

    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
