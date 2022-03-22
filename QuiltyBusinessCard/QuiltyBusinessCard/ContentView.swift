//
//  ContentView.swift
//  QuiltyBusinessCard
//
//  Created by Patrick Quilty on 3/22/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        ZStack {
            Color(red: 0.04, green: 0.52, blue: 0.89, opacity: 1.0).edgesIgnoringSafeArea(.all)
            VStack {
                Image("patrick.quilty")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 150, alignment: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 5))
                Text("Patrick Quilty")
                    .font(Font.custom("Hurricane-Regular", size: 70))
                    .bold()
                .foregroundColor(.white)
                Text("Java/iOS Developer")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
//                Divider()
                InfoView(image: "phone.fill", text: "+1 908-906-6710")
                InfoView(image: "envelope.fill", text: "patrick.quilty21@gmail.com")
            
            }
        
        }
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct InfoView: View {
    let image: String
    let text: String
    var body: some View {
        VStack {
            Capsule()
                .frame(height: 50, alignment: .center)
                .foregroundColor(.white)
                .overlay(
                    HStack {
                        Image(systemName: image)
                            .foregroundColor(.blue)
                        Text(text)
                                .fontWeight(.semibold)
                        }
                    )
                .font(.system(size: 18))
                .padding(.horizontal)
            .padding(.bottom)
        }

    }
}
