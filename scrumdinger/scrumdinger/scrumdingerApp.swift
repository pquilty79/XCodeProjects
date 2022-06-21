//
//  scrumdingerApp.swift
//  scrumdinger
//
//  Created by Patrick Quilty on 6/21/22.
//

import SwiftUI

@main
struct scrumdingerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: DailyScrum.sampleData)
        }
    }
}
