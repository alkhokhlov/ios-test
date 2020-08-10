//
//  NetworkManager.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/7/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import Foundation
import Combine

protocol NetworkManager {
    var session: URLSession { get }
    var baseURL: String { get }
}

extension NetworkManager {
    func load<Value>(endpoint: APIEndpoint, httpCodes: HTTPCodes = .success) -> AnyPublisher<Value, Error> where Value: Decodable {
        do {
            let request = try endpoint.urlRequest(baseURL: baseURL)
            return session
                .dataTaskPublisher(for: request)
                .tryMap({ data, response in
                    guard let code = (response as? HTTPURLResponse)?.statusCode else {
                        throw APIError.unexpectedResponse
                    }
                    guard HTTPCodes.success.contains(code) else {
                        throw APIError.httpCode(code)
                    }
                    return data
                })
                .decode(type: Value.self, decoder: JSONDecoder())
                .mapError({ (error) -> Error in
                    switch error {
                    case is Swift.DecodingError:
                        return APIError.unexpectedResponse
                    default:
                        return error
                    }
                })
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } catch let error {
            return Fail<Value, Error>(error: error).eraseToAnyPublisher()
        }
    }
}
