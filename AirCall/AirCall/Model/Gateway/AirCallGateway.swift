//
//  AirCallNetworkManager.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/7/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import Foundation
import Combine

protocol AirCallGateway: NetworkManager {
    func loadCalls() -> AnyPublisher<[CallResponse], Error>
    func reset() -> AnyPublisher<DoneResponse, Error>
    func archive(_ call: Call) -> AnyPublisher<CallResponse, Error>
}

class AirCallGatewayImpl: AirCallGateway {
    let session: URLSession
    let baseURL: String
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func loadCalls() -> AnyPublisher<[CallResponse], Error> {
        return load(endpoint: API.getCalls)
    }
    
    func archive(_ call: Call) -> AnyPublisher<CallResponse, Error> {
        return load(endpoint: API.archive(call))
    }
    
    func reset() -> AnyPublisher<DoneResponse, Error> {
        return load(endpoint: API.reset)
    }
}

// MARK: - Endpoints

extension AirCallGatewayImpl {
    enum API {
        case getCalls
        case archive(Call)
        case reset
    }
}

extension AirCallGatewayImpl.API: APIEndpoint {
    
    var path: String {
        switch self {
        case .getCalls:
            return "/activities"
        case .archive(let call):
            return "/activities/\(call.id)"
        case .reset:
            return "/reset"
        }
    }
    
    var parameters: [String : String]? {
        return nil
    }
    
    var method: APIMethod {
        switch self {
        case .getCalls, .reset:
            return .get
        case .archive:
            return .post
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    func body() throws -> Data? {
        switch self {
        case .getCalls, .reset:
            return nil
        case .archive:
            let json: [String: Any] = [
                "is_archived" : true
            ]
            return try JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
        }
    }
}
