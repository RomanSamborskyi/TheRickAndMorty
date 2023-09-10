//
//  LocationRowView.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 05.09.2023.
//

import SwiftUI

struct LocationRowView: View {
    
    let model: LocationModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(model.name ?? "No name")
                .font(.title3)
            Text(model.type ?? "")
                .foregroundColor(.gray)
        }
    }
}

struct LocationRowView_Previews: PreviewProvider {
    static var previews: some View {
        LocationRowView(model: LocationModel(id: 1, name: "Earth", type: "type", dimension: "dimension", residents: ["resident1","resident2"], url: "url here", created: "created"))
    }
}
