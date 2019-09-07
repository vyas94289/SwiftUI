//
//  ContentView.swift
//  ToDos
//
//  Created by Gaurang Vyas on 07/09/19.
//  Copyright © 2019 Gaurang Vyas. All rights reserved.
//

import SwiftUI

struct ToDosListView: View {
    @ObservedObject var toDosViewModel = ToDosViewModel()
    
    var body: some View {
        NavigationView {
            List{
                ForEach(toDosViewModel.toDosArray, id: \.id) { toDo in
                    NavigationLink(destination: ToDosDetailsView(toDo: toDo)) {
                        VStack(alignment: .leading){
                            Text(toDo.title).lineLimit(2)
                            Text(toDo.body).font(.subheadline).foregroundColor(.gray)
                        }
                    }
                }.onDelete(perform: delete(at:))
            }
            .navigationBarTitle("To Dos")
            .navigationBarItems(trailing: Button(action: {
                self.refreshList()
            }, label: {
                Text("Refresh")
            }))
        }
        .onAppear(perform: refreshList)
    }
    
    func delete(at offsets: IndexSet) {
        toDosViewModel.toDosArray.remove(atOffsets: offsets)
    }
    
    private func refreshList(){
        toDosViewModel.load()
    }
    
}


