//
//  DependencyProviderTests.swift
//  AirCallTests
//
//  Created by Oleksandr Khokhlov on 8/9/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import Foundation

@testable import AirCall

enum DependencyProviderTests {
    
    static var calls = [
        Call(id: 1,
             direction: .inbound,
             from: "from 1",
             to: "to 1",
             via: "via 1",
             duration: "duration 1",
             callType: .answered,
             createdAt: DateConverter.date(from: "2018-04-19T09:38:41.000Z")!,
             isArchived: false),
        Call(id: 2,
             direction: .inbound,
             from: "from 2",
             to: "to 2",
             via: "via 2",
             duration: "duration 2",
             callType: .answered,
             createdAt: DateConverter.date(from: "2018-04-19T09:38:41.000Z")!,
             isArchived: true)
    ]
    static var callResponses: [CallResponse] {
        calls.map({ call in
            CallResponse(id: call.id,
                         direction: call.direction.rawValue,
                         from: call.from,
                         to: call.to,
                         via: call.via,
                         duration: call.duration,
                         callType: call.callType.rawValue,
                         createdAt: DateConverter.iso(call.createdAt),
                         isArchived: call.isArchived)
        })
    }
    static var callKeyValue: String {
        let date = DateConverter.date(from: "2018-04-19T09:38:41.000Z")!
        return DateConverter.monthDay(date)
    }
    
}
