//
//  CallDetailInteractorTests.swift
//  AirCallTests
//
//  Created by Oleksandr Khokhlov on 8/9/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import XCTest
import Combine

@testable import AirCall

class CallDetailInteractorTests: XCTestCase {
    var sut: CallDetailInteractor!
    var mockRepository: CallRepository!
    var savedCalls = DependencyProviderTests.calls
    var openedCallResponse = DependencyProviderTests.callResponses[0]
    lazy var openedCall = savedCalls[0]

    override func setUpWithError() throws {
        let mockRepository = MockCallRepository()
        mockRepository.savedCalls = DependencyProviderTests.calls
        self.mockRepository = mockRepository
    }

    override func tearDownWithError() throws {
        sut = nil
        mockRepository = nil
    }

    func testArchiveNoAPIError() throws {
        sut = CallDetailInteractor(gateway: MockAirCallGateway(session: URLSession.shared,
                                                               baseURL: "asd"),
                                   repository: mockRepository)
        sut.archive(openedCall)
        let result = expectValue(of: sut.$isArchived, equals: [
            { _ in true }
        ])
        wait(for: [result.expectation], timeout: 1)
    }
    
    func testArchiveWithAPIError() throws {
        sut = CallDetailInteractor(gateway: MockAirCallGateway(session: URLSession.shared,
                                                               baseURL: "asd",
                                                               expectedError: APIError.invalidURL),
                                   repository: mockRepository)
        sut.archive(openedCall)
        let result = expectValue(of: sut.$isArchived, equals: [
            { _ in true }
        ])
        wait(for: [result.expectation], timeout: 1)
    }

}
