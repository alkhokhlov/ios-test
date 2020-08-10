//
//  CallListInteractorTests.swift
//  AirCallTests
//
//  Created by Oleksandr Khokhlov on 8/9/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import XCTest

@testable import AirCall

class CallListInteractorTests: XCTestCase {
    var sut: CallListInteractor!
    var mockRepository: CallRepository!
    var savedCalls = DependencyProviderTests.calls
    var callResponses = DependencyProviderTests.callResponses

    override func setUpWithError() throws {
        let mockRepository = MockCallRepository()
        mockRepository.savedCalls = savedCalls
        self.mockRepository = mockRepository
    }

    override func tearDownWithError() throws {
        sut = nil
        mockRepository = nil
    }

    func testArchiveNoAPIError() throws {
        let mockGateway = MockAirCallGateway(session: URLSession.shared, baseURL: "123")
        mockGateway.callResponses = callResponses
        
        let expectedCalls: ([String: [Call]]) -> Bool = { values in
            if let calls = values[DependencyProviderTests.callKeyValue] {
                return calls.count == 1
            } else {
                return false
            }
        }
        let expectedZeroCalls: ([String: [Call]]) -> Bool = { values in
            return values.keys.count == 0
        }
        
        let sut = CallListInteractor(gateway: mockGateway, repository: mockRepository)
        let result = expectValue(of: sut.$groupedCalls, equals: [
            expectedZeroCalls,
            expectedCalls,
            expectedCalls,
            expectedZeroCalls,
            expectedCalls
        ])
        
        sut.loadCached()
        sut.loadCalls()
        sut.archive(savedCalls[0])
        sut.reset()
        
        wait(for: [result.expectation], timeout: 1)
    }
    
    func testArchiveWithAPIError() throws {
        let mockGateway = MockAirCallGateway(session: URLSession.shared, baseURL: "123", expectedError: APIError.invalidURL)
        mockGateway.callResponses = callResponses
        
        let expectedCalls: ([String: [Call]]) -> Bool = { values in
            if let calls = values[DependencyProviderTests.callKeyValue] {
                return calls.count == 1
            } else {
                return false
            }
        }
        let expectedZeroCalls: ([String: [Call]]) -> Bool = { values in
            return values.keys.count == 0
        }
        
        let sut = CallListInteractor(gateway: mockGateway, repository: mockRepository)
        let result = expectValue(of: sut.$groupedCalls, equals: [
            expectedZeroCalls,
            expectedCalls,
            expectedCalls,
            expectedZeroCalls,
            expectedCalls
        ])
        
        sut.loadCached()
        sut.loadCalls()
        sut.archive(savedCalls[0])
        sut.reset()
        
        wait(for: [result.expectation], timeout: 1)
    }
}
