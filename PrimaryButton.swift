//
//  PrimaryButton.swift
//  StrataPanel
//
//  Created by Gaurang on 11/04/23.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    @Binding var isLoading: Bool
    private let feedbackGeneratorDown = UIImpactFeedbackGenerator(style: .light)
    private let feedbackGeneratorUp = UIImpactFeedbackGenerator(style: .medium)
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(height: 50)
            .frame(maxWidth: isLoading ? 50 : .infinity)
            .background(!isEnabled ? Color(app: .extraLightBlue) : Color(app: .primary))
            .cornerRadius(isLoading ? 25 : 8)
            .foregroundColor(isEnabled ? .white : Color(app: .placeholder))
            .font(.app(of: 16, weight: .medium))
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

struct PrimaryButton: View {
    let title: String
    @Binding var isLoading: Bool
    let action: () -> Void
    
    init(
        title: String,
        isLoading: Binding<Bool> = .constant(false),
        action: @escaping () -> Void
    ) {
        self.title = title
        self._isLoading = isLoading
        self.action = action
    }

    var body: some View {
        ZStack {
            Button(action: action, label: {
                ZStack {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color(app: .primary)))
                    } else {
                        Text(title)
                    }
                }
            })
            .buttonStyle(PrimaryButtonStyle(isLoading: $isLoading))
            .animation(.default, value: isLoading)
        }
        .frame(maxWidth: .infinity)
        .disabled(isLoading)
        
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton(title: "Login", isLoading: .constant(false), action: {
            
        })
    }
}


struct SecondaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    @Binding var isLoading: Bool
    private let feedbackGeneratorDown = UIImpactFeedbackGenerator(style: .light)
    private let feedbackGeneratorUp = UIImpactFeedbackGenerator(style: .medium)
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(height: 50)
            .frame(maxWidth: isLoading ? 50 : .infinity)
            .background(!isEnabled ? Color(app: .buttonDisabled) : Color(app: .extraLightBlue))
            .cornerRadius(isLoading ? 25 : 8)
            .foregroundColor(isEnabled ? Color(app:.grayText) : Color(app: .placeholder))
            .font(.app(of: 16, weight: .medium))
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

struct SecondaryButton: View {
    let title: String
    @Binding var isLoading: Bool
    let action: () -> Void
    
    init(
        title: String,
        isLoading: Binding<Bool> = .constant(false),
        action: @escaping () -> Void
    ) {
        self.title = title
        self._isLoading = isLoading
        self.action = action
    }

    var body: some View {
        ZStack {
            Button(action: action, label: {
                ZStack {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    } else {
                        Text(title)
                    }
                }
            })
            .buttonStyle(SecondaryButtonStyle(isLoading: $isLoading))
            .animation(.default, value: isLoading)
        }
        .frame(maxWidth: .infinity)
        
    }
}
