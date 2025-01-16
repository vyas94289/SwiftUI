//
//  BorderdButton.swift
//  StrataPanel
//
//  Created by Gaurang on 12/11/23.
//

import Foundation
import SwiftUI

struct BorderdeButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    private let feedbackGeneratorDown = UIImpactFeedbackGenerator(style: .light)
    private let feedbackGeneratorUp = UIImpactFeedbackGenerator(style: .medium)
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(app: .primary), lineWidth: 1)
            )
            .foregroundColor(Color(app: .primary))
            .font(.app(of: 16, weight: .medium))
            .contentShape(Rectangle())
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .onChange(of: configuration.isPressed, perform: { value in
                if value {
                    feedbackGeneratorDown.prepare()
                    feedbackGeneratorDown.impactOccurred()
                } else {
                    feedbackGeneratorUp.prepare()
                    feedbackGeneratorUp.impactOccurred()
                }
            })
    }
}



struct BorderedButton_Previews: PreviewProvider {
    static var previews: some View {
        Button("Login") {
            
        }.buttonStyle(BorderdeButtonStyle())
    }
}
