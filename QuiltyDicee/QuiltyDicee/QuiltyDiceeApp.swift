//
//  QuiltyDiceeApp.swift
//  QuiltyDicee
//
//  Created by Patrick Quilty on 3/22/22.
//

import SwiftUI

@main
struct QuiltyDiceeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
