//
//  AuthBackgroundGradient.swift
//  StrataPanel
//
//  Created by Gaurang on 06/04/23.
//

import SwiftUI

struct AuthBackgroundGradient: View {
    var body: some View {
        LinearGradient(
            colors: [
                Color(app: .background),
                Color(app: .background),
                Color.white
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
    }
}

struct AuthBackgroundGradient_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AuthBackgroundGradient()
                .padding(.bottom, 100)
        }
        .background(Color.init(app: .background))
        
    }
}
