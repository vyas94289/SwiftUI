//
//  CheckMarkView.swift
//  StrataPanel
//
//  Created by Gaurang on 09/05/23.
//

import SwiftUI

struct CheckMarkView: View {
    let title: String
    var fontSize: CGFloat = 14
    @Binding var isChecked: Bool
    var didChange: (() -> Void)?
    var body: some View {
        HStack(spacing: 4) {
            Button(action: {
                if didChange == nil {
                    withAnimation {
                        isChecked.toggle()
                    }
                } else {
                    didChange?()
                }
            }, label: {
                if isChecked {
                    Image(systemName: "checkmark.square.fill")
                        .foregroundColor(Color(app: .lightBlue))
                        .font(.system(size: 20))
                } else {
                    Image(systemName: "square")
                        .foregroundColor(Color(app: .historyCircle))
                        .font(.system(size: 20))
                }
            })
            Text(.init(title)).textStyle(size: fontSize, weight: .regular, color: .black)
        }
        .font(.system(size: 17))
    }
}

struct CheckMarkView_Previews: PreviewProvider {
    static var previews: some View {
        CheckMarkView(title: "Mark as urgent", isChecked: .constant(false))
    }
}
