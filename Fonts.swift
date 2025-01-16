//
//  Fonts.swift
//  StrataPanel
//
//  Created by Gaurang on 06/04/23.
//

import Foundation
import SwiftUI

enum AppFonts: String {
    case regular  = "DMSans-Regular"
    case medium   = "DMSans-Medium"
    case bold     = "DMSans-Bold"
}

extension Font {
    static func app(of size: CGFloat, weight: AppFonts) -> Font {
        let name = weight.rawValue
        return Font.custom(name, size: size)
    }
}
