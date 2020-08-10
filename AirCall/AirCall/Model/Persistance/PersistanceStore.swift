//
//  CoreDataStack.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/8/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import Foundation
import CoreData
import Combine

protocol PersistanceStore {
    func saveContext()
    func fetch<Entity: NSManagedObject>(predicate: NSPredicate?) -> [Entity]
    func remove<Entity: NSManagedObject>(_ entity: Entity)
    func create<Entity: NSManagedObject>() -> Entity
}

class CoreDataStack: PersistanceStore {
    static let shared = CoreDataStack()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AirCall")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetch<Entity: NSManagedObject>(predicate: NSPredicate?) -> [Entity] {
        let fetchRequest = NSFetchRequest<Entity>(entityName: "\(Entity.self)")
        fetchRequest.predicate = predicate
        do {
            let results = try mainContext.fetch(fetchRequest)
            return results
        } catch {
            fatalError("Failed to fetch category: \(error)")
        }
    }
    
    func map<Entity>(_ map: @escaping (Entity) -> Void) -> Entity where Entity : NSManagedObject {
        let entity = Entity(context: mainContext)
        map(entity)
        return entity
    }
    
    func create<Entity>() -> Entity where Entity : NSManagedObject {
        return Entity(context: mainContext)
    }
    
    func remove<Entity: NSManagedObject>(_ entity: Entity) {
        mainContext.delete(entity)
    }
    
    private init() {}
}
