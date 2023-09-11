//
//  ContentView.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 03.09.2023.
//

import SwiftUI

enum Tabs {
    case charackters, location, episodes, saved
}

struct ContentView: View {

    @State private var selection: Tabs = .charackters
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                CharackterMainView()
                    .tag(Tabs.charackters)
                    .tabItem {
                        Label("Charackters", systemImage: "person")
                    }
                EpisodesMainView()
                    .tag(Tabs.episodes)
                    .tabItem {
                        Label("Episodes", systemImage: "tv.fill")
                    }
                LocationsView()
                    .tag(Tabs.location)
                    .tabItem {
                        Label("Locations", systemImage: "location.magnifyingglass")
                    }
                SavedItemsMainView()
                    .tag(Tabs.saved)
                    .tabItem {
                        Label("Saved", systemImage: "bookmark.fill")
                    }
            }.tint(Color.orange)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
