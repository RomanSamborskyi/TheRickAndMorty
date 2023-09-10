//
//  CharakterGridCardView.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 04.09.2023.
//

import SwiftUI

struct CharakterGridCardView: View {
    
    let model: Charackter
    
    var body: some View {
        VStack {
            ImageView(url: model.image ?? "no url", id: "\(String(describing: model.id))", download: model.isSaved ?? false)
            Text(model.name ?? "no name")
                .font(.largeTitle)
                .foregroundColor(.primary)
                .frame(width: 200, height: 60)
                .minimumScaleFactor(0.4)
        }.cornerRadius(25)
    }
}

struct CharakterGridCardView_Previews: PreviewProvider {
    static var previews: some View {
        CharakterGridCardView(model: Charackter(id: 1, name: "Name", status: "Alive", species: "speciis", type: "type", gender: "gender", origin: Location(name: "name", url: "url"), location: Location(name: "name", url: "url"), image: "https://rickandmortyapi.com/api/character/avatar/176.jpeg", episode: ["Episode"], url: "https://rickandmortyapi.com/api/character/176", created: "2017-12-29T18:25:11.930Z", isSaved: false))
    }
}
