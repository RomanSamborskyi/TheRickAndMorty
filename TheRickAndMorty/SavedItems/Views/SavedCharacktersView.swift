//
//  SavedCharacktersView.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 09.09.2023.
//

import SwiftUI

struct SavedCharacktersView: View {
    
    @ObservedObject var svm: SavedItemsViewModel
    
    var body: some View {
        List {
            ForEach(svm.savedCaharackters) { charackter in
                NavigationLink(destination: { SavedCharackterDetailView(model: charackter) }, label: {
                    Text(charackter.name ?? "No name")
                })
            }.onDelete { IndexPath in
                svm.deleteCharakter(index: IndexPath)
            }
        }
    }
}
