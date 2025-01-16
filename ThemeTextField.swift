//
//  ThemeTextField.swift
//  StrataPanel
//
//  Created by Gaurang on 06/04/23.
//

import SwiftUI

struct ThemeTextField: View {
    let icon: Image?
    let title: String
    var secureEntry: Bool = false
    @Binding var value: String
    @Binding var error: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            ThemeInputContainer {
                if let icon {
                    icon
                        .renderingMode(.template)
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 20)
                        .foregroundColor(value.isEmpty ? Color(app: .inputBorder) : Color(app: .primary))
                }
                if secureEntry {
                    SecureField(title, text: $value)
                } else {
                    TextField(title, text: $value)
                }
            }
            .animation(.default, value: value)
            
            if let error {
                Text(error)
                    .foregroundColor(Color(app: .red))
                    .font(.app(of: 14, weight: .regular))
            }
        }
        .font(.app(of: 16, weight: .regular))
        .animation(.default, value: error)
    }
}

struct ThemeTextField_Previews: PreviewProvider {
    static var previews: some View {
        ThemeTextField(icon: Image(systemName: "envelope"), title: "Email", value: .constant(""), error: .constant("Please enter email"))
            .padding(30)
            .infinityFrame()
            .background(Color.red.opacity(0.1))
            
    }
}
