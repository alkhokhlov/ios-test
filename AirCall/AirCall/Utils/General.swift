//
//  General.swift
//  AirCall
//
//  Created by Oleksandr Khokhlov on 8/10/20.
//  Copyright © 2020 Oleksandr Khokhlov. All rights reserved.
//

import Foundation

extension ProcessInfo {
    var isRunningTests: Bool {
        environment["XCTestConfigurationFilePath"] != nil
    }
}
