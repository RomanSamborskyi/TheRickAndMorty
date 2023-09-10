//
//  PersonageView.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 03.09.2023.
//

import SwiftUI

struct PersonageView: View {
    
    @StateObject var svm: SavedItemsViewModel = SavedItemsViewModel()
    @State var model: Charackter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ImageView(url: model.image ?? "no url", id: "\(String(describing: model.id))", download: model.isSaved ?? false)
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
            Text(model.location?.name ?? "no location")
            Text("First seen in: ")
                .foregroundColor(.gray)
            Text(model.episode?.first ?? "no episode")
            Spacer()
        }.padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        svm.addCharackter(name: model.name ?? "", episode: model.episode?.first ?? "", stauts: model.status ?? "", species: model.species ?? "", location: model.location?.name ?? "", image: model.image ?? "")
                        model = model.makeSaved(newValue: true)
                    }, label: {
                        Image(systemName:svm.savedCaharackters.contains(where: { $0.name == model.name ?? "" }) ? "bookmark.fill" : "bookmark")
                    })
                }
            }
    }
}

struct PersonageView_Previews: PreviewProvider {
    static var previews: some View {
        PersonageView(model: Charackter(id: 1, name: "Name", status: "Alive", species: "speciis", type: "type", gender: "gender", origin: Location(name: "name", url: "url"), location: Location(name: "name", url: "url"), image: "https://rickandmortyapi.com/api/character/avatar/176.jpeg", episode: ["Episode"], url: "https://rickandmortyapi.com/api/character/176", created: "2017-12-29T18:25:11.930Z", isSaved: false))
    }
}
