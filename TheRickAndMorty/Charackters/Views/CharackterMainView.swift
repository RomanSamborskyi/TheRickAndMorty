//
//  EpisogeMainView.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 03.09.2023.
//

import SwiftUI

struct CharackterMainView: View {
    
    @StateObject var vm: CharacterViewModel = CharacterViewModel()
    @State private var searchText: String = ""
    @State private var startSearch: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                if !startSearch {
                    LazyVGrid(columns: [GridItem(.flexible(),spacing: 2),GridItem(.flexible(),spacing: 2)]){
                        ForEach(vm.charackters) { person in
                            NavigationLink(destination: { PersonageView(model: person)}, label: { CharakterGridCardView(model: person) }).foregroundColor(.black).scaleEffect(0.89)
                        }
                    }
                } else {
                    
                        ForEach(vm.searchResults) { result in
                            NavigationLink(destination: { PersonageView(model: result) }, label: {
                                SearchResultView(model: result)
                            })
                        }
                    
                }
            }
            .navigationTitle("Charackters")
            .searchable(text: $searchText)
            .onChange(of: searchText) { search in
                if search.count > 2 {
                    startSearch = true
                    vm.getSearchResults(for: searchText)
                } else if search.isEmpty {
                    startSearch = false
                    vm.searchResults.removeAll()
                }
            }
        }
    }
}

struct EpisogeMainView_Previews: PreviewProvider {
    static var previews: some View {
        CharackterMainView()
    }
}
