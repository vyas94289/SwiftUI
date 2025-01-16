//
//  DashedLine.swift
//  StrataPanel
//
//  Created by Gaurang on 31/07/23.
//

import SwiftUI

struct DashedLine: View {
    let axis: Axis
    init(_ axis: Axis) {
        self.axis = axis
    }
    var body: some View {
        Line(axis)
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
            .foregroundColor(Color(app: .documentBorder))
            .frame(
                width: axis == .horizontal ? nil : 1,
                height: axis == .vertical ? nil : 1)
    }
}

struct DashedLine_Previews: PreviewProvider {
    static var previews: some View {
        DashedLine(.vertical)
    }
}
