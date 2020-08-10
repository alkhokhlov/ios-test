//
//  APICall.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/7/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import Foundation

// MARK: - APICall

protocol APIEndpoint {
    var path: String { get }
    var parameters: [String: String]? { get }
    var method: APIMethod { get }
    var headers: [String: String]? { get }
    
    func body() throws -> Data?
}

extension APIEndpoint {
    func urlRequest(baseURL: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + path),
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw APIError.invalidURL
        }
        if let parameters = parameters {
            urlComponents.setQueryItems(with: parameters)
        }
        guard let completedURL = urlComponents.url else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: completedURL)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if let body = try body() {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = body
        }
        
        return request
    }
}

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    
}

// MARK: - APIError

enum APIError: Swift.Error, LocalizedError {
    case invalidURL
    case httpCode(HTTPCode)
    case unexpectedResponse
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case let .httpCode(code):
            return "Unexpected HTTP code: \(code)"
        case .unexpectedResponse:
            return "Unexpected response from the server"
        }
    }
}

// MARK: - APIMethod

enum APIMethod: String {
    case get = "GET"
    case post = "POST"
}

// MARK: - HTTPCodes

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}
