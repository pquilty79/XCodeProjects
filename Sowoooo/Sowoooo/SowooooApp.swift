//
//  SowooooApp.swift
//  Sowoooo
//
//  Created by Patrick Quilty on 3/22/22.
//

import SwiftUI

@main
struct SowooooApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
