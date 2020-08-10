//
//  DependencyManager.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/7/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import Foundation

enum DependencyProvider {
    
    static let urlSession = URLSession.shared
    static let coreDataStack = CoreDataStack.shared
    
    static var airCallGateway: AirCallGateway {
        return AirCallGatewayImpl(session: urlSession,
                                  baseURL: "https://aircall-job.herokuapp.com")
    }
    
    static var callRepository: CallRepository {
        return CallRepositoryImpl(persistanceStore: coreDataStack)
    }
        
    static var callListInteractor: CallListInteractor {
        return CallListInteractor(gateway: airCallGateway, repository: callRepository)
    }
    
    static var callDetailInteractor: CallDetailInteractor {
        return CallDetailInteractor(gateway: airCallGateway, repository: callRepository)
    }
    
    static var callExample: Call {
        Call(id: 7834,
             direction: .inbound,
             from: "Pierre-Baptiste Béchu",
             to: "06 46 62 12 33",
             via: "NYC Office",
             duration: "120",
             callType: .missed,
             createdAt: DateConverter.date(from: "2018-04-19T09:38:41.000Z")!,
             isArchived: false)
    }
    
    static func callResponseExample(isArchived: Bool) -> CallResponse {
        CallResponse(id: 7834,
                     direction: "inbound",
                     from: "Pierre-Baptiste Béchu",
                     to: "06 46 62 12 33",
                     via: "NYC Office",
                     duration: "120",
                     callType: "missed",
                     createdAt: "2018-04-19T09:38:41.000Z",
                     isArchived: isArchived)
    }
    
}
