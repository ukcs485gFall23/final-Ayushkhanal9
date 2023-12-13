//
//  TintColorFlipKey.swift
//  OCKSample
//
//  Created by Corey Baker on 9/26/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import Foundation
import SwiftUI

struct TintColorFlipKey: EnvironmentKey {
    static var defaultValue: UIColor {
        #if os(iOS)
        return UIColor { $0.userInterfaceStyle == .light ?  #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1) : #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1) }
        #else
        return #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        #endif
    }
}

extension EnvironmentValues {
    var tintColorFlip: UIColor {
        self[TintColorFlipKey.self]
    }
}
