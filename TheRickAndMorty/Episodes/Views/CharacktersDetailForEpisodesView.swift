//
//  CharacktersDetailForEpisodesView.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 05.09.2023.
//

import SwiftUI

struct CharacktersDetailForEpisodesView: View {
    
    @StateObject var charackters: CharacktersForEpisodes
    
    init(url: String) {
        _charackters = StateObject(wrappedValue: CharacktersForEpisodes(url: url))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let charackter = charackters.charackter {
                ImageView(url: charackter.image ?? "", id: "\(String(describing: charackter.id))", download: charackter.isSaved ?? false)
                Text(charackter.name ?? "no name")
                    .font(.largeTitle)
                Divider()
                HStack(alignment: .center, spacing: 5) {
                    if (charackter.status ?? "").contains("Alive") {
                        Text("🟢")
                            .font(.caption2)
                    } else {
                        Text("🔴")
                            .font(.caption2)
                    }
                    Text("\(charackter.status ?? "No stauts") - \(charackter.species ?? "No gender")")
                }
                Text("Last know location:")
                    .foregroundColor(.gray)
                Text(charackter.location?.name ?? "no location")
                Text("First seen in: ")
                    .foregroundColor(.gray)
                Text(charackter.episode?.first ?? "no episode")
                Spacer()
            }
        }.padding()
    }
}

struct CharacktersDetailForEpisodesView_Previews: PreviewProvider {
    static var previews: some View {
        CharacktersDetailForEpisodesView(url: "https://rickandmortyapi.com/api/character/1")
    }
}
