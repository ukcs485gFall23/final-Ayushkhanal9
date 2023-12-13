//
//  ColorStyler.swift
//  OCKSample
//
//  Created by Corey Baker on 10/16/21.
//  Copyright © 2021 Network Reconnaissance Lab. All rights reserved.
//

import CareKitUI
import UIKit

struct ColorStyler: OCKColorStyler {
    #if os(iOS)
    var label: UIColor {
        .black
    }
    var tertiaryLabel: UIColor {
        .gray
    }
    var primaryLabel: UIColor {
        .blue
    }

    #endif
}
