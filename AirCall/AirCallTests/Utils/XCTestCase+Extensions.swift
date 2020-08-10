//
//  File.swift
//  AirCallTests
//
//  Created by Oleksandr Khokhlov on 8/9/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import XCTest
import Combine

extension XCTestCase {
    typealias CompetionResult = (expectation: XCTestExpectation, cancellable: AnyCancellable)
    
    func expectValue<T: Publisher>(of publisher: T,
                                   timeout: TimeInterval = 2,
                                   file: StaticString = #file,
                                   line: UInt = #line,
                                   equals: [(T.Output) -> Bool])
        -> CompetionResult {
            let exp = expectation(description: "Correct values of " + String(describing: publisher))
            var mutableEquals = equals
            let cancellable = publisher
                .sink(receiveCompletion: { _ in },
                      receiveValue: { value in
                        if mutableEquals.first?(value) ?? false {
                            _ = mutableEquals.remove(at: 0)
                            print(mutableEquals)
                            if mutableEquals.isEmpty {
                                exp.fulfill()
                            }
                        }
                })
            return (exp, cancellable)
    }
}
