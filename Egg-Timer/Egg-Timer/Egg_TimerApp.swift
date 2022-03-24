//
//  Egg_TimerApp.swift
//  Egg-Timer
//
//  Created by Patrick Quilty on 3/24/22.
//

import SwiftUI

@main
struct Egg_TimerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
