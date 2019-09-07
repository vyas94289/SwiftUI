//
//  ToDosService.swift
//  ToDos
//
//  Created by Gaurang Vyas on 07/09/19.
//  Copyright © 2019 Gaurang Vyas. All rights reserved.
//

import Foundation
import Moya

enum ToDosServices {
    case posts
}

extension ToDosServices: TargetType {
    
    
    var task: Task {
        switch self {
        case .posts:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    //https://jsonplaceholder.typicode.com/posts

    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .posts:
            return "posts"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .posts:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
}


