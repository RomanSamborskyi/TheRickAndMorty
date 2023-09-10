//
//  EpisodesViewModel.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 04.09.2023.
//

import Foundation
import Combine

class EpisodesViewModel: ObservableObject {
    
    @Published var episodes: [Episod] = []
    @Published var searchResults: [Episod] = []
    
    var cancellable = Set<AnyCancellable>()
    var searchCancellable = Set<AnyCancellable>()
    
    init() {
        getEpisodes()
    }
    
    func search(for text: String) {
        
        guard let url = URL(string: "https://rickandmortyapi.com/api/episode?name=\(text)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? "") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(sesinHandler)
            .decode(type: Episodes.self, decoder: JSONDecoder())
            .sink { (_) in
                
            } receiveValue: { [weak self] searchResult in
                self?.searchResults = searchResult.results  ?? []
            }
            .store(in: &searchCancellable)
    }
    
    func getEpisodes() {
        
        let totalPages: Int = 3
        
        for currentPage in 1...totalPages {
            guard let url = URL(string: "https://rickandmortyapi.com/api/episode?page=\(currentPage)") else { return }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .receive(on: DispatchQueue.main)
                .tryMap(sesinHandler)
                .decode(type: Episodes.self, decoder: JSONDecoder())
                .sink { complition in
                   // print("Episode complition: \(complition)")
                } receiveValue: { [weak self] episodes in
                    self?.episodes += episodes.results ?? []
                }
                .store(in: &cancellable)
        }
    }
    
    private func sesinHandler(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let respons = output.response as? HTTPURLResponse,
              respons.statusCode >= 200 && respons.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
}
