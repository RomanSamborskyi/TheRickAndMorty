//
//  EpisodesDetailView.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 04.09.2023.
//

import SwiftUI

struct EpisodesDetailView: View {
    
    @StateObject var svm: SavedItemsViewModel = SavedItemsViewModel()
    let model: Episod
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(model.name ?? "NO name")
                        .font(.title)
                        .fontWeight(.bold)
                }.padding(5)
                HStack {
                    Text("episode:")
                        .foregroundColor(.gray)
                    Text(model.episode ?? "NO name")
                }.padding(5)
                HStack {
                    Text("air_date:")
                        .foregroundColor(.gray)
                    Text(model.airDate ?? "NO name")
                }.padding(5)
                HStack {
                    Text("url:")
                        .foregroundColor(.gray)
                    Text(model.url ?? "NO name")
                        .lineLimit(1)
                        .minimumScaleFactor(0.4)
                }.padding(5)
                Text("Characters:")
                    .font(.title2)
                    .fontWeight(.bold)
                LazyVGrid(columns: [GridItem(.flexible(),spacing: 2),GridItem(.flexible(),spacing: 2)]){
                    ForEach(model.characters ?? [], id: \.self) { url in
                        NavigationLink(destination: { CharacktersDetailForEpisodesView(url: url) }, label: {
                            CharacktersView(url: url).scaleEffect(0.88)
                        })
                    }
                }
            }.padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            if !svm.savedEpisodes.contains(where: { $0.id == model.id ?? 0 }) {
                                svm.addEpisode(name: model.name ?? "", episode: model.episode ?? "", airDate: model.airDate ?? "",id: Int16(model.id ?? 0))
                            } else {
                                svm.unsaveEpisode(model: model)
                            }
                        }, label: {
                            Image(systemName:svm.savedEpisodes.contains(where: { $0.id == model.id ?? 0 }) ? "bookmark.fill" : "bookmark")
                        })
                    }
                }
        }
    }
}

struct EpisodesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesDetailView(model: Episod(id: 1, name: "Episode name", airDate: "airDate", episode: "ep1s1", characters: ["https://rickandmortyapi.com/api/character/1","https://rickandmortyapi.com/api/character/2"], url: "episode url", created: "10.10.2020"))
    }
}
