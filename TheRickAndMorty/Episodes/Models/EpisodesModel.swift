//
//  EpisodesModel.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 04.09.2023.
//

import Foundation


struct Episodes: Codable {
    let info: Info2?
    let results: [Episod]?
}


struct Info2: Codable {
    let count, pages: Int?
    let next: String?
}


struct Episod: Identifiable, Codable {
    let id: Int?
    let name, airDate, episode: String?
    let characters: [String]?
    let url: String?
    let created: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}
