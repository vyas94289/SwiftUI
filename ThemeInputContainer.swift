//
//  ThemeInputContainer.swift
//  StrataPanel
//
//  Created by Gaurang on 07/04/23.
//

import SwiftUI

struct ThemeInputContainer<Content: View>: View {
    @Environment(\.isEnabled) private var isEnabled
    var height: CGFloat? = 50
    @ViewBuilder let content: () -> Content
   
    var body: some View {
        HStack(spacing: 16, content: content)
        .padding(.horizontal, 16)
        .frame(height: height)
        .frame(maxWidth: .infinity)
        .background(isEnabled ? Color.white : Color(app: .backgroundLight))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(
                cornerRadius: 8
            ).stroke(Color(app: .inputBorder), lineWidth: 1)
        )
    }
}

struct ThemeInputContainer_Previews: PreviewProvider {
    static var previews: some View {
        ThemeInputContainer {
            Text("Enter name")
        }
        .padding(30)
        .disabled(true)
    }
}
