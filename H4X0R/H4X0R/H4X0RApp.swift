//
//  H4X0RApp.swift
//  H4X0R
//
//  Created by Patrick Quilty on 3/23/22.
//

import SwiftUI

@main
struct H4X0RApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
