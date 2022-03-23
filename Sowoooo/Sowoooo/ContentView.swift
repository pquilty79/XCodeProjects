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

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @State private var isPressed : Bool = false
    var body: some View {
        ZStack {
            Color(.systemPink
            ).edgesIgnoringSafeArea(.all)
        
            Button(action: {
                    Sounds.playSounds(soundfile: "449577__zachrau__pigs-oinking.wav")
                }, label: {
                    Image(isPressed ? "maxresdefault": "spotted-baby-pig-_pxfuel").resizable()
                        .frame(height: 300, alignment: .center)
            })
            .buttonStyle(IsPressedRegisterStyle(isPressed: $isPressed))
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


    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


