//
//  EpisodesMainView.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 04.09.2023.
//

import SwiftUI

struct EpisodesMainView: View {
    
    @StateObject var vm: EpisodesViewModel = EpisodesViewModel()
    @State private var searchText: String = ""
    @State private var startSearch: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                if !startSearch {
                    ForEach(vm.episodes){ episode in
                        NavigationLink(destination: {EpisodesDetailView(model: episode) }, label: {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(episode.name ?? "No name")
                                    .font(.title3)
                                Text(episode.episode ?? "")
                                    .foregroundColor(.gray)
                            }
                        })
                    }
                } else {
                    ForEach(vm.searchResults) { result in
                        NavigationLink(destination: { EpisodesDetailView(model: result) }, label: {
                            HStack(alignment:.top) {
                                VStack(alignment: .leading) {
                                    Text(result.name ?? "")
                                        .font(.title3)
                                    Text(result.episode ?? "")
                                        .foregroundColor(.gray)
                                }
                            }
                        })
                    }
                }
            }.navigationTitle("Episodes")
                .searchable(text: $searchText)
                .onChange(of: searchText){ search in
                    if search.count > 2 {
                        startSearch = true
                        vm.search(for: searchText)
                    } else if search.isEmpty {
                        startSearch = false
                        vm.searchResults.removeAll()
                    }
                }
        }
    }
}

struct EpisodesMainView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesMainView()
    }
}
