//
//  ContentView.swift
//  Sowoooo
//
//  Created by Patrick Quilty on 3/22/22.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State var pigNumber = 1
    var body: some View {
        ZStack {
            Color(.systemPink
            ).edgesIgnoringSafeArea(.all)
        
            Button(action: {
                    Sounds.playSounds(soundfile: "449577__zachrau__pigs-oinking.wav")
                self.pigNumber = Int.random(in: 1...9)
                }, label: {
                    PigView(n: pigNumber)
            })
        }
    }
    
    struct IsPressedRegisterStyle : ButtonStyle {
        @Binding var isPressed : Bool
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .onChange(of: configuration.isPressed, perform: {newVal in
                    isPressed = newVal
                })
        }
    }

    struct PigView: View {
        let n : Int
        
        var body: some View {
            Image("pig\(n)").resizable().aspectRatio(1, contentMode: .fit)
        }
    }

}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


