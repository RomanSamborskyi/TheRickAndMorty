//
//  EpisodeModel.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 03.09.2023.
//

import Foundation

struct Charackters: Codable {
    let info: Info?
    let results: [Charackter]?
}

struct Info: Codable {
    let count, pages: Int?
    let next: String?
}

struct Charackter: Identifiable, Codable {
    let id: Int?
      let name, status, species, type: String?
      let gender: String?
      let origin, location: Location?
      let image: String?
      let episode: [String]?
      let url: String?
      let created: String?
      let isSaved: Bool?
    
    mutating func makeSaved(newValue: Bool) -> Charackter {
        return Charackter(id: id, name: name, status: status, species: species, type: type, gender: gender, origin: origin, location: location, image: image, episode: episode, url: url, created: created, isSaved: newValue)
    }
}



struct Location: Codable {
    let name: String?
    let url: String?
}
