//
//  SavedItemsViewModel.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 07.09.2023.
//

import Foundation
import SwiftUI
import CoreData

class SavedItemsViewModel: ObservableObject {
    
    let fileManager = LocalFileManager.instance
    let coreData = CoreDataManager.instance
    
    @Published var savedCaharackters: [CharackterEntity] = []
    @Published var savedEpisodes: [EpisodeEntity] = []
    
    init() {
        getCharakters()
        getSavedEpisodes()
    }
    
    func getCharakters() {
        let requset = NSFetchRequest<CharackterEntity>(entityName: coreData.charackterEntityName)
        requset.sortDescriptors = [NSSortDescriptor(keyPath: \CharackterEntity.date, ascending: true)]
        do {
            try savedCaharackters = coreData.context.fetch(requset)
        } catch let error {
            print("Error of fetching charackters: \(error)")
        }
    }
    
    func getSavedEpisodes() {
        
        let request = NSFetchRequest<EpisodeEntity>(entityName: coreData.episodeEntityName)
        
        do {
            try savedEpisodes = coreData.context.fetch(request)
        } catch let error {
            print("Error of fetching saved episodes: \(error)")
        }
    }
    
    func addEpisode(name: String, episode: String, airDate: String) {
        let newEpisode = EpisodeEntity(context: coreData.context)
        newEpisode.name = name
        newEpisode.episode = episode
        newEpisode.airdate = airDate
        save()
    }
    
    func deleteEpisode(index: IndexSet) {
        guard let index = index.first else { return }
        let deletedItem = savedEpisodes[index]
        coreData.context.delete(deletedItem)
        save()
    }
    
    func addCharackter(name: String, episode: String, stauts: String, species: String, location: String, image: String) {
        let newCharackter = CharackterEntity(context: coreData.context)
        newCharackter.name = name
        newCharackter.episode = episode
        newCharackter.status = stauts
        newCharackter.species = species
        newCharackter.locationName = location
        newCharackter.isSaved = false
        newCharackter.date = Date()
        newCharackter.imageURL = image
        save()
    }
    
    func deleteCharakter(index: IndexSet) {
        guard let index = index.first else { return }
        let deletedCharackter = savedCaharackters[index]
        coreData.context.delete(deletedCharackter)
        save()
    }
    
    func save() {
        coreData.save()
        getCharakters()
        getSavedEpisodes()
    }
}
