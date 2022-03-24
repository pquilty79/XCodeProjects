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
                        .foregroundColor(.black)
            })
                .background(.blue)
                .cornerRadius(10)
                .buttonStyle(MyPrimitiveButtonStyle())
                
                
                Button(action:{
                    Sounds.playSounds(soundfile: "note2.wav")
                }, label: {
                    Text("D")
                        .frame(width: 365, height: 95, alignment: .center)
                        .foregroundColor(.black)
            })
                .background(.red)
                .cornerRadius(10)
                .buttonStyle(MyPrimitiveButtonStyle())
                
                Button(action:{
                    Sounds.playSounds(soundfile: "note3.wav")
                }, label: {
                    Text("E")
                        .frame(width: 350, height: 95, alignment: .center)
                        .foregroundColor(.black)
            })
                .background(.yellow)
                .cornerRadius(10)
                .buttonStyle(MyPrimitiveButtonStyle())
                
                Button(action:{
                    Sounds.playSounds(soundfile: "note4.wav")
                }, label: {
                    Text("F")
                        .frame(width: 335, height: 95, alignment: .center)
                        .foregroundColor(.black)
            })
                .background(.purple)
                .cornerRadius(10)
                .buttonStyle(MyPrimitiveButtonStyle())
                
                Button(action:{
                    Sounds.playSounds(soundfile: "note5.wav")
                }, label: {
                    Text("G")
                        .frame(width: 330, height: 95, alignment: .center)
                        .foregroundColor(.black)
            })
                .background(.orange)
                .cornerRadius(10)
                .buttonStyle(MyPrimitiveButtonStyle())
                
                Button(action:{
                    Sounds.playSounds(soundfile: "note6.wav")
                }, label: {
                    Text("A")
                        .frame(width: 315, height: 95, alignment: .center)
                        .foregroundColor(.black)
            })
                .background(.pink)
                .cornerRadius(10)
                .buttonStyle(MyPrimitiveButtonStyle())
                
                Button(action:{
                    Sounds.playSounds(soundfile: "note7.wav")
                }, label: {
                    Text("B")
                        .frame(width: 300, height: 95, alignment: .center)
                        .foregroundColor(.black)
            })
                .background(.green)
                .cornerRadius(10)
                .buttonStyle(MyPrimitiveButtonStyle())
            }
        }
        

    }

}

struct MyPrimitiveButtonStyle: PrimitiveButtonStyle {

    func makeBody(configuration: PrimitiveButtonStyle.Configuration) -> some View {
        MyButton(configuration: configuration)
    }

    struct MyButton: View {
        @GestureState private var pressed = false

        let configuration: PrimitiveButtonStyle.Configuration
//        let color: Color = .green

        @State private var didTriggered = false

        var body: some View {
            // you can set minimumDuration to Double.greatestFiniteMagnitude if you think that
            // user can hold button for such a long time
            let longPress = LongPressGesture(minimumDuration: 300, maximumDistance: 300.0)
                .updating($pressed) { value, state, _ in
                    state = value
                    self.configuration.trigger()
            }

            return configuration.label
                .background(.white)
                .opacity(pressed ? 0.0 : 0.4)
                .gesture(longPress)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
