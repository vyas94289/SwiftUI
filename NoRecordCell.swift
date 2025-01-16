//
//  NoRecordCell.swift
//  StrataPanel
//
//  Created by Gaurang on 09/08/23.
//

import SwiftUI

struct NoRecordCell: View {
    let message: String
    init(_ message: String) {
        self.message = message
    }
    var body: some View {
        Text(message)
            .font(.app(of: 16, weight: .medium))
            .frame(maxWidth: .infinity)
            .padding(10)
            .cardBackStyle()
    }
}

struct NoRecordCell_Previews: PreviewProvider {
    static var previews: some View {
        NoRecordCell("")
    }
}
