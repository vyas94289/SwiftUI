//
//  LoadingView.swift
//  StrataPanel
//
//  Created by Gaurang on 03/05/23.
//

import SwiftUI

struct LoadingView: View {
    let message: String
    init(_ message: String = "Fetching") {
        self.message = message
    }
    var body: some View {
        LottieView(asset: "loader")
    }
}
#if DEBUG
struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
#endif
