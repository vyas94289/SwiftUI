//
//  ImageButton.swift
//  StrataPanel
//
//  Created by Gaurang on 23/11/23.
//

import SwiftUI

struct ImageButton: View {
    let axis: Axis
    let image: Image
    let title: String?
    let isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            withAnimation {
                action()
            }
        }, label: {
            ZStack {
                if axis == .horizontal {
                    HStack(spacing: 15) {
                        Spacer(minLength: 0)
                        content
                            .multilineTextAlignment(.center)
                        Spacer(minLength: 0)
                    }
                } else {
                    VStack(spacing: 15) {
                        content
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                            .padding(.horizontal, 6)
                    }
                }
            }
            .padding(.vertical, 15)
            .frame(height: axis == .horizontal ? 92 : 111)
            .frame(maxWidth: .infinity)
            .selectionButtonButtonStyle(isSelected)
        })
        .buttonStyle(HapticButtonStyle())
        
    }
    
    @ViewBuilder
    var content: some View {
        image
            .frame(maxHeight: .infinity)
        if let title {
            Text(title)
                .textStyle(
                    size: 16,
                    weight: .medium,
                    color: isSelected ? .lightBlue : .black
                )
                
        }
    }
}

extension View {
    @ViewBuilder
    func selectionButtonButtonStyle(_ isSelected: Bool) -> some View {
        self.background(isSelected ? Color(app: .extraLightBlue) : Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(
                cornerRadius: 8
            ).stroke(Color(app: isSelected ? .lightBlue : .inputBorder), lineWidth: 1)
        )
    }
}

#Preview {
    TitleContentView("Where Do you want to go? *") {
        HStack(spacing: 10) {
            ForEach(VisitAreaType.allCases) { item in
                ImageButton(axis: .vertical,
                            image: Image(item.iconName),
                            title: item.title,
                            isSelected: false
                ) {
                   
                }
            }
            
        }
    }
    .padding(20)
}
