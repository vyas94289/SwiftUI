//
//  RequestParameters.swift
//  StrataPanel
//
//  Created by Gaurang on 12/04/23.
//

import Foundation

struct RequestParameters {
    let parameter: [String: Any]
    
    init(_ dictionary: [String : Any]) {
        self.parameter = dictionary
    }
    
    init<T: Encodable>(_ encodable: T) {
        do {
            self.parameter = try encodable.convertToDict()
        } catch {
            print(error)
            fatalError(error.localizedDescription)
        }
    }
    
}

extension RequestParameters {
    
    func makeRequest(withURL url: URL, encoding: ApiService.Encoding) throws -> URLRequest {
        switch encoding {
        case .url:
            return try URLRequest(url: self.parameter.urlEncoding(url: url))
        case .json:
            var request = URLRequest(url: url)
            request.httpBody = try parameter.jsonEncodedData()
            return request
        case .percentage:
            var request = URLRequest(url: url)
            request.httpBody = parameter.percentEncoded()
            return request
        }
       
    }
}
