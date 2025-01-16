//
//  BounceButtonStyle.swift
//  StrataPanel
//
//  Created by Gaurang on 06/04/23.
//

import Foundation
import SwiftUI

struct BounceButtonStyle: ButtonStyle {
    private let feedbackGeneratorDown = UIImpactFeedbackGenerator(style: .light)
    private let feedbackGeneratorUp = UIImpactFeedbackGenerator(style: .medium)
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
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

enum ActionButtonType {
    case primary
    case positive
    case destructive
    case orange
    case gray
    
    var color: Color {
        switch self {
        case .primary:
            return Color(app: .primary)
        case .positive:
            return Color(app: .green)
        case .destructive:
            return Color(app: .redLight)
        case .orange:
            return Color(app: .orange)
        case .gray:
            return Color(app: .lightGray)
        }
    }
}

struct ActionButtonStyle: ButtonStyle {
    let style: ActionButtonType
    
    init(_ style: ActionButtonType) {
        self.style = style
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .frame(height: 35)
            .background(style.color)
            .clipShape(Capsule())
            .font(.app(of: 12, weight: .bold))
            .foregroundColor(Color(app: .white))
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

struct SmallActionButtonStyle: ButtonStyle {
    var color: Color = Color(app: .redLight)
    var fontSize: CGFloat = 10
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.app(of: fontSize, weight: .bold))
            .foregroundColor(.white)
            .padding(.horizontal, 15)
            .padding(.vertical, 8)
            .background(color)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

struct UnderlineButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.app(of: 11, weight: .regular))
            .foregroundColor(Color(app: .lightBlue))
            .underline()
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

struct LightBlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.app(of: 13, weight: .medium))
            .foregroundColor(Color(app: .lightBlue))
            .frame(height: 34)
            .frame(maxWidth: .infinity)
            .background(Color(app: .extraLightBlue))
            .cornerRadius(6)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

struct RoundedRectButtonStyle: ButtonStyle {
    let color: AppColor
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .textStyle(size: 13, weight: .medium, color: .white)
            .frame(height: 34)
            .frame(maxWidth: .infinity)
            .background(Color(app: color))
            .cornerRadius(6)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

struct SquareButtonStyle: ButtonStyle {
    private let feedbackGeneratorDown = UIImpactFeedbackGenerator(style: .light)
    private let feedbackGeneratorUp = UIImpactFeedbackGenerator(style: .medium)
    let color: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .frame(width: 28, height: 28)
            .background(color)
            .cornerRadius(7)
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

struct HapticButtonStyle: ButtonStyle {
    private let feedbackGeneratorDown = UIImpactFeedbackGenerator(style: .light)
    private let feedbackGeneratorUp = UIImpactFeedbackGenerator(style: .light)
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .contentShape(Rectangle())
            .onChange(of: configuration.isPressed, perform: { value in
                if value {
                    feedbackGeneratorDown.prepare()
                    feedbackGeneratorDown.impactOccurred()
                } 
            })
    }
}

#if DEBUG
struct Button_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Button("T") {
                
            }.buttonStyle(RoundedRectButtonStyle(color: .lightBlue))
                
        }.padding(100)
    }
}
#endif
