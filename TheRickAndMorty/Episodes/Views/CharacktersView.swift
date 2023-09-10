//
//  CharacktersView.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 04.09.2023.
//

import SwiftUI

struct CharacktersView: View {
    
    @StateObject var vm: CharacktersForEpisodes
    
    init(url: String) {
        _vm = StateObject(wrappedValue: CharacktersForEpisodes(url: url))
    }
    
    var body: some View {
                if let charackter = vm.charackter {
                    VStack{
                        ImageView(url: charackter.image ?? "", id: "\(String(describing: charackter.id))", download: charackter.isSaved ?? false)
                        Text(charackter.name ?? "")
                            .font(.largeTitle)
                            .foregroundColor(.primary)
                            .frame(width: 200, height: 60)
                            .lineLimit(1)
                            .minimumScaleFactor(0.4)
                    }.padding()
                
        }
    }
}

struct CharacktersView_Previews: PreviewProvider {
    static var previews: some View {
        CharacktersView(url: "https://rickandmortyapi.com/api/character/179")
    }
}
