//
//  TaskID.swift
//  OCKSample
//
//  Created by Corey Baker on 4/14/23.
//  Copyright © 2023 Network Reconnaissance Lab. All rights reserved.
//

import Foundation

enum TaskID {
    static let selfReflection = "doxylamine"
    static let sadCounter = "nausea"
    static let stretch = "stretch"
    static let kegels = "kegels"
    static let steps = "steps"

    static var ordered: [String] {
        [Self.steps, Self.selfReflection, Self.kegels, Self.stretch, Self.sadCounter]
    }
}
