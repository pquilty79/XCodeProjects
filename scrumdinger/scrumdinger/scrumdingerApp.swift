//
//  scrumdingerApp.swift
//  scrumdinger
//
//  Created by Patrick Quilty on 6/21/22.
//

import SwiftUI

@main
struct scrumdingerApp: App {
    @StateObject private var store = ScrumStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $store.scrums) {
                    ScrumStore.save(scrums: store.scrums) { result in
                        Task {
                            do {
                                try await ScrumStore.save(scrums: store.scrums)
                            } catch {
                                errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                            }
                        }
                    }
                }
            }
            .task {
                do {
                    store.scrums =  try await ScrumStore.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Scrumdinger will load sample data and continue.")
                }
            }
            .sheet(item: $errorWrapper, onDismiss: {
                store.scrums = DailyScrum.sampleData
            }) { wrapper in
               ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
