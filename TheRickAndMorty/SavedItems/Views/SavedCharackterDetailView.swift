//
//  SavedCharackterDetailView.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 09.09.2023.
//

import SwiftUI

struct SavedCharackterDetailView: View {
    
    let model: CharackterEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ImageView(url: model.imageURL ?? "no url", id: "\(model.id)", download: model.isSaved)
            
            Text(model.name ?? "no name")
                .font(.largeTitle)
            Divider()
            HStack(alignment: .center, spacing: 5) {
                if (model.status ?? "").contains("Alive") {
                    Text("🟢")
                        .font(.caption2)
                } else {
                    Text("🔴")
                        .font(.caption2)
                }
                Text("\(model.status ?? "No stauts") - \(model.species ?? "No gender")")
            }
            Text("Last know location:")
                .foregroundColor(.gray)
            Text(model.locationName ?? "no location")
            Text("First seen in: ")
                .foregroundColor(.gray)
            Text(model.episode ?? "no episode")
            Spacer()
        }.padding()
    }
}

