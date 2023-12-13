//
//  TaskID.swift
//  OCKSample
//
//  Created by Corey Baker on 4/14/23.
//  Copyright © 2023 Network Reconnaissance Lab. All rights reserved.
//

import Foundation

enum TaskID {
    static let selfReflection = "Meditation"
    static let sadCounter = "sadTracker"
    static let happyCounter = "happyTracker"
    static let stretch = "stretch"
    static let medication = "medication"
    static let steps = "steps"
    static let numProg = "numprog"
    static let journaling = "Journaling"
    static let heartRate = "heartRate"

    static var ordered: [String] {
        [Self.steps, Self.heartRate, Self.selfReflection, Self.medication, Self.stretch, Self.sadCounter, Self.happyCounter, Self.numProg, Self.journaling]
    }
}
