//
//  ErrorView.swift
//  StarWar
//
//  Created by Gaurang on 27/03/23.
//

import SwiftUI

enum MessageType {
    case error
    case noRecords
    case noTransaction
}

struct ErrorView: View {
    
    struct Message {
        let type: MessageType
        let text: String
        let onRetry: (() -> Void)?
    }
    
    let message: Message
    
    init(_ message: Message) {
        self.message = message
    }
    
    var body: some View {
        VStack(spacing: 16) {
            if message.type == .noTransaction {
                Image("noTransaction")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: Helper.screenSize.width * 0.6)
            } else {
                Image(asset: .noRecords)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: Helper.screenSize.width * 0.6)
            }
            Text(message.text)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            if let onRetry = message.onRetry {
                Button(action: onRetry) {
                    HStack {
                        Image(systemName: "gobackward")
                        Text("Retry")
                    }
                }.buttonStyle(.bordered)
            }
            
        }
        .padding(Helper.padding)
        .infinityFrame()
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(.init(type: .noRecords, text: "No records", onRetry: nil))
    }
}
