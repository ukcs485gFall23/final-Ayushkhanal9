//
//  CarePlanID.swift
//  OCKSample
//
//  Created by Aayush Khanal on 12/13/23.
//  Copyright © 2023 Network Reconnaissance Lab. All rights reserved.
//

import Foundation

// xTODO: Add CarePlans specific to your app here.
// If you don't remember what a OCKCarePlan is, read the CareKit docs.
enum CarePlanID: String, CaseIterable, Identifiable {
    var id: Self { self }
    case health // Add custom id's for your Care Plans, these are examples
    case checkIn
    case mentalHealth
    case physicalHealth
}
