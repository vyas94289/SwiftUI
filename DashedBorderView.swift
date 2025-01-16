//
//  DashedBorderView.swift
//  StrataPanel
//
//  Created by Gaurang on 08/05/23.
//

import SwiftUI

struct DashedBorderView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
            .foregroundColor(Color(app: .documentBorder))
            .background(Color(app: .documentBack).cornerRadius(8))
            
    }
}

struct DashedBorderView_Previews: PreviewProvider {
    static var previews: some View {
        DashedBorderView()
            .frame(width: 200, height: 100)
    }
}
