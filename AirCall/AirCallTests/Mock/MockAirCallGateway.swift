//
//  MockAirCallGateway.swift
//  AirCallTests
//
//  Created by Oleksandr Khokhlov on 8/9/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import Foundation
import Combine

@testable import AirCall

class MockAirCallGateway: AirCallGateway {
    let session: URLSession
    let baseURL: String
    var callResponses: [CallResponse] = []
    
    private let expectedError: APIError?
    
    init(session: URLSession, baseURL: String, expectedError: APIError? = nil) {
        self.session = session
        self.baseURL = baseURL
        self.expectedError = expectedError
    }
    
    func loadCalls() -> AnyPublisher<[CallResponse], Error> {
        return Just(callResponses)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func reset() -> AnyPublisher<DoneResponse, Error> {
        return Just(DoneResponse(message: "done"))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func archive(_ call: Call) -> AnyPublisher<CallResponse, Error> {
        if let expectedError = expectedError {
            return Fail(error: expectedError)
                .eraseToAnyPublisher()
        } else {
            let callResponse = CallResponse(id: call.id,
                                            direction: call.direction.rawValue,
                                            from: call.from,
                                            to: call.to,
                                            via: call.via,
                                            duration: call.duration,
                                            callType: call.callType.rawValue,
                                            createdAt: DateConverter.iso(call.createdAt),
                                            isArchived: true)
            return Just(callResponse)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
