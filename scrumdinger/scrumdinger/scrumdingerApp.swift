//
//  scrumdingerApp.swift
//  scrumdinger
//
//  Created by Patrick Quilty on 6/21/22.
//

import SwiftUI

@main
struct scrumdingerApp: App {
    @State private var scrums = DailyScrum.sampleData
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $scrums)
            }
        }
    }
}
