//
//  CareKitCard.swift
//  OCKSample
//
//  Created by Corey Baker on 10/26/23.
//  Copyright © 2023 Network Reconnaissance Lab. All rights reserved.
//

import Foundation

enum CareKitCard: String, CaseIterable, Identifiable {
    var id: Self { self }
    case button = "Button"
    case checklist = "Checklist"
    case featured = "Featured"
    case grid = "Grid"
    case instruction = "Instruction"
    case labeledValue = "Labeled Value"
    case link = "Link"
    case numericProgress = "Numeric Progress"
    case simple = "Simple"
}
