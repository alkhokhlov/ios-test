//
//  CallFilter.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/7/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import Combine
import SwiftUI

enum CallFilter: String, CaseIterable, Identifiable, Equatable {
    case inbox
    case all
    
    var id: Int {
        switch self {
        case .all:
            return 1
        case .inbox:
            return 0
        }
    }
    
    var localizedString: LocalizedStringKey {
        switch self {
        case .all:
            return LocalizedStringKey(stringLiteral: "All")
        case .inbox:
            return LocalizedStringKey(stringLiteral: "Inbox")
        }
    }
}
