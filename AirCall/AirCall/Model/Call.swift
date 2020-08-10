//
//  Call.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/7/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

class Call: Identifiable {
    let id: Int
    let direction: Direction
    let from: String
    let to: String?
    let via: String
    let duration: String
    let callType: CallType
    let createdAt: Date
    var isArchived: Bool
    var shouldArchive = false
    
    var title: String {
        return direction == .inbound ? from : (to ?? "No number")
    }
    
    var description: LocalizedStringKey {
        switch callType {
        case .missed:
            return LocalizedStringKey("missed")
        case .voicemail:
            return LocalizedStringKey("left a voicemail")
        case .answered:
            let text: String
            if direction == .outbound {
                text = from
            } else {
                text = to ?? "Anonymous"
            }
            return LocalizedStringKey("by \(text)")
        }
    }
    
    var createdAtFormatted: String {
        return DateConverter.textTime(createdAt)
    }
    
    init(id: Int,
         direction: Direction,
         from: String,
         to: String,
         via: String,
         duration: String,
         callType: CallType,
         createdAt: Date,
         isArchived: Bool) {
        self.id = id
        self.direction = direction
        self.from = from
        self.to = to
        self.via = via
        self.duration = duration
        self.callType = callType
        self.createdAt = createdAt
        self.isArchived = isArchived
    }
    
    init?(response: CallResponse) {
        guard let direction = Direction(rawValue: response.direction),
            let callType = CallType(rawValue: response.callType),
            let createdAt = DateConverter.date(from: response.createdAt) else {
                return nil
        }
        self.id = response.id
        self.direction = direction
        self.from = response.from
        self.to = response.to
        self.via = response.via
        self.duration = response.duration
        self.callType = callType
        self.createdAt = createdAt
        self.isArchived = response.isArchived
    }
    
    init?(entity: CallEntity) {
        guard let directionValue = entity.direction,
            let direction = Direction(rawValue: directionValue),
            let callTypeValue = entity.callType,
            let callType = CallType(rawValue: callTypeValue),
            let createdAt = entity.createdAt,
            let from = entity.from,
            let via = entity.via,
            let duration = entity.duration
         else {
                return nil
        }
        self.id = Int(entity.id)
        self.direction = direction
        self.from = from
        self.to = entity.to
        self.via = via
        self.duration = duration
        self.callType = callType
        self.createdAt = createdAt
        self.isArchived = entity.isArchived
        self.shouldArchive = entity.shouldArchive
    }
    
    enum CallType: String, Equatable {
        case missed = "missed"
        case answered = "answered"
        case voicemail = "voicemail"
    }
    
    enum Direction: String, Equatable {
        case inbound = "inbound"
        case outbound = "outbound"
    }
}
