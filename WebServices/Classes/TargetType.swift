//
//  TargetType.swift
//  SwiftNetworkLayer
//
//  Created by Gaurang Vyas on 29/01/22.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol TargetType {
    
    var baseURL: String { get }

    var path: String { get }

    var method: HttpMethod { get }

    var headers: [String: String] { get }

    var task: ApiTask { get }
}

enum ApiTask {
    case plainRequest
    case withParameters(_ parameter: RequestParameters, encoding: ApiService.Encoding)
    case multipart(parameters: RequestParameters, files: [MimeTypes])
}

extension TargetType {
    var fullUrl: URL? {
        return URL(string: "\(baseURL)/\(path)")
    }
}
