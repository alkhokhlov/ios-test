//
//  CallListInteractor.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/7/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import Foundation
import Combine

class CallListInteractor: ObservableObject {
    @Published var groupedCalls: [String: [Call]] = [:]
    
    var groupedCallsInbox: [String: [Call]] {
        groupedCalls(by: .inbox)
    }
    
    private var calls: [Call] = [] {
        didSet {
            groupedCalls = groupedCalls(by: .all)
        }
    }
    private let gateway: AirCallGateway
    private let repository: CallRepository
    private var cancellable: Set<AnyCancellable> = []
    
    init(gateway: AirCallGateway, repository: CallRepository) {
        self.gateway = gateway
        self.repository = repository
    }
    
    func loadCalls() {
        let shouldArchivePublishers = repository.fetchAll()
            .filter({ $0.shouldArchive })
            .map({ gateway.archive($0) })
        
        Publishers.Sequence(sequence: shouldArchivePublishers)
            .flatMap({ $0 })
            .collect()
            .flatMap({ _ in
                self.gateway.loadCalls()
            })
            .sink(receiveCompletion: { (completion) in
                if case let Subscribers.Completion.failure(error) = completion {
                    print(error.localizedDescription)
                }
            }) { (values) in
                let calls = values.compactMap({ Call(response: $0) })
                self.repository.save(calls)
                self.loadCached()
            }
            .store(in: &cancellable)
    }
    
    func archive(_ call: Call) {
        gateway.archive(call)
            .sink(receiveCompletion: { (completion) in
                if case let Subscribers.Completion.failure(error) = completion {
                    self.repository.offlineArchive(call)
                    self.loadCached()
                    print(error.localizedDescription)
                }
            }) { (value) in
                if let call = Call(response: value) {
                    self.repository.save([call])
                }
                self.loadCached()
        }
        .store(in: &cancellable)
    }
    
    func reset() {
        repository.reset()
        gateway.reset()
            .sink(receiveCompletion: { (completion) in
                if case let Subscribers.Completion.failure(error) = completion {
                    print(error.localizedDescription)
                }
            }, receiveValue: { (_) in
                self.loadCalls()
            })
            .store(in: &cancellable)
    }
    
    func loadCached() {
        calls = repository.fetchAll()
    }
    
    private func groupedCalls(by callFilter: CallFilter) -> [String: [Call]] {
        var updatedCalls = calls
            .filter({ !$0.isArchived })
            .sorted(by: { $0.createdAt > $1.createdAt })
        if callFilter == .inbox {
            updatedCalls = updatedCalls
                .filter({ $0.direction == .outbound })
        }
        return Dictionary(grouping: updatedCalls) {
            DateConverter.monthDay($0.createdAt)
        }
    }
}


