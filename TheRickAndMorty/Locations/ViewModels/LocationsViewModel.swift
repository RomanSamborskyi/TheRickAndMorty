//
//  LocationsViewModel.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 05.09.2023.
//

import Foundation
import Combine


class LocationViewModel: ObservableObject {
    
    @Published var locations: [LocationModel] = []
    @Published var searchResults: [LocationModel] = []
    
    var cancelable = Set<AnyCancellable>()
    var searchCancellable = Set<AnyCancellable>()
    
    init() {
        getLocations()
    }
    
    func getSearchResults(for text: String) {
        
        guard let url = URL(string: "https://rickandmortyapi.com/api/location/?name=\(text)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? "") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(sesinHandler)
            .decode(type: LocationsModel.self, decoder: JSONDecoder())
            .sink { complition in
                
            } receiveValue: { [weak self] charackters in
                self?.searchResults = charackters.results ?? []
            }
            .store(in: &searchCancellable)

    }
    
    func getLocations() {
        
        let pages: Int = 7
        
        for currentPage in 1...pages {
            guard let url = URL(string: "https://rickandmortyapi.com/api/location?page=\(currentPage)") else { return }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .subscribe(on: DispatchQueue.global(qos: .background))
                .receive(on: DispatchQueue.main)
                .tryMap(sesinHandler)
                .decode(type: LocationsModel.self, decoder: JSONDecoder())
                .sink { (_) in
                    
                } receiveValue: { [weak self] returnedLocation in
                    self?.locations += returnedLocation.results ?? []
                }
                .store(in: &cancelable)
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
