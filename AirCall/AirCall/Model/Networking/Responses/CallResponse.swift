//
//  CallResponse.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/7/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import Foundation

struct CallResponse: Codable, Identifiable {
    let id: Int
    let direction: String
    let from: String
    let to: String?
    let via: String
    let duration: String
    let callType: String
    let createdAt: String
    let isArchived: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case direction
        case from
        case to
        case via
        case duration
        case callType = "call_type"
        case createdAt = "created_at"
        case isArchived = "is_archived"
    }
}
