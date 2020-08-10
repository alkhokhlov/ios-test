//
//  CallDetailInteractor.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/8/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import Foundation
import Combine

class CallDetailInteractor: ObservableObject {
    @Published private(set) var isArchived: Bool
    
    private let gateway: AirCallGateway
    private let repository: CallRepository
    private var cancellable: Set<AnyCancellable> = []
    
    init(gateway: AirCallGateway, repository: CallRepository) {
        self.gateway = gateway
        self.repository = repository
        self.isArchived = false
    }
    
    func archive(_ call: Call) {
        gateway.archive(call)
            .sink(receiveCompletion: { (completion) in
                if case let Subscribers.Completion.failure(error) = completion {
                    self.repository.offlineArchive(call)
                    self.isArchived = true
                    print(error.localizedDescription)
                }
            }) { (value) in
                if let call = Call(response: value) {
                    self.repository.save([call])
                }
                self.isArchived = true
        }
        .store(in: &cancellable)
    }
}
