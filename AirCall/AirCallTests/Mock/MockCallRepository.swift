//
//  MockCallRepository.swift
//  AirCallTests
//
//  Created by Oleksandr Khokhlov on 8/9/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import Foundation

@testable import AirCall

class MockCallRepository: CallRepository {
    var savedCalls: [Call] = []
    
    func fetchAll() -> [Call] {
        return savedCalls
    }
    
    func save(_ calls: [Call]) {
        savedCalls = []
        savedCalls.append(contentsOf: calls)
    }
    
    func offlineArchive(_ call: Call) {
        if let index = savedCalls.firstIndex(where: { $0.id == call.id }) {
            savedCalls[index].isArchived = true
            savedCalls[index].shouldArchive = true
        }
    }
    
    func reset() {
        savedCalls = []
    }
}
