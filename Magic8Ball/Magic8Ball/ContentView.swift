//
//  ContentView.swift
//  Magic8Ball
//
//  Created by Patrick Quilty on 3/23/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
@State var eightBallNumber = 1

    var body: some View {
        ZStack {
            Color(.systemCyan).ignoresSafeArea(.all)
            VStack {
                Text("Ask me anything...")
                    .bold()
                    .foregroundColor(.white)
                    .font(.system(size: 45))
                EightBallView(n: eightBallNumber)
                    .padding()
                Button(action: {
                    self.eightBallNumber = Int.random(in: 1...5)
                }) {
                    Text("Ask Away")
                        .font(.system(size: 50))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding()
                }
                .background(.blue)
                .cornerRadius(50)
                
                
            }
        }

    }


}
struct EightBallView: View {
    let n : Int
    
    var body: some View {
        Image("ball\(n)").resizable().aspectRatio(1, contentMode: .fit)
            .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
