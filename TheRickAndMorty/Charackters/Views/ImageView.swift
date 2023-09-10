//
//  ImageView.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 03.09.2023.
//

import SwiftUI

struct ImageView: View {
    
    @StateObject var ivm: ImagesDownloader
    @State private var magnifyBy = 1.0
    
    init(url: String, id: String, download: Bool) {
        _ivm = StateObject(wrappedValue: ImagesDownloader(url: url,id: id, download: download))
    }
    
    var body: some View {
        ZStack {
            if ivm.isLoading {
                ProgressView()
                    .frame(width: 200, height: 250)
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
            } else if let image = ivm.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 200, height: 250)
                    .cornerRadius(10)
                    .scaleEffect(magnifyBy)
                    .gesture(MagnificationGesture()
                        .onChanged({ scale in
                            magnifyBy = scale
                        })
                            .onEnded({ _ in
                                magnifyBy = 1.0
                            })
                    )
            }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(url: "https://rickandmortyapi.com/api/character/avatar/176.jpeg", id: "1", download: true)
    }
}
