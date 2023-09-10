//
//  SavedEpisodesView.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 09.09.2023.
//

import SwiftUI

struct SavedEpisodesView: View {
    
    @ObservedObject var svm: SavedItemsViewModel
    
    var body: some View {
        List {
            ForEach(svm.savedEpisodes) { episode in
                VStack(alignment: .leading, spacing: 5) {
                    Text(episode.name ?? "")
                        .font(.callout)
                    HStack {
                        Text(episode.episode ?? "")
                            .font(.caption2)
                            .foregroundColor(.gray)
                        Text(episode.airdate ?? "")
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                  }
            }.onDelete { IndexSet in
                svm.deleteEpisode(index: IndexSet)
            }
        }
    }
}

