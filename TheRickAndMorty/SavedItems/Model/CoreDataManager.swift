//
//  CoreDataManager.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 09.09.2023.
//

import Foundation
import CoreData



class CoreDataManager {
    
    static let instance = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    let containerName: String = "Container"
    let charackterEntityName: String = "CharackterEntity"
    let episodeEntityName: String = "EpisodeEntity"
    
    init() {
        
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error of loading CoreData: \(error)")
            } else {
                print("Succsses of loading CoreData")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error of saving: \(error)")
        }
    }
}
