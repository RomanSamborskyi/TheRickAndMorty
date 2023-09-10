//
//  CharactersForEpisodesVIewModel.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 04.09.2023.
//

import Foundation
import Combine


class CharacktersForEpisodes: ObservableObject {
    
    @Published var charackter: Charackter? = nil
    
    var cancelable = Set<AnyCancellable>()
    let charUrl: String
    
    init(url: String) {
        charUrl = url
        charackters()
    }
    
    func charackters() {
        guard let url = URL(string: charUrl) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(sesinHandler)
            .decode(type: Charackter.self, decoder: JSONDecoder())
            .sink { (_) in
                
            } receiveValue: { [weak self] charackter in
                self?.charackter = charackter
            }
            .store(in: &cancelable)
    }
    private func sesinHandler(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let respons = output.response as? HTTPURLResponse,
              respons.statusCode >= 200 && respons.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
