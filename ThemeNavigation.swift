//
//  ThemeNavigation.swift
//  AlarmtekDemo
//
//  Created by Pratik Zora on 03/10/24.
//

import SwiftUI

// Custom Navigation Container View with dynamic ToolbarItems
struct CustomNavigationView<Content: View>: View {
    var title: String
    var content: Content
    
    init(title: String,
         @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            content
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Toolbar item for title
            ToolbarItem(placement: .principal) {
                Text(title)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
            }
        }
        .toolbarBackground(Color.themePrimary, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        
    }
}
