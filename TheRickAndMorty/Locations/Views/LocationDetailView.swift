//
//  LocationDetailView.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 05.09.2023.
//

import SwiftUI

struct LocationDetailView: View {
    
    let model: LocationModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                    Text(model.name ?? "no name")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                HStack(alignment: .bottom) {
                    Text("type: ")
                        .foregroundColor(.gray)
                    Text(model.type ?? "no type")
                        .font(.callout)
                }
                HStack(alignment: .bottom) {
                    Text("dimension: ")
                        .foregroundColor(.gray)
                    Text(model.dimension ?? "no dimension")
                        .font(.callout)
                }
                HStack(alignment: .bottom) {
                    Text("url: ")
                        .foregroundColor(.gray)
                    Text(model.url ?? "no dimension")
                        .font(.callout)
                        .lineLimit(1)
                        .minimumScaleFactor(0.4)
                }
                Text("Residents:")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]) {
                    ForEach(model.residents ?? [""], id:\.self) { resident in
                        NavigationLink(destination: {  CharacktersDetailForEpisodesView(url: resident) }, label: { CharacktersView(url: resident).scaleEffect(0.85) })
                    }
                }
            }.padding()
        }
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(model: LocationModel(id: 1, name: "Earth", type: "type", dimension: "dimension", residents: ["https://rickandmortyapi.com/api/character/1","https://rickandmortyapi.com/api/character/2"], url: "url here", created: "created"))
    }
}
