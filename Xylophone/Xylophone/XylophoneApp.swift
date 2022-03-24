//
//  XylophoneApp.swift
//  Xylophone
//
//  Created by Patrick Quilty on 3/23/22.
//

import SwiftUI

@main
struct XylophoneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
