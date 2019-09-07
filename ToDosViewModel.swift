//
//  ToDosViewModel.swift
//  ToDos
//
//  Created by Gaurang Vyas on 07/09/19.
//  Copyright © 2019 Gaurang Vyas. All rights reserved.
//

import Combine
import Foundation
import Moya

struct ToDo: Codable {
    let id: Int
    let title: String
    let body: String
}

public class ToDosViewModel: ObservableObject {
  
    public let willChange = PassthroughSubject<ToDosViewModel, Never>()
    let toDosProvider = MoyaProvider<ToDosServices>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    @Published var toDosArray: [ToDo] = [ToDo]() {
        didSet {
            willChange.send(self)
        }
    }
    
    func load() {
        toDosProvider.request(.posts) { result in
            switch result{
            case let .success(response):
                do{
                    self.toDosArray = try JSONDecoder().decode([ToDo].self, from: response.data)
                }catch let error{
                    print("Error at \(#function) & Error is: \(error.localizedDescription)")
                }
                break
            case let .failure(error):
                print("Error at \(#function) & Error is: \(error.localizedDescription)")
                break
            }
        }
    }
}

