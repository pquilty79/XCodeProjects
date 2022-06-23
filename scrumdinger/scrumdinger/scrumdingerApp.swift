//
//  scrumdingerApp.swift
//  scrumdinger
//
//  Created by Patrick Quilty on 6/21/22.
//

import SwiftUI

@main
struct scrumdingerApp: App {
    @State private var store = ScrumStore()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $store.scrums) {
                    ScrumStore.save(scrums: store.scrums) { result in
                        if case .failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
            }
            .onAppear {
                ScrumStore.load {
                    result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let scrums):
                        store.scrums = scrums
                        
                    }
                }
            }
        }
    }
}
