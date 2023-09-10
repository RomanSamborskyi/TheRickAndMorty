//
//  LocationModel.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 05.09.2023.
//

import Foundation




struct LocationsModel: Codable {
    let info: Info?
    let results: [LocationModel]?
}


struct Info3: Codable {
    let count, pages: Int?
    let next: String?
}


struct LocationModel:Identifiable, Codable {
    let id: Int?
    let name, type, dimension: String?
    let residents: [String]?
    let url: String?
    let created: String?
}
