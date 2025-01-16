//
//  ProfileImageView.swift
//  StrataPanel
//
//  Created by Gaurang on 10/04/23.
//

import SwiftUI
import Kingfisher

struct ProfileImageView: View {
    let url: URL?
    let size: CGFloat
    let borderColor: Color
    
    init(_ url: URL?, size: CGFloat = 40, borderColor: Color = .white) {
        self.url = url
        self.size = size
        self.borderColor = borderColor
    }
    
    init(_ urlString: String?, size: CGFloat = 40, borderColor: Color = .white) {
        self.init(URL(string: urlString ?? ""), size: size, borderColor: borderColor)
    }
    
    var body: some View {
        
        KFImage(url)
            .placeholder({ _ in
                ProfilePlaceholder()
            })
            .fade(duration: 0.3)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size, height: size)
            .background(Color(app: .placeholder))
            .clipShape(Circle())
            .overlay {
                Circle()
                    .strokeBorder(borderColor,lineWidth: 1)
            }
            
    }
}

struct URLImage: View {
    let url: URL?
    
    init(_ url: URL?) {
        self.url = url
    }
    
    init(_ urlString: String) {
        self.url = URL(string: urlString)
    }
    
    var body: some View {
        GeometryReader { proxy in
            KFImage(url)
                .placeholder({ _ in
                    Image(systemName: "photo")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFill()
                        .infinityFrame()
                        .foregroundColor(Color(uiColor: .lightGray).opacity(0.5))
                })
                .fade(duration: 0.3)
                .resizable()
                .scaledToFit()
                .frame(width: proxy.width, height: proxy.height)
        }
    }
}

struct ProfilePlaceholder: View {
    var body: some View {
        GeometryReader { proxy in
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: proxy.width, height: proxy.height)
                .foregroundColor(Color(app: .lightGray))
                .background(Color.white)
                .clipShape(Circle())
            
        }
    }
}

#if DEBUG
struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePlaceholder()
            .frame(width: 100, height: 100)
        URLImage(URL(string: "https://images7.alphacoders.com/344/344d344.jpg"))
            .frame(width: 100, height: 100)
    }
}
#endif
