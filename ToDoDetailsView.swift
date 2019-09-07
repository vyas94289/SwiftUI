//
//  ToDoDetailsView.swift
//  ToDos
//
//  Created by Gaurang Vyas on 07/09/19.
//  Copyright © 2019 Gaurang Vyas. All rights reserved.
//


import SwiftUI

struct ToDosDetailsView: View {
    var toDo:ToDo!
    
    var body: some View {
        VStack(alignment: .leading){
            Text(toDo.title).lineLimit(5)
            Text(toDo.body).font(.subheadline).foregroundColor(.gray)
            Spacer()
        }
        .padding()
        .navigationBarTitle("ToDo Details")
    }
}
