//
//  AppDatePickerView.swift
//  StrataPanel
//
//  Created by Gaurang on 22/11/23.
//

import SwiftUI

struct AppDatePickerView: View {
    let selectedDate: Date?
    var displayComponents: DatePicker.Components = [.date]
    let onSelect: (_ date: Date) -> Void
    @State private var date: Date = .now
    @State private var height: CGFloat = 470
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            DatePicker("", selection: $date, displayedComponents: displayComponents)
                .labelsHidden()
                .datePickerStyle(.graphical)
            HStack(spacing: 20) {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Cancel")
                        .frame(maxWidth: .infinity, maxHeight: 36)
                })
                .buttonStyle(.bordered)
                Button(action: {
                    onSelect(date)
                    dismiss()
                }, label: {
                    Text("Select")
                        .frame(maxWidth: .infinity, maxHeight: 36)
                })
                .buttonStyle(.borderedProminent)
            }.font(Font.app(of: 18, weight: .medium))
        }
        .padding(20)
        .presentationDragIndicator(.visible)
        .background(content: {
            GeometryReader(content: { geometry in
                Color.clear
                    .onAppear {
                        height = geometry.height + 90
                    }
            })
        })
        .presentationDetents([.height(height)])
        
        .onAppear {
            if let selectedDate {
                date = selectedDate
            }
        }
    }
}

struct DatePickerButton<Content: View>: View {
    @Binding var date: Date?
    @ViewBuilder let label: () -> Content
    @State private var showPicker: Bool = false
    var body: some View {
        Button(action: {
            showPicker = true
        }, label: label)
        .sheet(isPresented: $showPicker, content: {
            AppDatePickerView(
                selectedDate: date,
                onSelect: { date in
                    self.date = date
                }
            )
        })
    }
}

#Preview {
    DatePickerButton(date: .constant(.now)) {
        Text("show")
    }
}
