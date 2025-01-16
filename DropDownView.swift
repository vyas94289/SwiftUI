//
//  DropDownView.swift
//  StrataPanel
//
//  Created by Gaurang on 07/04/23.
//

import SwiftUI

enum DropDownStyle {
    case plain
    case bordered
}

struct DropDownView<T: Equatable>: View {
    let title: String
    let items: [T]
    let style: DropDownStyle
    @Binding var selectedItem: T?
    let titleForItem: (_ item: T) -> String
    
    var body: some View {
        Menu {
            ForEach(0..<items.count, id: \.self) { index in
                Button(titleForItem(items[index])) {
                    Helper.triggerTouchHaptic()
                    selectedItem = items[index]
                }
                .contentShape(Rectangle())
            }
        } label: {
            let title = selectedItem == nil ? title : titleForItem(selectedItem!)
            if style == .bordered {
                ThemeInputContainer {
                    Text(title)
                        .font(.app(of: 16, weight: .regular))
                        .lineLimit(1)
                        .frame(maxWidth: .infinity)
                    Image(asset: .downArrow)
                }
                .foregroundColor(selectedItem == nil ? Color(app: .placeholder) : Color.black)
            } else {
                HStack(spacing: 8) {
                    Text(title)
                        .font(.app(of: 12, weight: .medium))
                   
                        .frame(maxWidth: .infinity)
                    Image(asset: .downArrow).renderingMode(.template)
                }
                .foregroundColor(selectedItem == nil ? Color(app: .grayText) : Color.black)
                .frame(maxHeight: .infinity)
            }
        }
        .id(UUID())
    }
}

//#if DEBUG
//private struct DropDownViewPreview: View {
//    @State var selectedItem: String?
//    let items = ["Male", "Female"]
//    var body: some View {
//        ZStack {
//            DropDownView(
//                title: "Select Gender",
//                items: items,
//                style: .plain,
//                selectedItem: $selectedItem)
//            .padding(30)
//        }
//        .infinityFrame()
//
//    }
//}

//struct DropDownView_Previews: PreviewProvider {
//    static var previews: some View {
//        DropDownViewPreview()
//    }
//}
//#endif

