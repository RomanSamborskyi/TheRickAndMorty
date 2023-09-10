//
//  SavedItemsMainView.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 07.09.2023.
//

import SwiftUI


enum Saved {
    case charackters, episodes
} 

struct SavedItemsMainView: View {
    
    @StateObject var vm: SavedItemsViewModel = SavedItemsViewModel()
    @State private var selection: Saved = .charackters
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Saved", selection: $selection, content: {
                    Text("Charackters")
                        .tag(Saved.charackters)
                    Text("Episodes")
                        .tag(Saved.episodes)
                }).pickerStyle(.segmented)
                    .padding()
                switch selection {
                case .charackters:
                    SavedCharacktersView(svm: vm)
                case .episodes:
                    SavedEpisodesView(svm: vm)
                }
            }.navigationTitle("Saved")
                .onAppear {
                    vm.getCharakters()
                    vm.getSavedEpisodes()
            }
        }
    }
}

struct SavedItemsMainView_Previews: PreviewProvider {
    static var previews: some View {
        SavedItemsMainView()
    }
}

