//
//  Line.swift
//  StrataPanel
//
//  Created by Gaurang on 09/05/23.
//

import SwiftUI

struct Line: Shape {
    let axis: Axis
    init(_ axis: Axis) {
        self.axis = axis
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        if axis == .horizontal {
            path.addLine(to: CGPoint(x: rect.width, y: 0))
        } else {
            path.addLine(to: CGPoint(x: 0, y: rect.height))
        }
        return path
    }
}

