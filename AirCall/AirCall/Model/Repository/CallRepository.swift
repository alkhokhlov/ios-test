//
//  CallRepository.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/8/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import Foundation
import CoreData

protocol CallRepository {
    func fetchAll() -> [Call]
    func save(_ calls: [Call])
    func offlineArchive(_ call: Call)
    func reset()
}

class CallRepositoryImpl: CallRepository {
    private let persistanceStore: PersistanceStore
    
    init(persistanceStore: PersistanceStore) {
        self.persistanceStore = persistanceStore
    }
    
    func fetchAll() -> [Call] {
        let entities: [CallEntity] = persistanceStore.fetch(predicate: nil)
        let calls: [Call] = entities.compactMap({ Call(entity: $0) })
        return calls
    }
    
    func save(_ calls: [Call]) {
        for call in calls {
            update(call)
        }
        persistanceStore.saveContext()
    }
    
    func offlineArchive(_ call: Call) {
        if let entity = fetch(call) {
            entity.isArchived = true
            entity.shouldArchive = true
            persistanceStore.saveContext()
        }
    }
    
    func reset() {
        let entities: [CallEntity] = persistanceStore.fetch(predicate: nil)
        entities.forEach({
            persistanceStore.remove($0)
        })
    }
    
    private func fetch(_ call: Call) -> CallEntity? {
        let predicate = NSPredicate(format: "id == %@", "\(call.id)")
        let results: [CallEntity] = persistanceStore.fetch(predicate: predicate)
        return results.first
    }
    
    @discardableResult
    private func getEntity(from call: Call) -> CallEntity {
        let entity: CallEntity
        if let fetchedEntity = fetch(call) {
            entity = fetchedEntity
        } else {
            entity = persistanceStore.create()
            entity.id = Int16(call.id)
        }
        return entity
    }
    
    @discardableResult
    private func update(_ call: Call) -> CallEntity {
        let entity = getEntity(from: call)
        entity.from = call.from
        entity.to = call.to
        entity.via = call.via
        entity.duration = call.duration
        entity.isArchived = call.isArchived
        entity.createdAt = call.createdAt
        entity.direction = call.direction.rawValue
        entity.callType = call.callType.rawValue
        return entity
    }
    
}
