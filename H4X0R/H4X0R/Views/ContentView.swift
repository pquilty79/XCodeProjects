//
//  ContentView.swift
//  H4X0R
//
//  Created by Patrick Quilty on 3/23/22.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            List(networkManager.posts) { post in
                NavigationLink(destination: DetailView(url: post.url)) {
                    HStack {
                        Text(String(post.points))
                        Text(post.title)
                    }
                }

            }
            .navigationTitle("HACKER NEWS")
        }
        .onAppear{
            self.networkManager.fetchData()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
