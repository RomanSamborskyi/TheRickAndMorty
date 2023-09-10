//
//  EpisodeViewModel.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 03.09.2023.
//

import Foundation
import Combine


class CharacterViewModel: ObservableObject {
    
    @Published var charackters: [Charackter] = []
    @Published var searchResults: [Charackter] = []
    
    var cancelable = Set<AnyCancellable>()
    var searchCancellable = Set<AnyCancellable>()
    
    init() {
        getEpisodeInfo()
    }
    
    
    func getSearchResults(for text: String) {
        
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/?name=\(text)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? "") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(sesionHandler)
            .decode(type: Charackters.self, decoder: JSONDecoder())
            .sink { complition in
                
            } receiveValue: { [weak self] charackters in
                self?.searchResults = charackters.results ?? []
            }
            .store(in: &searchCancellable)

    }
    
    
    func getEpisodeInfo() {
        
        let currentPage = 42
        
        for currentPage in 1...currentPage {
            guard let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(currentPage)") else { return }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .receive(on: DispatchQueue.main)
                .tryMap(sesionHandler)
                .decode(type: Charackters.self, decoder: JSONDecoder())
                .sink { complition in
                    //print("compition: \(complition)")
                } receiveValue: { [weak self] charackter in
                    self?.charackters += charackter.results ?? []
                }
                .store(in: &cancelable)
        }
    }
    
    func sesionHandler(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
}
