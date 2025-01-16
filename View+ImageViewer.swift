//
//  View+ImageViewer.swift
//  StrataPanel
//
//  Created by Gaurang on 08/05/23.
//

import SwiftUI

extension View {
    
    func bindImageViewer(image: Binding<Image?>, show: Binding<Bool>) -> some View {
        var closeButton: some View {
            
            Button {
                show.wrappedValue = false
            } label: {
                Image(systemName: "xmark")
                    .font(.headline)
                    .padding(8)
                    .foregroundColor(.white)
            }
            .tint(.black)
            .background(.thinMaterial)
            .environment(\.colorScheme, .dark)
            .clipShape(Circle())
            .padding()
        }
        return self.fullScreenCover(isPresented: show) {
            if let image = image.wrappedValue {
                SwiftUIImageViewer(image: image)
                    .overlay(alignment: .topTrailing) {
                        closeButton
                    }
            }
        }
    }
    
}
