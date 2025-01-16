//
//  LottieView.swift
//  StrataPanel
//
//  Created by Gaurang on 15/05/23.
//

import Foundation
import SwiftUI
import Lottie
 
struct LottieView: UIViewRepresentable {
    let asset: String
 
    let animationView = LottieAnimationView()
 
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
 
        animationView.animation = LottieAnimation.named(asset)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
 
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
 
        return view
    }
 
    func updateUIView(_ uiView: UIViewType, context: Context) {
 
    }
}

#if DEBUG
struct Lottie_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LottieView(asset: "manage-bills")
                .frame(width: 300, height: 300)
        }
        .infinityFrame()
       
    }
}
#endif
