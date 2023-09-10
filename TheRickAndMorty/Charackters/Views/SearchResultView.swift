//
//  SearchResultView.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 05.09.2023.
//

import SwiftUI

struct SearchResultView: View {
    
    let model: Charackter
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment:.top) {
                VStack(alignment: .leading) {
                    Text(model.name ?? "")
                        .font(.title3)
                    HStack(alignment: .center, spacing: 5) {
                        if (model.status ?? "").contains("Alive") {
                            Text("🟢")
                                .font(.caption2)
                        } else {
                            Text("🔴")
                                .font(.caption2)
                        }
                        Text("\(model.status ?? "No stauts") - \(model.gender ?? "No gender")")
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
            }
            Divider()
        }.padding(.horizontal, 10)
        .frame(maxWidth: .infinity)
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(model: Charackter(id: 1, name: "Name", status: "Alive", species: "speciis", type: "type", gender: "gender", origin: Location(name: "name", url: "url"), location: Location(name: "name", url: "url"), image: "https://rickandmortyapi.com/api/character/avatar/176.jpeg", episode: ["Episode"], url: "https://rickandmortyapi.com/api/character/176", created: "2017-12-29T18:25:11.930Z", isSaved: false))
    }
}
