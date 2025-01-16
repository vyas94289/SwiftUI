//
//  View+Ext.swift
//  StrataPanel
//
//  Created by Gaurang on 05/04/23.
//

import Foundation
import SwiftUI

extension View {
    
    func infinityFrame(alignment: Alignment = .center) -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
    
    func dropShadowOverlay(padding: CGFloat, color: Color = .white) -> some View {
        self.overlay(
            VStack() {
                LinearGradient(gradient: Gradient(colors: [color, .clear]),
                               startPoint: .top,
                               endPoint: .bottom)
                .frame(height: padding, alignment: .top)
                Spacer()
                LinearGradient(gradient: Gradient(colors: [.clear, color]),
                               startPoint: .top,
                               endPoint: .bottom)
                .frame(height: padding, alignment: .top)
            }.ignoresSafeArea()
        )
    }
    
    @ViewBuilder
    func ifPresent<C: View>(
        condition: @autoclosure () -> Bool,
        content: (_ view: Self) -> C
    ) -> some View {
        if condition() {
            content(self)
        }
    }
    
    @ViewBuilder
    func redacted(if condition: @autoclosure () -> Bool) -> some View {
        redacted(reason: condition() ? .placeholder : [])
    }
    
    @ViewBuilder
    func removeSheetBackground() -> some View {
        if #available(iOS 16.4, *) {
            self.presentationBackground(Color.clear)
        } else {
            self
        }
    }
    
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
    
    func doneToolbar() -> some View {
        self.toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            }
        }
    }
}

extension Text {
    func textStyle(
        size: CGFloat,
        weight: AppFonts,
        color: AppColor
    ) -> Text {
        self.font(.app(of: size, weight: weight))
            .foregroundColor(Color(app: color))
    }
}

extension View {
    func textStyle(
        size: CGFloat,
        weight: AppFonts,
        color: AppColor
    ) -> some View {
        self.font(.app(of: size, weight: weight))
            .foregroundColor(Color(app: color))
    }
}

extension GeometryProxy {
    var width: CGFloat {
        self.size.width
    }
    var height: CGFloat {
        self.size.height
    }
}
