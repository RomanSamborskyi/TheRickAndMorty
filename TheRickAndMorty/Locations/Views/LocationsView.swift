//
//  LocationsView.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 04.09.2023.
//

import SwiftUI

struct LocationsView: View {
    
    @StateObject var vm: LocationViewModel = LocationViewModel()
    @State private var searchText: String = ""
    @State private var startSearch: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                if !startSearch {
                    ForEach(vm.locations) { location in
                        NavigationLink(destination: { LocationDetailView(model: location) }, label: { LocationRowView(model: location)})
                    }
                } else {
                    ForEach(vm.searchResults) { result in
                        NavigationLink(destination: { LocationDetailView(model: result) }, label: {
                            LocationRowView(model: result)
                        })
                    }
                }
            }.navigationTitle("Locations")
                .searchable(text: $searchText)
                .onChange(of: searchText) { search in
                    if search.count > 2 {
                        startSearch = true
                        vm.getSearchResults(for: searchText)
                    } else {
                        startSearch = false
                        vm.searchResults.removeAll()
                    }
                }
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
    }
}
