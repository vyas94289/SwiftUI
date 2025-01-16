//
//  TabRootView.swift
//  StrataPanel
//
//  Created by Gaurang on 27/04/23.
//

import SwiftUI

struct TabRootView<Content: View>: View {
    @EnvironmentObject private var userSettings: UserStateViewModel
    let content: Content
    init(_ content: Content) {
        self.content = content
    }
    var body: some View {
        NavigationView {
            content
                .onAppear {
                    userSettings.tabbarVisibility = .visible
                }
        }.navigationViewStyle(.stack)
    }
}

